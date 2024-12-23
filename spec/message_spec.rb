# spec/models/message_spec.rb
require 'rails_helper'

RSpec.describe Message, type: :model do
  it "is valid with a title and description" do
    message = Message.new(title: "Test Title", description: "Test description")
    expect(message).to be_valid
  end

  it "is invalid without a title" do
    message = Message.new(title: nil, description: "Test description")
    expect(message).to_not be_valid
  end

  it "parses tags correctly" do
    message = Message.new(title: "Test Title", description: "Test description", tags: "tag1, tag2, tag3")
    expect(message.tags_list).to eq(["tag1", "tag2", "tag3"])
  end

  it "attaches a video" do
    message = Message.new(title: "Test Title", description: "Test description")
    message.video.attach(io: File.open('spec/fixtures/sample_video.mp4'), filename: 'sample_video.mp4', content_type: 'video/mp4')
    expect(message.video.attached?).to be_truthy
  end

  it "attaches a featured image" do
    message = Message.new(title: "Test Title", description: "Test description")
    message.featured_image.attach(io: File.open('spec/fixtures/sample_image.jpg'), filename: 'sample_image.jpg', content_type: 'image/jpg')
    expect(message.featured_image.attached?).to be_truthy
  end
end
