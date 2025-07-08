require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:client) }
    it { should have_many(:projects_videos).dependent(:destroy) }
    it { should have_many(:videos).through(:projects_videos) }
    it { should have_many(:notifications) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:project) }

    it { should validate_length_of(:title).is_at_least(4).is_at_most(255) }

    context 'footage_link URL format' do
      it 'is valid with a proper http URL' do
        project = FactoryBot.build(:project, footage_link: "http://example.com/video.mp4")
        expect(project).to be_valid
      end

      it 'is valid with a proper https URL' do
        project = FactoryBot.build(:project, footage_link: "https://example.com/video.mp4")
        expect(project).to be_valid
      end

      it 'is invalid with a non-URL string' do
        project = FactoryBot.build(:project, footage_link: "invalid_url")
        expect(project).to be_invalid
        expect(project.errors[:footage_link]).to include("is not a valid url")
      end
    end
  end

  describe 'enums' do
    it do
      should define_enum_for(:status)
        .with_values(pending: 1, in_progress: 2, completed: 3)
    end
  end
end
