class MessagesController < ApplicationController
  before_action :set_message, only: %i[show edit update]

  def index
    @message = Message.all
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params.except(:tags))
    
    # Process tags if they are provided
    if message_params[:tags].present?
      # Split the comma-separated string into an array of tags
      @message.tag_list = message_params[:tags].split(",").map(&:strip)
    end
  
    if @message.save
      redirect_to root_path, notice: 'Message was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @message
  end

  def update
    # Process tags if they are provided
    if message_params[:tags].present?
      @message.tag_list = message_params[:tags].split(",").map(&:strip)
    end

    # Update the message with the provided params and save
    if @message.update(message_params.except(:tags)) # Exclude the `tags` field to avoid overwriting tag_list
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:title, :description, :tags, :featured_image, :video)
  end
end
