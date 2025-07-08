FactoryBot.define do
  factory :notification do
    association :user
    association :notifier, factory: :project
    status { :pending }
    action { "create" }
    payload { { info: "Test payload" } }
  end
end
