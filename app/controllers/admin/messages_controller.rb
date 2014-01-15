class Admin::MessagesController < Admin::BaseController
  before_action :signed_in_user, except: [:create]
  def index
    @messages = Message.order(created_at: :desc).paginate(page: params[:page])
  end

  def destroy
    Message.find(params[:id]).destroy
    flash[:success] = t('delete_message_success')
    redirect_to messages_url
  end
end
