module Notifications
  class GenerationService
    def initialize(resource:, action:, user_id:, payload: {})
      @resource = resource
      @action = action
      @user_id = user_id
      @payload = payload
    end

    def call
      validate_inputs!

      Notification.create!(
        user_id: user_id,
        notifier: resource,
        action: action,
        status: :pending,
        payload: payload
      )
    end

    private

    attr_reader :resource, :action, :user_id, :payload

    def validate_inputs!
      raise ArgumentError, "Notifier resource must support polymorphic notifications" unless resource.respond_to?(:notifications)
      raise ArgumentError, "User ID is required" if user_id.blank?
      raise ArgumentError, "Action is required" if action.blank?
    end
  end
end
