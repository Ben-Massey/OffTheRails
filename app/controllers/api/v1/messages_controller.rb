class Api::V1::MessagesController < ApplicationController
    # Skip CSRF protection for APIs
    skip_before_action :verify_authenticity_token

    # GET /api/v1/messages
    def index
        if params[:tag].present?
            @messages = Message.tagged_with(params[:tag])

            if @messages.empty?
                render json: { message: "No messages found with the tag #{params[:tag]}" }, status: :not_found
            else
                render json: @messages, each_serializer: MessageSerializer
            end
        else
            @messages = Message.all
            render json: @messages, each_serializer: MessageSerializer
        end
    end

    # GET /api/v1/messages/:id
    def show
        @message = Message.find(params[:id])
        render json: @message, serializer: MessageSerializer
    end

    # GET /api/v1/messages/search
    def search
        # Example of a search query (you can modify based on your needs)
        @messages = Message.where('title LIKE ?', "%#{params[:query]}%")
        render json: @messages, each_serializer: MessageSerializer
    end
end
