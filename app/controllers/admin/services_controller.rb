# Admin service controller
class Admin::ServicesController < Admin::BaseController
  include Admin::ImagesHelper

  before_action :remove_old_cache, only: [:create, :update]

  # Index view
  def index
    @services = Service.paginate(page: params[:page])
  end

  # Delete service
  def destroy
    Service.find(params[:id]).destroy
    flash[:success] = t('service_deleted')
    redirect_to services_url
  end

  # Render new service view
  def new
    @service = Service.new
  end

  # Hanlde create new service
  def create
    @service = Service.new(service_params)
    # binding.pry
    if @service.save
      flash[:success] = t('create_service_success')
      redirect_to services_url
    else
      render 'new'
    end
  end

  # Render edit service view
  def edit
    @service = Service.find(params[:id])
  end

  # Handle update the service
  def update
    @service = Service.find(params[:id])
    @old_image_url = @service.image_url
    if @service.update(service_params)
      flash[:success] = t('update_service_success')
      redirect_to edit_service_url(@service)
    else
      render 'edit'
    end
  end

  private

  # Only allow necessary fields
  def service_params
    params.require(:service).permit(:name, :image, :image_cache, :description)
  end
end
