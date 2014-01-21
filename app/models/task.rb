# Task Model
class Task < ActiveRecord::Base
  belongs_to :work
  has_many :images, as: :imageable, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :work_id, presence: true

  # Save multiple images to the tasks
  def save_images(files)
    files.each do |file|
      return false unless images.create(file: file)
    end

    true
  end
end
