require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:projects).dependent(:nullify) }
    it { should have_many(:notifications).dependent(:nullify) }
  end

  describe 'validations' do
    subject { FactoryBot.create(:user) }

    it { should validate_presence_of(:full_name) }
    it { should validate_length_of(:full_name).is_at_least(4).is_at_most(255) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value("email@example.com").for(:email) }

    it { should validate_presence_of(:role) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(user: 1, project_manager: 2) }
  end

  describe 'scopes' do
    let!(:active_user) { FactoryBot.create(:user, active: true) }
    let!(:inactive_user) { FactoryBot.create(:user, active: false) }
    let!(:manager) { FactoryBot.create(:user, :project_manager) }

    it 'returns only active users' do
      expect(User.active).to include(active_user)
      expect(User.active).not_to include(inactive_user)
    end

    it 'returns only project managers' do
      expect(User.managers).to include(manager)
    end
  end

  describe '.default_project_manager' do
    let!(:manager) { FactoryBot.create(:user, :project_manager) }

    it 'returns the first project manager' do
      expect(User.default_project_manager).to eq(manager)
    end
  end
end
