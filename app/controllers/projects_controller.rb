class ProjectsController < ApplicationController
  def index
    @projects = ::Projects::ListingService.new(current_client, params).call
  end

  def new
    @project = current_client.projects.new
    @videos = Video.all

    respond_to do |format|
      format.html
    end
  end

  def create
    project, message = ::Projects::CreationService.new(current_client, params).call

    if project
      # Calling this service to update the status by considering user can update it later
      update_params = ActionController::Parameters.new({ project: { status: "in_progress" } })
      ::Projects::UpdationService.new(project, update_params).call
      flash[:notice] = message
      redirect_to projects_path
    else
      @project = current_client.projects.new(
                   title: params[:project][:title],
                   footage_link: params[:project][:footage_link]
                 )
      @videos = Video.all
      flash[:alert] = message
      render :new
    end
  end
end
