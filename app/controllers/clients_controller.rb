class ClientsController < ApplicationController
  skip_before_action :authenticate_current_client, only: [ :login, :logout, :index ]
  before_action :validate_current_client, only: [ :login, :index ]

  # POST /clients/:id/login
  def login
    client, message = ::Clients::LoginService.new(params, session).call

    if client
      flash[:notice] = message
      redirect_to projects_path
    else
      flash[:alert] = message
      redirect_to root_path
    end
  end

  def logout
    ::Clients::LogoutService.new(session).call

    flash[:notice] = "Logged out successfully"
    redirect_to root_path
  end

  # GET /clients
  def index
    @clients = ::Clients::ListingService.new(params).call

    respond_to do |format|
      format.html
    end
  end

  private

  def validate_current_client
    redirect_to projects_path if current_client
  end
end
