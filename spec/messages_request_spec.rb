# spec/requests/api/v1/messages_request_spec.rb
require 'rails_helper'

RSpec.describe "Messages API", type: :request do
  let!(:message) { Message.create(title: "Test Message", description: "Test description") }

  describe "GET /api/v1/messages" do
    it "returns a list of messages" do
      get '/api/v1/messages'
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include("application/json")
    end
  end

  describe "GET /api/v1/messages/:id" do
    it "returns a single message" do
      get "/api/v1/messages/#{message.id}"
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include("application/json")
    end
  end
end
