# Tasks Controller to handle tasks
class Admin::TasksController < Admin::BaseController
  def show
  end

  def new
    @work = Work.find(params[:work_id])
    @task = @work.tasks.build
  end

  def create
    @work = Work.find(params[:work_id])
    @task = @work.tasks.build(task_params)

    respond_to do |format|
      # when there is no image upload process as normal
      format.html do
        if @task.save
          redirect_to work_url(@work)
        else
          render 'new'
        end
      end

      format.json do
        if !@task.save
          render status: 400, json: { status: 0, message: @task.errors.messages }
        else
          save_task_images
        end
      end
    end
  end

  def destroy
    @task = Task.find(params[:id]);
    work_id = @task.work_id
    @task.destroy

    flash[:delete_task_success] = t('delete_task_success')
    redirect_to work_url(work_id)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end

  # Save array of images to this task
  def save_task_images
    if params[:file].empty? || @task.save_images(params[:file])
      render json: { status: 1, message: t('create_image_success'), redirect_url: work_url(@work) }
    else
      @task.destroy
      render status: 400, json: { status: 0, message: t('upload_image_error') }
    end
  end
end
