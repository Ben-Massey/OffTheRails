class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update]
  
  def index
    @message = Message.all
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path, notice: 'Message was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
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
      params.require(:message).permit(:title, :description, :featured_image, :video)
    end
end
