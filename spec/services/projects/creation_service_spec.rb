require 'rails_helper'

RSpec.describe Projects::CreationService, type: :service do
  let(:current_client) { FactoryBot.create(:client) } # Assuming you have a factory for Client
  let(:default_project_manager) { FactoryBot.create(:user, role: :project_manager) }
  let(:video1) { FactoryBot.create(:video) }
  let(:video2) { FactoryBot.create(:video) }
  let(:valid_params) do
    ActionController::Parameters.new({
      project: {
        title: 'New Project',
        footage_link: 'http://valid.url.com/video.mp4',
        video_ids: [ video1.id, video2.id ]
      }
    })
  end

  before do
    allow(User).to receive(:default_project_manager).and_return(default_project_manager)
  end

  describe '#call' do
    context 'when valid parameters are provided' do
      it 'creates a project with associated videos' do
        service = described_class.new(current_client, valid_params)
        project, message = service.call

        expect(project).to be_persisted
        expect(project.title).to eq('New Project')
        expect(project.status).to eq('pending')
        expect(project.videos.count).to eq(2)
        expect(message).to eq('Project Saved successfuly')
      end
    end

    context 'when an error occurs during project creation' do
      it 'rolls back the transaction and returns an error message' do
        invalid_params = valid_params.merge(project: { title: nil }) # Simulate an invalid project title

        service = described_class.new(current_client, invalid_params)
        project, message = service.call

        expect(project).to be_nil
        expect(message).to eq('Failed to create the project')
      end
    end
  end
end
