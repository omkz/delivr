class RestaurantsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def transactions
    authenticate_with_http_basic do |id, password|
      user = Restaurant.find(id)
      if user && password == "hungry12345678"
        @restaurants = Restaurant.find(id)
        @transactions = @restaurants.purchases
        render json: @transactions
      else
        render json: { error: 'Incorrect credentials' }, status: 401
      end
    end
  end

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
