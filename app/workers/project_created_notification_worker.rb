class ProjectCreatedNotificationWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    project_manager = project.user
    # We can send email here
  end
end
