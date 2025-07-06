# spec/factories/clients.rb
FactoryBot.define do
  factory :client do
    full_name { "Client #{SecureRandom.hex(4)}" }
    email { Faker::Internet.email }
  end
end
