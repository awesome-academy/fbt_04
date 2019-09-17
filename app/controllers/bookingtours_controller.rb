class BookingtoursController < ApplicationController
  before_action :load_tour, only: :create

  def create
    @bookingtour = current_user.booking_tours.build(tour: @tour)
    if @bookingtour.save
      flash[:success] = t "controllers.bookingtours.create.success"
      redirect_to root_path
    else
      flash[:danger] = t "controllers.bookingtours.create.danger"
      redirect_to request.referrer || root_url
    end
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour
    flash[:danger] = t "controllers.bookingtours.load_tour.danger"
    redirect_to root_path
  end
end
