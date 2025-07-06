# spec/models/client_spec.rb
require 'rails_helper'

RSpec.describe Client, type: :model do
  describe "associations" do
    it { should have_many(:projects).dependent(:nullify) }
  end

  describe "validations" do
    it { should validate_length_of(:full_name).is_at_least(4).is_at_most(255) }

    it { should validate_presence_of(:email) }

    it do
      should validate_uniqueness_of(:email).case_insensitive
    end

    it "validates email format" do
      valid_client = described_class.new(full_name: "Test User", email: "test@example.com")
      invalid_client = described_class.new(full_name: "Test User", email: "invalid-email")

      expect(valid_client).to be_valid
      expect(invalid_client).not_to be_valid
      expect(invalid_client.errors[:email]).to include("is invalid")
    end
  end
end
