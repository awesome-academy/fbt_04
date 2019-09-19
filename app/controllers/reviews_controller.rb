class ReviewsController < ApplicationController
  layout "layouts/reviews"

  before_action :load_tour, only: [:create, :new]

  def show
    @review = Review.find_by id: params[:id]
    return if @review
    flash[:danger] = t "controllers.reviews.show.danger"
    redirect_to root_path
  end

  def new
    @review = @tour.reviews.new
  end

  def create
    @review = current_user.reviews.create(content: params[:review][:content],
      tour: @tour)
    if @review.save
      flash[:success] = t "controllers.reviews.create.success"
      redirect_to root_path
    else
      flash[:danger] = t "controllers.reviews.create.fail"
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end

  def load_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour
    flash[:danger] = t "controllers.reviews.load_tour.danger"
    redirect_to root_path
  end
end
