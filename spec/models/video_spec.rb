require 'rails_helper'

RSpec.describe Video, type: :model do
  describe "associations" do
    it { should have_many(:projects_videos) }
    it { should have_many(:projects).through(:projects_videos) }
    it { should have_one_attached(:file) }
  end

  describe "validations" do
    it { should validate_length_of(:title).is_at_least(4).is_at_most(255) }
    it { should validate_numericality_of(:cost_in_cents).is_greater_than(0) }
  end

  describe "#cost_in_usd" do
    let(:video) { FactoryBot.build(:video) }

    it "calls the currency converter service with correct parameters" do
      converter = instance_double("General::CurrencyConverterService", call: 15.0)

      expect(General::CurrencyConverterService).to receive(:new)
        .with(1500, CENTS_CODE, USD_CURRENCY_CODE)
        .and_return(converter)

      expect(video.cost_in_usd).to eq(15.0)
    end
  end
end
