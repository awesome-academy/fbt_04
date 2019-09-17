class SessionsController < ApplicationController
  layout "layouts/login"
  
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate params[:session][:password]
      log_in user
      check_remember user
      redirect_to root_path
    else
      flash.now[:danger] = t "controllers.sessions.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private 

  def check_remember user
    return remember user if params[:session][:remember_me] == Settings.remember
    forget user
  end
end
