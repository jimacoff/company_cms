# Category for Work model
class WorkCategory < ActiveRecord::Base
  validates :name, presence: true

  has_many :works, foreign_key: :category_id
end
