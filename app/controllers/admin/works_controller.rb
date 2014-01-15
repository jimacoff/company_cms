# Admin work controller
class Admin::WorksController < Admin::BaseController
  # List all works
  def index
    @works = Work.includes(:images).paginate(page: params[:page])
  end

  # Render new work page
  def new
    @work = Work.new
  end

  # Handle create new work
  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = t('create_work_success')
      redirect_to work_url(@work)
    else
      render 'new'
    end
  end

  # Show the work page
  def show
    @work = Work.find(params[:id])
  end

  # Delete the work
  def destroy
    Work.find(params[:id]).destroy
    flash[:success] = t('work_deleted')
    redirect_to works_url
  end

  # Render edit work's generel info ui
  def edit
    @work = Work.find(params[:id])
  end

  # Handle update work
  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      flash[:success] = t('update_work_success')
      redirect_to work_url(@work)
    else
      render 'edit'
    end
  end

  private

  def work_params
    params.require(:work).permit(:name, :client, :story, :techs)
  end
end
