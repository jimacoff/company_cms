class MessageMailer < ActionMailer::Base
  default from: 'admin@thecompny.com'

  def contact_email(message)
    @message = message
    @user = User.first
    mail(to: @user.email, subject: 'New contact message!')
  end
end
