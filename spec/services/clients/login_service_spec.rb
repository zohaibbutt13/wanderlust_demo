require 'rails_helper'

RSpec.describe Clients::LoginService, type: :service do
  let!(:client) { FactoryBot.create(:client) }
  let(:session) { {} }

  context "when client exists" do
    let(:params) { ActionController::Parameters.new(id: client.id) }

    it "logs in the client and sets session" do
      service = described_class.new(params, session)
      result, message = service.call

      expect(result).to eq(client)
      expect(session[:client_id]).to eq(client.id)
      expect(message).to eq("Logged in successfuly as #{client.full_name}")
    end
  end

  context "when client does not exist" do
    let(:params) { ActionController::Parameters.new(id: 0) }

    it "returns nil and error message" do
      service = described_class.new(params, session)
      result, message = service.call

      expect(result).to be_nil
      expect(session[:client_id]).to be_nil
      expect(message).to eq("Client does not exist in the database")
    end
  end

  context "when unexpected error occurs" do
    let(:params) { ActionController::Parameters.new(id: client.id) }

    it "rescues and returns a generic error" do
      allow(Client).to receive(:find).and_raise(StandardError)

      service = described_class.new(params, session)
      result, message = service.call

      expect(result).to be_nil
      expect(message).to eq("Unable to login")
    end
  end
end
