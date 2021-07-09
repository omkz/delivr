class RestaurantsController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  api :GET, "/restaurants/search", "Searching for restaurants or dishes by name"
  param :query, String, desc: 'keyword of search', required: true
  def search
    restaurants = Restaurant.search_by_name(params[:query])
    options = {
      include: [:menus]
    }
    render json: RestaurantSerializer.new(restaurants, options)
  end

  api :GET, "/restaurants/transactions", "List all transactions belonging to a restaurant"
  param :id, :number, desc: 'Id for login', required: true
  param :password, String, desc: 'Password for login', required: true
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

  api :GET, "/restaurants/search_by_dishes", "Search for restaurants that has a dish matching search term"
  param :query, String, desc: 'keyword', required: true
  def search_by_dishes
    @restaurants = Restaurant.search_by_dishes(params[:query])
    render json: @restaurants
  end

  api :GET, "/restaurants/search_by_dishes_price_range", "List all restaurants that have x-z number of dishes within a price range"
  param :min, :number, desc: 'minimal price', required: true
  param :max, :number, desc: 'maximal price', required: true
  def search_by_dishes_price_range
    restaurants = Restaurant.search_by_dishes_price_range(params[:min], params[:max])
    options = {
      include: [:menus]
    }
    render json: RestaurantSerializer.new(restaurants, options)
  end

  api :GET, "/restaurants/most_popular", "The most popular restaurants by transaction volume"
  def most_popular
    restaurants= Restaurant.most_popular
    render json: restaurants
  end

  api :GET, "/restaurants/near_by", "Get restaurant by any location"
  param :location, String, desc: 'location or latitude longitude', required: true
  def near_by
    @restaurants = Restaurant.near(params[:location]).order("distance")
    render json: @restaurants
  end

end
