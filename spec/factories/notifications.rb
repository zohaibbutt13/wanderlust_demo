# spec/factories/notifications.rb
FactoryBot.define do
  factory :notification do
    title { "Sample Notification" }
    status { :pending }
    association :user
  end
end
