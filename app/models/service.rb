# Require file size validator
require 'file_size_validator'

# Service model
class Service < ActiveRecord::Base
  after_destroy :remove_image_directory

  mount_uploader :image, ImageUploader

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image, presence: true,
    file_size: { maximum: AppSettings.config['max_filesize'].megabytes.to_i }

  validates_integrity_of :image
  validates_processing_of :image

  private

  # Function to remove empty directory after deleting image
  def remove_image_directory
    FileUtils.remove_dir("#{Rails.root}/public/uploads/service/image/#{id}",
                         force: true)
  end
end
