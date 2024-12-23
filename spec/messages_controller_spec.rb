# spec/controllers/api/v1/messages_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :controller do
  let!(:message) { Message.create(title: "Test Message", description: "Test description") }

  describe "GET #index" do
    it "returns a list of messages" do
      get :index, format: :json
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include("application/json")
      expect(json_response.size).to eq(1)
    end
  end

  describe "GET #show" do
    it "returns a single message" do
      get :show, params: { id: message.id }, format: :json
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include("application/json")
      expect(json_response['title']).to eq("Test Message")
    end
  end

  describe "GET #search" do
    it "returns messages that match the search query" do
      get :search, params: { query: "Test" }, format: :json
      expect(response).to have_http_status(:success)
      expect(json_response.size).to eq(1)
    end
  end
end

# Helper method to parse JSON response
def json_response
  JSON.parse(response.body)
end
