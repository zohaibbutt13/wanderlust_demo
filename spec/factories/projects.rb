FactoryBot.define do
  factory :project do
    title { "Sample Project" }
    footage_link { "https://example.com/footage.mp4" }
    status { :pending }
    association :user
    association :client
  end
end
