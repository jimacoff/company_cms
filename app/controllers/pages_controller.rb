# Render all static pages
class PagesController < ApplicationController
  def home
    @services = Service.all
  end
end
