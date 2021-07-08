class RestaurantsController < ApplicationController
  def search_by_dishes
    @restaurants = Restaurant.search_by_dishes(params[:query])
    render json: @restaurants
  end

  def search_by_dishes_price_range
    restaurants = Restaurant.search_by_dishes_price_range(params[:min], params[:max])
    options = {
      include: [:menus]
    }
    render json: RestaurantSerializer.new(restaurants, options)
  end

  def most_popular
    restaurants= Restaurant.most_popular
    render json: restaurants
  end

end
