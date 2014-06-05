class SearchController < ApplicationController
  def index
    if params[:query].present? || params[:type].present? || params[:tag].present?
      @results = Search.call(params)
    end
  end
end
