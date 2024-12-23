class MessageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :tags, :featured_image_url, :video_url

  def featured_image_url
    if object.featured_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.featured_image, only_path: false)
    end
  end
  
  def video_url
    if object.video.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.video, only_path: false, disposition: 'inline')
    else
      nil
    end
  end
end