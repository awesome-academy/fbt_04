class ReviewsController < ApplicationController
  layout "layouts/reviews"
  def show
    @review = Review.find_by id: params[:id]
    return if @review
    flash[:danger] = t "controllers.reviews.danger"
    redirect_to root_path
  end

  def new; end
end
