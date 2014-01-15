# Base Controller for all controllers in Admin namespace
class Admin::BaseController < ApplicationController
  before_action :signed_in_user
  layout 'admin'
  include Admin::SessionsHelper
end
