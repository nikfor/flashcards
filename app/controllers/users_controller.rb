  class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if User.authenticate(params[:user][:email], params[:user][:old_password])
      if @user.update(user_params.except(:old_password))
        redirect_to users_path(@user)
      else
        render "edit"
      end
    else
      render "edit"
      flash.now[:alert] = t('user.enter_true_old_password')
    end
  end

  private

  def find_user
    @user = current_user
    render_404 unless @user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :old_password)
  end

end
