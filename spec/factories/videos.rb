# spec/factories/videos.rb
FactoryBot.define do
  factory :video do
    title { "Sample Video" }
    description { "Test description" }
    cost_in_cents { 1500 }

    after(:build) do |video|
      video.file.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/reel.mp4")),
        filename: "reel.mp4",
        content_type: "video/mp4"
      )
    end
  end
end
