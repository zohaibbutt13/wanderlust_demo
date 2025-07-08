module Clients
  class LogoutService
    class Response
      attr_reader :message

      def initialize(success:, message:)
        @success = success
        @message = message
      end

      def success?
        @success
      end
    end

    def initialize(session)
      @session = session
    end

    def call
      session[:client_id] = nil

      Response.new(success: true, message: "Logged out successfully")
    rescue StandardError => e
      Response.new(success: false, message: "Logout failed: #{e.message}")
    end

    private

    attr_reader :session
  end
end
