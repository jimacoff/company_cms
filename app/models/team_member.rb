# Require file size validator
require 'file_size_validator'

# TeamMember Model
class TeamMember < ActiveRecord::Base
  after_destroy :remove_image_directory

  mount_uploader :avatar, ImageUploader

  validates :name, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :avatar, presence: true,
    file_size: { maximum:  AppSettings.config['max_filesize'].megabytes.to_i }

  validates_integrity_of :avatar
  validates_processing_of :avatar

  private

  # Function to remove empty directory after deleting image
  def remove_image_directory
    FileUtils.remove_dir("#{Rails.root}/public/uploads/team_member/avatar/#{id}", force: true)
  end
end
