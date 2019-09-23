class UsersController < ApplicationController
  layout "layouts/signup"

  def new
    @user = User.new
  end

  def create
    @user = User.new load_params
    if @user.save
      flash[:success] = t "controllers.signup.success"
      redirect_to root_path
    else
      flash[:fail] = t "controllers.signup.fail"
      render :new
    end
  end

  private

  def load_params
    params.require(:user).permit :fullname, :email, :phone,
      :address, :password, :password_confirmation
  end
end
