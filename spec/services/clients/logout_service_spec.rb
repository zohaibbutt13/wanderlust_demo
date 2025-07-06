require 'rails_helper'

RSpec.describe Clients::LogoutService, type: :service do
  let(:session) { { client_id: 1 } }

  it "clears the client_id from session" do
    described_class.new(session).call

    expect(session[:client_id]).to be_nil
  end
end
