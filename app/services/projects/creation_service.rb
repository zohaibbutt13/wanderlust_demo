module Projects
  class CreationService
    def initialize(current_client, params)
      @current_client = current_client
      @permitted_params = project_params(params)
    end

    def call
      project = nil

      ActiveRecord::Base.transaction do
        default_project_manager = User.default_project_manager
        project = @current_client.projects.create!(
                    title: @permitted_params[:title],
                    footage_link: @permitted_params[:footage_link],
                    status: "pending",
                    user_id: default_project_manager.id
                  )
        @permitted_params[:video_ids].each do |v_id|
          project.projects_videos.create!(video_id: v_id)
        end
      end

      [ project, "Project Saved successfuly" ]
    rescue StandardError
      [ nil, "Failed to create the project" ]
    end

    private

    def project_params(params)
      params.require(:project).permit(:title, :footage_link, video_ids: [])
    end
  end
end
