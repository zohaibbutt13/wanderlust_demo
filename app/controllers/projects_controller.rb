class ProjectsController < ApplicationController
  include FlashResponseHandler

  def index
    @projects = ::Projects::ListingService.new(
      current_client: current_client,
      permitted_params: projects_params
    ).call
  end

  def new
    @project = current_client.projects.new
    @videos = Video.all

    respond_to do |format|
      format.html
    end
  end

  def create
    response = ::Projects::CreationService.new(
      current_client: current_client,
      permitted_params: create_params
    ).call

    handle_flash_response(response, projects_path, nil)

    if response.success?
      # We can move this to the background jobs as well
      move_project_to_in_progress(response.project)
    else
      @project = response.project
      @videos = Video.all

      render new_project_path
    end
  end

  private

  def move_project_to_in_progress(project)
    update_params = ActionController::Parameters.new({
      status: "in_progress"
    }).permit(:status)

    ::Projects::UpdationService.new(project:, permitted_params: update_params).call
  end

  def projects_params
    params.permit(:page, :per_page)
  end

  def create_params
    params.require(:project).permit(
      :title,
      :footage_link,
      video_ids: []
    )
  end
end
