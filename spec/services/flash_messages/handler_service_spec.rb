
require 'rails_helper'

RSpec.describe FlashMessages::HandlerService, type: :service do
  let(:response_success) { double('Response', success?: true, message: 'Success message') }
  let(:response_failure) { double('Response', success?: false, message: 'Failure message') }

  let(:flash) { ActionDispatch::Flash::FlashHash.new }
  let(:success_path) { '/success' }
  let(:failure_path) { '/failure' }

  describe '#call' do
    context 'when response is successful' do
      it 'sets the flash notice and returns the success path for HTML requests' do
        handler = FlashMessages::HandlerService.new(flash: flash, response: response_success, success_path: success_path, failure_path: failure_path, request_type: :html)

        redirect_path = handler.call

        expect(flash[:notice]).to eq('Success message')
        expect(redirect_path).to eq(success_path)
      end

      it 'sets the flash now notice and returns the success path for non-HTML requests' do
        handler = FlashMessages::HandlerService.new(flash: flash, response: response_success, success_path: success_path, failure_path: failure_path, request_type: :json)

        redirect_path = handler.call

        expect(flash.now[:notice]).to eq('Success message')
        expect(redirect_path).to eq(success_path)
      end
    end

    context 'when response is not successful' do
      it 'sets the flash alert and returns the failure path for HTML requests' do
        handler = FlashMessages::HandlerService.new(flash: flash, response: response_failure, success_path: success_path, failure_path: failure_path, request_type: :html)

        redirect_path = handler.call

        expect(flash[:alert]).to eq('Failure message')
        expect(redirect_path).to eq(failure_path)
      end

      it 'sets the flash now alert and returns the failure path for non-HTML requests' do
        handler = FlashMessages::HandlerService.new(flash: flash, response: response_failure, success_path: success_path, failure_path: failure_path, request_type: :json)

        redirect_path = handler.call

        expect(flash.now[:alert]).to eq('Failure message')
        expect(redirect_path).to eq(failure_path)
      end
    end
  end
end
