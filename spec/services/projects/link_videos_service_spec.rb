require 'rails_helper'

RSpec.describe Projects::LinkVideosService, type: :service do
  let!(:project) { FactoryBot.create(:project) }
  let!(:video1) { FactoryBot.create(:video) }
  let!(:video2) { FactoryBot.create(:video) }
  let!(:invalid_video_id) { 999999 }

  describe '#call' do
    context 'when valid video_ids are provided' do
      it 'links the videos to the project' do
        video_ids = [ video1.id, video2.id ]

        service = Projects::LinkVideosService.new(project: project, video_ids: video_ids)

        expect { service.call }.to change { project.videos.count }.by(2)

        expect(project.videos).to include(video1, video2)
      end
    end

    context 'when blank video_ids are provided' do
      it 'ignores blank video_ids' do
        video_ids = [ video1.id, '', nil, video2.id ]

        service = Projects::LinkVideosService.new(project: project, video_ids: video_ids)

        expect { service.call }.to change { project.videos.count }.by(2)

        expect(project.videos).to include(video1, video2)
      end
    end
  end
end
