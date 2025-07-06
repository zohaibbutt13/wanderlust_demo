FactoryBot.define do
  factory :project do
    title { "Project #{SecureRandom.hex(4)}" }
    status { :pending }
    footage_link { "https://example.com/video.mp4" }
    user
    client
  end
end
