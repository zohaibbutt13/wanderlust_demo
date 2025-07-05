class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_current_client

  private

  def authenticate_current_client
    redirect_to root_path unless current_client
  end

  def current_client
    @current_client ||= Client.find_by(id: session[:client_id])
  end
end
