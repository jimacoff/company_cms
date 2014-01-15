module Admin::SessionsHelper

  # Function to sign in user
  def sign_in(user)
    session[:remember_token] = user.id
    self.current_user = user
  end

  # Signout a user
  def sign_out
    session.delete :remember_token
    self.current_user = nil
  end

  # Current user setter
  def current_user=(user)
    @current_user = user
  end

  # Current user getter
  def current_user
    @current_user ||= User.find_by(id: session[:remember_token])
  end

  # Check a user signed in or not
  def signed_in?
    !self.current_user.nil?
  end

  # Filter to check for a signed in user
  def signed_in_user
    redirect_to login_path, alert: t('not_authorized') unless signed_in?
  end

  # Filter ro redirect from login to main page
  def signed_in_redirect
    redirect_to services_path if signed_in?
  end
end
