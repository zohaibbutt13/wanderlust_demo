module Projects
  class LinkVideosService
    def initialize(project:, video_ids:)
      @project = project
      @video_ids = video_ids.reject(&:blank?)
    end

    def call
      video_ids.each do |video_id|
        project.projects_videos.create!(video_id: video_id)
      end
    end

    private

    attr_reader :project, :video_ids
  end
end
