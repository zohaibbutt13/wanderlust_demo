module Notifications
  class CreationService
    def initialize(resource, action, user_id, payload = {})
      @resource = resource
      @action = action
      @user_id = user_id
      @payload = payload
    end

    def call
      @resource.notifications.create!(
        status: :pending,
        action: @action,
        user_id: @user_id,
        payload: @payload
      )
    end
  end
end
