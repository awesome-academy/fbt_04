class BookingtoursController < ApplicationController
  before_action :load_tour, only: [:create, :new]

  def new
    @bookingtour = @tour.booking_tours.build
  end

  def create
    @bookingtour = current_user.booking_tours.create(bookingtour_params)
    ActiveRecord::Base.transaction do
      @bookingtour.save
      subtraction_qty
      flash[:success] = t "controllers.bookingtours.create.success"
      redirect_to root_path
    end
  rescue StandardError
    flash[:danger] = t "controllers.bookingtours.create.danger"
    redirect_to request.referrer || root_url
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour
    flash[:danger] = t "controllers.bookingtours.load_tour.danger"
    redirect_to root_path
  end

  def bookingtour_params
    params.require(:booking_tour).permit :name, :phone, :address,
      :amountpeople, :tour_id
  end

  def subtraction_qty
    quantity = @tour.amountpeople - @bookingtour.amountpeople
    @tour.update_attributes amountpeople: quantity
  end
end
