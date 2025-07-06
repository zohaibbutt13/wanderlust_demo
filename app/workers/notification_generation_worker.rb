class NotificationGenerationWorker
  include Sidekiq::Worker

  def perform(options = {})
    options = JSON.parse(options)

    resource_type = options["resource_name"].constantize
    resource = resource_type.find(options["resource_id"])

    ::Notifications::CreationService.new(
      resource,
      options["action"],
      options["user_id"],
      options["payload"]
    ).call
  end
end
