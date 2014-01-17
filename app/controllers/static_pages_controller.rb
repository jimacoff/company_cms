class StaticPagesController < ApplicationController
  def home
  	@services = Service.all()
  end
end
