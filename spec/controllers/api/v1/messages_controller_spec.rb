# spec/controllers/api/v1/messages_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :controller do
  let!(:message) { create(:message) }

  describe 'GET #index' do
    context 'when no tag is provided' do
      it 'returns all messages' do
        get :index, format: :json
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(1)
      end
    end

    context 'when a tag is provided' do
      it 'returns messages with the given tag' do
        message.tag_list.add('tag1')
        message.save

        get :index, params: { tag: 'tag1' }, format: :json
        expect(response).to have_http_status(:success)
        messages = JSON.parse(response.body)
        expect(messages.size).to eq(1)
        expect(messages.first['tags']).to include('tag1')
      end

      it 'returns no messages if no match is found' do
        get :index, params: { tag: 'non_existent_tag' }, format: :json
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('No messages found with the tag non_existent_tag')
      end
    end
  end

  describe 'GET #show' do
    it 'returns the message with the given ID' do
      get :show, params: { id: message.id }, format: :json
      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(message.id)
    end

    it 'returns a 404 status if the message is not found' do
      get :show, params: { id: 9999 }, format: :json
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Message not found')
    end
  end

  describe 'GET #search' do
    it 'returns messages matching the search query' do
      get :search, params: { query: message.title }, format: :json
      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.first['title']).to eq(message.title)
    end

    it 'returns an empty array when no matching messages are found' do
      get :search, params: { query: 'Non-existent title' }, format: :json
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to be_empty
    end
  end
end
