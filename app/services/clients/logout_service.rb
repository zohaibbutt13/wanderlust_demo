module Clients
  class LogoutService
    def initialize(session)
      @session = session
    end

    def call
      @session[:client_id] = nil
    end
  end
end
