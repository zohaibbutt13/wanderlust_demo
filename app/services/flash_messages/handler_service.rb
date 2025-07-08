module FlashMessages
  class HandlerService
    def initialize(flash:, response:, success_path: nil, failure_path: nil, request_type: :html)
      @flash = flash
      @response = response
      @success_path = success_path
      @failure_path = failure_path
      @request_type = request_type
    end

    def call
      key = response.success? ? :notice : :alert
      message = response.message

      if request_type == :html
        flash[key] = message
      else
        flash.now[key] = message
      end

      response.success? ? success_path : failure_path
    end

    private

    attr_reader :flash, :response, :success_path, :failure_path, :request_type
  end
end
