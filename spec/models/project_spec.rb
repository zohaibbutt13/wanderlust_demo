require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "associations" do
    it { should have_many(:projects_videos).dependent(:destroy) }
    it { should have_many(:videos).through(:projects_videos) }
    it { should belong_to(:user) }
    it { should belong_to(:client) }
    it { should have_many(:notifications) }
  end

  describe "validations" do
    it { should validate_length_of(:title).is_at_least(4).is_at_most(255) }

    context "footage_link format" do
      it "is valid with a proper URL" do
        project = FactoryBot.build(:project, footage_link: "https://example.com/video.mp4")
        expect(project).to be_valid
      end

      it "is invalid with an improper URL" do
        project = FactoryBot.build(:project, footage_link: "invalid_url")
        expect(project).not_to be_valid
        expect(project.errors[:footage_link]).to include("is not a valid url")
      end
    end
  end

  describe 'callbacks' do
    describe 'after_create_commit :generate_notification' do
      it 'enqueues NotificationGenerationWorker with correct arguments' do
        user = FactoryBot.create(:user)
        client = FactoryBot.create(:client)
        project = FactoryBot.build(:project, user: user, client: client)

        expect {
          project.save
        }.to change(NotificationGenerationWorker.jobs, :size).by(1)

        job_args = NotificationGenerationWorker.jobs.last['args'].first
        parsed = JSON.parse(job_args)

        expect(parsed["resource_name"]).to eq("Project")
        expect(parsed["resource_id"]).to eq(project.id)
        expect(parsed["action"]).to eq("create")
        expect(parsed["user_id"]).to eq(user.id)
        expect(parsed["payload"]).to eq({})
      end
    end
  end
end
