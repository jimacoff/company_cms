# Image Controller, handling image resources
class Admin::ImagesController < Admin::BaseController
  # Render add new image page
  def new
    @work = Work.find(params[:work_id])
  end

  # Handle upload and create new image
  def create
    @work = Work.find(params[:work_id])

    respond_to do |format|

      image = @work.images.build file: params[:file]

      if image.save
        format.json { render json: { status: 1 } }
      else
        format.json { render status: 400, json: { status: 0, error: image.errors.messages[:file][0] } }
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @work = @image.imageable
    @image.destroy
    flash[:delete_image_success] = t('delete_image_success')
    redirect_to work_path(@work)
  end
end
