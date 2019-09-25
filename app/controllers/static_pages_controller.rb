class StaticPagesController < ApplicationController
  def home
    @tours = Tour.sort_by_created_at.paginate page: params[:page],
      per_page: Settings.perpage
  end

  def help; end

  def contact; end

  def about; end
end
