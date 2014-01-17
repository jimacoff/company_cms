# Post Model
class Post < ActiveRecord::Base
  extend FriendlyId

  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true

  friendly_id :title, use: [:slugged, :finders]
end
