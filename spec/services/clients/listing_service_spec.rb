require 'rails_helper'

RSpec.describe Clients::ListingService, type: :service do
  describe '#call' do
    before do
      3.times do
        client = FactoryBot.create(:client)
        FactoryBot.create_list(:project, 2, client: client)
      end
    end

    it 'returns paginated clients with project counts' do
      result = described_class.new(page: 1, per_page: 2).call

      expect(result.length).to eq(2)
      expect(result.first).to respond_to(:projects_count)
    end

    it 'defaults to first page if page is nil' do
      result = described_class.new(page: nil, per_page: 2).call

      expect(result.length).to eq(2)
    end

    it 'returns empty result for out-of-range page' do
      result = described_class.new(page: 100, per_page: 10).call

      expect(result).to be_empty
    end
  end
end
