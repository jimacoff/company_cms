# Tasks Controller to handle tasks
class Admin::TasksController < Admin::BaseController
  def show
    @task = Task.find(params[:id])
    render layout: false
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
          save_task_images work_url(@work)
        end
      end
    end
  end

  def edit
    @task = Task.find(params[:id])
    # Status after update succuess
    @status = params[:update] != 1 ? nil : t('update_task_success')
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      # when there is no image upload process as normal
      format.html do
        if @task.update(task_params)
          flash[:success] = t('update_task_success')
          redirect_to edit_task_path(@task)
        else
          render 'edit'
        end
      end

      format.json do
        if !@task.update(task_params)
          render status: 400, json: { status: 0, message: @task.errors.messages }
        else
          redirect_url = edit_task_url(@task) + '?update=1'
          save_task_images redirect_url
        end
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
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
  def save_task_images(redirect_url)
    if params[:file].empty? || @task.save_images(params[:file])
      render json: { status: 1, message: t('create_image_success'), redirect_url: redirect_url }
    else
      @task.destroy
      render status: 400, json: { status: 0, message: t('upload_image_error') }
    end
  end
end
