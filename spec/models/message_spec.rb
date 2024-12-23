# spec/models/message_spec.rb

require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      message = build(:message)
      expect(message).to be_valid
    end

    it 'is not valid without a title' do
      message = build(:message, title: nil)
      expect(message).to_not be_valid
    end

    it 'is not valid without a description' do
      message = build(:message, description: nil)
      expect(message).to_not be_valid
    end
  end

  context 'attachments' do
    it 'attaches a featured image' do
      message = build(:message)
      expect(message.featured_image).to be_attached
    end

    it 'attaches a video' do
      message = build(:message)
      expect(message.video).to be_attached
    end
  end

  context 'tag_list' do
    it 'correctly processes tags from a comma-separated string' do
      message = build(:message, tags: 'tag1, tag2')
      expect(message.tag_list).to include('tag1', 'tag2')
    end
  end
end
