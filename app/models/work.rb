# Work Model
class Work < ActiveRecord::Base

  validates :name, presence: true
  validates :client, presence: true
  validates :story, presence: true
  validates :techs, presence: true

  has_many :images, as: :imageable, dependent: :destroy
end
