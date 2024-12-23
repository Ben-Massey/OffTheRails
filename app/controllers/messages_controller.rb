class MessagesController < ApplicationController
  before_action :set_message, only: %i[show edit update video]

  def index
    @message = Message.all
  end

  def show
  end

  def video
    # Get the attached video file
    video = @message.video

    # Check if the video exists
    if video.attached?
      #set cache headers
      response.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate'
      response.headers['Pragma'] = 'no-cache'

      # Set Content-Disposition to inline
      response.headers['Content-Disposition'] = "inline; filename=#{video.filename.to_s}"
      response.headers['Content-Type'] = video.content_type
      # Serve the video with inline disposition
      send_data(
        video.download,
        type: video.content_type,
        disposition: 'inline',
        filename: video.filename.to_s
      )
    else
      render plain: "Video not found", status: :not_found
    end
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
