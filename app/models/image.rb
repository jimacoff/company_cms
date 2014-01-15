require 'file_size_validator'

# Image model
class Image < ActiveRecord::Base
  after_destroy :remove_image_directory
  mount_uploader :file, ImageUploader

  belongs_to :imageable, polymorphic: true

  # remove image if valdation failed (no need to redisplay anyway)
  validates :file, presence: true,
    file_size: { maximum: AppSettings.config['max_filesize'].megabytes.to_i, remove_if_invalid: true }

  validates_integrity_of :file
  validates_processing_of :file

  private

  def remove_image_directory
    FileUtils.remove_dir("#{Rails.root}/public/uploads/image/file/#{id}", force: true)
  end
end
