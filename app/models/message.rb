class Message < ApplicationRecord
    has_one_attached :video
    has_one_attached :featured_image
    has_rich_text :description
    validates :title, presence: true
    acts_as_taggable_on :tags  # This makes use of the acts_as_taggable_on gem
  end