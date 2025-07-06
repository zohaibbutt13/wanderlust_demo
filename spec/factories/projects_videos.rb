# spec/factories/projects_videos.rb
FactoryBot.define do
  factory :projects_video do
    association :project
    association :video
  end
end
