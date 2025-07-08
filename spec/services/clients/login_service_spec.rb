require 'rails_helper'

RSpec.describe Clients::LoginService, type: :service do
  describe '#call' do
    let(:client) { FactoryBot.create(:client) }

    context 'when the client exists' do
      it 'sets the client in the session' do
        session = {}
        response = Clients::LoginService.new(client_id: client.id, session: session).call

        expect(response.success?).to be(true)
        expect(response.message).to eq("Logged in successfully as #{client.full_name}")
        expect(session[:client_id]).to eq(client.id)
      end

      it 'returns the correct client object' do
        session = {}
        response = Clients::LoginService.new(client_id: client.id, session: session).call

        expect(response.client).to eq(client)
      end
    end

    context 'when the client does not exist' do
      it 'returns an error message' do
        session = {}
        response = Clients::LoginService.new(client_id: -1, session: session).call

        expect(response.success?).to be(false)
        expect(response.message).to eq("Client does not exist in the database")
        expect(session[:client_id]).to be_nil
      end
    end
  end
end
