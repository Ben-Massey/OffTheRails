# spec/factories/messages.rb
FactoryBot.define do
    factory :message do
      title { "Test Message" }
      description { "Test description" }
      tags { "tag1, tag2" }
  
      # Optional: Add logic to attach files
      featured_image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample_image.jpg'), 'image/jpeg') }
      video { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample_video.mp4'), 'video/mp4') }
    end
  end
  