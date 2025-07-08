require 'rails_helper'

RSpec.describe Projects::ListingService, type: :service do
  let(:current_client) { FactoryBot.create(:client) }
  let(:other_client) { FactoryBot.create(:client) }
  let!(:project1) { FactoryBot.create(:project, client: current_client) }
  let!(:project2) { FactoryBot.create(:project, client: current_client) }
  let!(:project3) { FactoryBot.create(:project, client: other_client) }
  let!(:project4) { FactoryBot.create(:project) }
  let(:permitted_params) { { page: 1, per_page: 2 } }

  describe '#call' do
    context 'when current_client is present' do
      it 'returns only projects for the current client' do
        service = Projects::ListingService.new(current_client: current_client, permitted_params: permitted_params)
        projects = service.call

        expect(projects).to match_array([ project1, project2 ])
        expect(projects.length).to eq(2)
      end
    end

    context 'when current_client is not present' do
      it 'returns all projects' do
        service = Projects::ListingService.new(current_client: nil, permitted_params: permitted_params)
        projects = service.call

        expect(projects).to include(project1, project2)
        expect(projects.length).to eq(2)
      end
    end

    context 'when pagination parameters are not provided' do
      it 'returns the default pagination' do
        service = Projects::ListingService.new(current_client: current_client, permitted_params: {})
        projects = service.call

        expect(projects.length).to eq(2)
      end
    end
  end
end
