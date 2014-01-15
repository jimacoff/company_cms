# Front message Controller
class Front::MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html do
          flash[:success] =  t('message_created_success')
          redirect_to root_url
        end

        format.json { render json: { status: 1 } }
      else
        format.html do
          flash[:error] =  t('message_created_fail')
          redirect_to root_url
        end

        format.json { render json: { status: 0 }, status: 500 }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:email, :name, :subject, :message)
  end
end
