# spec/serializers/message_serializer_spec.rb
require 'rails_helper'

RSpec.describe MessageSerializer, type: :serializer do
  let(:message) { Message.create(title: "Test Message", description: "Test description") }
  let(:serializer) { MessageSerializer.new(message) }
  let(:serialized_message) { ActiveModelSerializers::Adapter.create(serializer).as_json }

  it "includes the title, description, and video_url" do
    expect(serialized_message[:title]).to eq("Test Message")
    expect(serialized_message[:description]).to eq("Test description")
    expect(serialized_message[:video_url]).to include("rails/active_storage/blobs/redirect/")
  end

  it "includes the featured_image_url if the image is attached" do
    message.featured_image.attach(io: File.open('spec/fixtures/sample_image.jpg'), filename: 'sample_image.jpg', content_type: 'image/jpg')
    expect(serialized_message[:featured_image_url]).to include("rails/active_storage/blobs/redirect/")
  end
end
