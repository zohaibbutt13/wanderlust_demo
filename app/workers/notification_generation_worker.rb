class NotificationGenerationWorker
  include Sidekiq::Worker

  def perform(json_params)
    params = JSON.parse(json_params).with_indifferent_access

    resource_class = params[:resource_name].constantize
    resource = resource_class.find_by(id: params[:resource_id])

    return unless resource

    Notifications::GenerationService.new(
      resource: resource,
      action: params[:action],
      user_id: params[:user_id],
      payload: params[:payload] || {}
    ).call
  end
end
