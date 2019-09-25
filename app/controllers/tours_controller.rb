class ToursController < ApplicationController
  def index
    @tours = Tour.sort_by_created_at.paginate page: params[:page],
      per_page: Settings.tour.length
  end
end
