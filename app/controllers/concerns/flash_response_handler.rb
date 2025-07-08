# app/controllers/concerns/flash_response_handler.rb
module FlashResponseHandler
  extend ActiveSupport::Concern

  def handle_flash_response(response, success_path, failure_path)
    redirect_path = ::FlashMessages::HandlerService.new(
      flash: flash,
      response: response,
      success_path: success_path,
      failure_path: failure_path,
      request_type: request.format.symbol
    ).call

    redirect_to redirect_path if redirect_path
  end
end
