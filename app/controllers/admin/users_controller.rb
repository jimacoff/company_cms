# Admin User Controller
class Admin::UsersController < Admin::BaseController
  # Render edit account form
  def edit
    @user = current_user
  end

  # Process update account form
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      redirect_to account_url, flash: { success: t(:update_user_success) }
    else
      render 'edit'
    end
  end

  private

  # Only allow necessary fields
  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation, :old_password)
  end
end
