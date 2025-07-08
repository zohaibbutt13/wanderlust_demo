require 'rails_helper'

RSpec.describe Clients::LogoutService, type: :service do
  describe '#call' do
    let(:session) { { client_id: 1 } }

    context 'when logout is successful' do
      it 'logs the client out by setting session[:client_id] to nil' do
        response = Clients::LogoutService.new(session).call

        expect(response.success?).to be(true)
        expect(response.message).to eq("Logged out successfully")
        expect(session[:client_id]).to be_nil
      end
    end

    context 'when logout fails' do
      before do
        allow(session).to receive(:[]=).and_raise(StandardError, "Some error")
      end

      it 'returns a failure message when an error occurs' do
        response = Clients::LogoutService.new(session).call

        expect(response.success?).to be(false)
        expect(response.message).to eq("Logout failed: Some error")
      end
    end
  end
end
