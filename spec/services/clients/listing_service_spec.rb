require 'rails_helper'

RSpec.describe Clients::ListingService, type: :service do
  let!(:client1) { FactoryBot.create(:client) }
  let!(:client2) { FactoryBot.create(:client) }

  before do
    FactoryBot.create_list(:project, 2, client: client1)
    FactoryBot.create(:project, client: client2)
  end

  context "when page param is provided" do
    let(:params) { ActionController::Parameters.new(page: 1) }

    it "returns paginated clients with projects_count" do
      result = described_class.new(params).call

      expect(result.length).to eq(2)
      expect(result.first).to respond_to(:projects_count)
    end
  end

  context "when page param is missing" do
    let(:params) { ActionController::Parameters.new }

    it "defaults to page 1" do
      result = described_class.new(params).call
      expect(result.current_page).to eq(1)
    end
  end
end
