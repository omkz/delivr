class RestaurantsController < ApplicationController
  def search_by_dishes
    @restaurants = Restaurant.search_by_dishes(params[:query])
    render json: @restaurants
  end
end
