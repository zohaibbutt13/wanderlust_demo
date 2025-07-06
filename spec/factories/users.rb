FactoryBot.define do
  factory :user do
    full_name { "Test User" }
    email { Faker::Internet.email }
    role { :user }

    trait :project_manager do
      role { :project_manager }
    end
  end
end
