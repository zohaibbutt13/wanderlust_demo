require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'associations' do
    it { should have_many(:projects_videos) }
    it { should have_many(:projects).through(:projects_videos) }
    it { should have_one_attached(:file) }
  end

  describe 'validations' do
    it { should validate_length_of(:title).is_at_least(4).is_at_most(255) }
    it { should validate_numericality_of(:cost_in_cents).is_greater_than(0) }
  end

  describe 'scopes' do
    let!(:active_video) { FactoryBot.create(:video, active: true) }
    let!(:inactive_video) { FactoryBot.create(:video, active: false) }

    it 'returns only active videos' do
      expect(Video.active).to include(active_video)
      expect(Video.active).not_to include(inactive_video)
    end
  end

  describe '#acceptable_file' do
    let(:video) { FactoryBot.build(:video) }

    it 'allows valid file types and size' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.mp4'), 'video/mp4')
      video.file.attach(file)

      expect(video).to be_valid
    end

    it 'rejects invalid file type' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/invalid.txt'), 'text/plain')
      video.file.attach(file)

      video.valid?
      expect(video.errors[:file]).to include("must be a valid video format")
    end
    # I have skiped the 100mb validation case on purpose
  end

  describe '#cost_in_usd' do
    it 'converts cents to USD using CurrencyConverterService' do
      converter = instance_double("General::CurrencyConverterService", call: 10.0)
      allow(General::CurrencyConverterService).to receive(:new).and_return(converter)

      video = FactoryBot.build(:video, cost_in_cents: 1000)
      expect(video.cost_in_usd).to eq(10.0)
    end
  end
end
