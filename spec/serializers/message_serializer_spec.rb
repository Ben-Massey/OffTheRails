# spec/serializers/message_serializer_spec.rb

require 'rails_helper'

RSpec.describe MessageSerializer, type: :serializer do
  let(:message) { create(:message) }

  context 'when a featured image is attached' do
    it 'returns the correct featured_image_url' do
      # Attach the image file to the message (this will simulate file uploads)
      message.featured_image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample_image.jpg')), filename: 'sample_image.jpg', content_type: 'image/jpg')

      # Serialize the message using the serializer
      serialized_message = ActiveModelSerializers::Adapter.create(MessageSerializer.new(message)).as_json

      # Check if the serialized message contains the correct URL for the featured image
      expect(serialized_message[:featured_image_url]).to match(/rails\/active_storage\/blobs\/redirect\/.*/)
    end
  end
end

