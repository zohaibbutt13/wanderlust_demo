require 'rails_helper'

RSpec.describe Projects::UpdationService, type: :service do
  let(:project) { FactoryBot.create(:project) }
  let(:valid_params) { { status: :in_progress } }
  let(:invalid_params) { { status: 'invalid_status' } }  # Invalid status should be a string not in the valid list

  describe '#call' do
    context 'when the update is successful' do
      it 'returns a success response with the updated project' do
        service = Projects::UpdationService.new(project: project, permitted_params: valid_params)
        response = service.call

        expect(response.success?).to be(true)
        expect(response.message).to eq("Project updated successfully")
        expect(response.project.status).to eq('in_progress')
      end
    end

    context 'when the update fails due to validation errors' do
      it 'returns a failure response with error messages' do
        service = Projects::UpdationService.new(project: project, permitted_params: invalid_params)
        response = service.call

        expect(response.success?).to be(false)
      end
    end

    context 'when an unexpected error occurs' do
      it 'returns a failure response with a generic error message' do
        allow(project).to receive(:update!).and_raise(StandardError, "Some unexpected error")

        service = Projects::UpdationService.new(project: project, permitted_params: valid_params)
        response = service.call

        expect(response.success?).to be(false)
        expect(response.message).to eq("Something went wrong while updating the project")
      end
    end
  end
end
