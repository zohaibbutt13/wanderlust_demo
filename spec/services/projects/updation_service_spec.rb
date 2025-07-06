require 'rails_helper'

RSpec.describe Projects::UpdationService, type: :service do
  let(:project) { FactoryBot.create(:project, status: "pending") }
  let(:params) { ActionController::Parameters.new({ project: { status: "completed" } }) }
  let(:service) { described_class.new(project, params) }

  describe '#call' do
    context 'when valid parameters are provided' do
      it 'updates the project status successfully' do
        result, message = service.call

        expect(result).to eq(true)
        expect(message).to eq('Project updated successfully')
        expect(project.reload.status).to eq("completed")
      end
    end

    context 'when invalid parameters are provided' do
      let(:invalid_params) { ActionController::Parameters.new({ project: { status: "invalid_status" } }) }
      let(:invalid_service) { described_class.new(project, invalid_params) }

      it 'raises an error and does not update the project' do
        result, message = invalid_service.call

        expect(result).to eq(false)
        expect(message).to eq("'invalid_status' is not a valid status")
        expect(project.reload.status).to eq("pending")
      end
    end
  end
end
