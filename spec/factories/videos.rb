FactoryBot.define do
  factory :video do
    title { "Sample Video" }
    cost_in_cents { 1000 }
    active { true }

    after(:build) do |video|
      video.file.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/sample.mp4")),
        filename: "sample.mp4",
        content_type: "video/mp4"
      )
    end
  end
end
