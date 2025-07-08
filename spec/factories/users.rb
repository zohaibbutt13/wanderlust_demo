FactoryBot.define do
  factory :user do
    full_name { "Test User" }
    sequence(:email) { |n| "user#{n}@example.com" }
    role { :user }
    active { true }

    trait :project_manager do
      role { :project_manager }
    end
  end
end
