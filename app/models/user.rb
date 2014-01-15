# User Model
class User < ActiveRecord::Base
  attr_accessor :old_password
  before_save { email.downcase! }

  validate :correct_old_password, on: :update
  VALID_USERNAME = /\A\w+\z/i
  validates :username, presence: true, length: { in: 6..50 },
    format: { with: VALID_USERNAME },
    uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 },  confirmation: { on: :update }, allow_blank: { on: :update }
  validates :old_password, presence: true, on: :update

  has_secure_password

  private

  # validation to check for a correct old password
  def correct_old_password
    old_user = User.find(id);
    if !old_user.authenticate(old_password)
      errors.add(:old_password, I18n.t(:incorrect_old_password))
    end
  end
end
