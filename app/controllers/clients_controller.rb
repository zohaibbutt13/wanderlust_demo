class ClientsController < ApplicationController
  include FlashResponseHandler

  skip_before_action :authenticate_current_client, only: [ :login, :logout, :index ]
  before_action :validate_current_client, only: [ :login, :index ]

  # POST /clients/:id/login
  def login
    response = Clients::LoginService.new(client_id: login_params[:id], session: session).call

    handle_flash_response(response, projects_path, clients_path)
  end

  # POST /clients/logout
  def logout
    response = ::Clients::LogoutService.new(session).call

    handle_flash_response(response, root_path, projects_path)
  end

  # GET /clients
  def index
    @clients = Clients::ListingService.new(
      page: params[:page]
    ).call

    respond_to do |format|
      format.html
    end
  end

  private

  def validate_current_client
    redirect_to projects_path if current_client
  end

  def login_params
    params.permit(:id)
  end
end
