module Clients
  class LoginService
    class Response
      attr_reader :client, :message

      def initialize(success:, client: nil, message:)
        @success = success
        @client = client
        @message = message
      end

      def success?
        @success
      end
    end

    def initialize(client_id:, session:)
      @client_id = client_id
      @session = session
    end

    def call
      client = Client.find(@client_id)
      @session[:client_id] = client.id

      Response.new(success: true, client: client, message: "Logged in successfully as #{client.full_name}")
    rescue ActiveRecord::RecordNotFound
      Response.new(success: false, message: "Client does not exist in the database")
    end
  end
end
