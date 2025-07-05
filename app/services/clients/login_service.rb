module Clients
  class LoginService
    def initialize(params, session)
      @client_id = login_params(params)[:id]
      @session = session
    end

    def call
      client = Client.find(@client_id)
      @session[:client_id] = client.id

      [ client, "Logged in successfuly as #{client.full_name}" ]
    rescue ActiveRecord::RecordNotFound
      [ nil, "Client does not exist in the database" ]
    rescue StandardError
      [ nil, "Unable to login" ]
    end

    private

    def login_params(params)
      params.permit(:id)
    end
  end
end
