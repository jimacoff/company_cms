# Admin Session Controller, Handle login, logout
class Admin::SessionsController < Admin::BaseController
  skip_before_action :signed_in_user, only: [:new, :create]
  before_action :signed_in_redirect, only: [:new]
  layout 'login'

  # Render the login page
  def new
  end

  # Handle the login process
  def create
    user = User.find_by(username: params[:session][:username])
    # If there is user and password is right, sign in, else redirect to login page
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to boss_url
    else
      redirect_to login_url, alert: t(:login_error)
    end
  end

  def destroy
    sign_out
    redirect_to login_url
  end
end
