# Require file size validator
require 'file_size_validator'

# Work Model
class Work < ActiveRecord::Base
  after_destroy :remove_image_directory

  mount_uploader :cover_photo, ImageUploader

  validates :name, presence: true
  validates :client_name, presence: true
  validates :story, presence: true
  validates :techs, presence: true
  VALID_URL = /(^$)|(\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z)/ix
  validates :link, format: { with: VALID_URL }
  validates :cover_photo, presence: true,
    file_size: { maximum: AppSettings.config['max_filesize'].megabytes.to_i }

  validates_integrity_of :cover_photo
  validates_processing_of :cover_photo

  has_many :tasks, dependent: :destroy

  private

  # Remove empty image directory
  def remove_image_directory
    FileUtils.remove_dir("#{Rails.root}/public/uploads/work/cover_photo/#{id}",
                        force: true)
  end
end
