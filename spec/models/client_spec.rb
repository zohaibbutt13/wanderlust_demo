require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'associations' do
    it { should have_many(:projects).dependent(:nullify) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:client) }

    it { should validate_presence_of(:full_name) }
    it { should validate_length_of(:full_name).is_at_least(4).is_at_most(255) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
  end

  describe '.with_projects_count' do
    it 'returns clients with their projects count' do
      client = FactoryBot.create(:client)
      FactoryBot.create_list(:project, 3, client: client)

      result = Client.with_projects_count.find(client.id)
      expect(result.projects_count.to_i).to eq(3)
    end
  end
end
