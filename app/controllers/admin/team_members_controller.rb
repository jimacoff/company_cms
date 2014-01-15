# TeamMembers Controller
class Admin::TeamMembersController < Admin::BaseController
  include Admin::ImagesHelper
  before_action :remove_old_cache, only: [:create, :update]

  # Render list team members
  def index
    @members = TeamMember.paginate page: params[:page]
  end

  # Handle delete team members
  def destroy
    TeamMember.find(params[:id]).destroy
    flash[:success] = t('member_deleted')
    redirect_to team_members_url
  end

  # Render the new member view
  def new
    @member = TeamMember.new
  end

  # Hanlde create a new team member
  def create
    @member = TeamMember.new(team_member_params)
    if @member.save
      flash[:success] = t('create_team_member_success')
      redirect_to team_members_url
    else
      render 'new'
    end
  end

  # Render member edit UI
  def edit
    @member = TeamMember.find(params[:id])
  end

  # Handle update a member
  def update
    @member = TeamMember.find(params[:id])
    @old_avatar_url = @member.avatar_url
    if @member.update(team_member_params)
      flash[:success] = t('update_team_member_success')
      redirect_to edit_team_member_path(@member)
    else
      render 'edit'
    end
  end

  private

  def team_member_params
    params.require(:team_member).permit(:title, :name, :avatar,
                                        :avatar_cache, :description)
  end
end
