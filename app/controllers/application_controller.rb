# Main controller for the app
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  # Include locale in path
  def default_url_options(options = {})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

  protected

  # Set default locale based on locale param in url
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
