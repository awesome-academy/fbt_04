class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :load_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new load_params
    if @user.save
      flash[:success] = t "controllers.signup.success"
      redirect_to root_path
    else
      flash[:danger] = t "controllers.signup.fail"
      render :new
    end
  end

  def show
    @reviews = @user.reviews.paginate page: params[:page],
                                      per_page: Settings.user.length.per_page
    return if @reviews.any?
    flash[:danger] = t "controllers.reviews.notfound"
  end

  def edit; end

  def update
    if @user.update_attributes load_params
      flash[:success] = t "controllers.users.profiless"
      redirect_to @user
    else
      flash[:danger] = t "controllers.users.profilefail"
      render :edit
    end
  end

  private

  def load_params
    params.require(:user).permit :fullname, :email, :phone,
      :address, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "controllers.users.danger"
    redirect_to current_user
  end

  def correct_user
    return if current_user? @user
    flash[:danger] = t "controllers.users.danger"
    redirect_to current_user
  end
end
