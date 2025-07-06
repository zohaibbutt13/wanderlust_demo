require 'rails_helper'

RSpec.describe Projects::ListingService, type: :service do
  let(:client) { FactoryBot.create(:client) }
  let(:project_1) { FactoryBot.create(:project, client: client) }
  let(:project_2) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user, role: :project_manager) }

  let(:params) { ActionController::Parameters.new({ page: 1 }) }
  let(:service) { described_class.new(client, params) }
  let(:service_all) { described_class.new(nil, params) }

  describe '#call' do
    context 'when a client is provided' do
      before do
        project_1
        project_2
      end

      it 'loads only the projects for the client' do
        result = service.call

        expect(result).to include(project_1)
        expect(result).not_to include(project_2)
        expect(result.count).to eq(1)
      end
    end

    context 'when no projects exist for the client' do
      let(:empty_client) { FactoryBot.create(:client) }

      it 'returns an empty collection for the client' do
        empty_service = described_class.new(empty_client, params)
        result = empty_service.call

        expect(result).to be_empty
      end
    end

    context 'when no page parameter is provided' do
      let(:empty_service) { described_class.new(client, ActionController::Parameters.new({})) }

      it 'defaults to page 1' do
        result = empty_service.call

        expect(result.current_page).to eq(1)
      end
    end
  end
end
