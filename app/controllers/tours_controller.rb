class ToursController < ApplicationController
  def index
    @tours = Tour.sorttour.paginate page: params[:page],
      per_page: Settings.tour.length
  end
end
