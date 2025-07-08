require 'rails_helper'

RSpec.describe Projects::CreationService, type: :service do
  let(:client) { FactoryBot.create(:client) }
  let(:video) { FactoryBot.create(:video) }
  let!(:user) { FactoryBot.create(:user, :project_manager) }
  let(:params) do
    {
      title: "New Project",
      footage_link: "http://example.com/video.mp4",
      video_ids: [ video.id ]
    }
  end

  describe '#call' do
    context 'when valid parameters are provided' do
      it 'creates a project and links videos' do
        service = Projects::CreationService.new(
          current_client: client,
          permitted_params: params
        )

        expect { service.call }.to change { Project.count }.by(1)

        project = Project.last
        expect(project.title).to eq("New Project")
        expect(project.footage_link).to eq("http://example.com/video.mp4")
        expect(project.status).to eq("pending")
        expect(project.videos.count).to eq(1)
        expect(project.videos.first).to eq(video)
      end
    end

    context 'when no video_ids are provided' do
      it 'returns a failure message' do
        params[:video_ids] = []

        service = Projects::CreationService.new(
          current_client: client,
          permitted_params: params
        )

        response = service.call
        expect(response.success?).to be_falsey
        expect(response.message).to eq("Please select at least one video")
      end
    end

    context 'when project creation fails due to validation error' do
      it 'returns a failure message with validation errors' do
        params[:title] = nil

        service = Projects::CreationService.new(
          current_client: client,
          permitted_params: params
        )

        response = service.call
        expect(response.success?).to be_falsey
        expect(response.message).to include("Title is too short (minimum is 4 characters)")
      end
    end
  end
end
