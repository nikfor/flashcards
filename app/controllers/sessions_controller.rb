class SessionsController < ApplicationController

  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    if login(params[:session][:email], params[:session][:password])
      redirect_to root_path, alert: t('user.hello')
    else
      flash.now[:alert] = t('user.not_exist_email_or_password')
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, alert: t('user.bye')
  end

end
