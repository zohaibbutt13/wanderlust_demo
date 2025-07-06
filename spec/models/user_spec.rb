require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:projects) }
    it { should have_many(:notifications).dependent(:nullify) }
  end

  describe 'validations' do
    subject { FactoryBot.create(:user) }

    it { should validate_length_of(:full_name).is_at_least(4).is_at_most(255) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('test@example.com').for(:email) }

    it { should_not allow_value('invalid_email').for(:email) }
  end

  describe 'default_project_manager' do
    let!(:manager) { FactoryBot.create(:user, :project_manager) }
    let!(:user) { FactoryBot.create(:user) }

    it 'returns the first project manager' do
      expect(User.default_project_manager).to eq(manager)
    end
  end
end
