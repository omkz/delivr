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

  api :GET, "/restaurants/open_at", "List all restaurants that are open at a certain time"
  param :time, String, desc: 'time of business hours', required: true
  def open_at
    @restaurants = Restaurant.open_at(params[:time])
    render json: @restaurants
  end

  api :GET, "/restaurants/opening_hours_per_day", "List all restaurants that are open for x-z hours per day"
  param :hours_x, :number, desc: 'hours of x', required: true
  param :hours_z, :number, desc: 'hours of z', required: true
  def opening_hours_per_day
    @restaurants = Restaurant.opening_hours_per_day(params[:hours_x], params[:hours_z])
    render json: @restaurants
  end

  api :GET, "/restaurants/opening_hours_per_week", "List all restaurants that are open for x-z hours per week"
  param :x_hours, :number, desc: 'hours of x', required: true
  param :z_hours, :number, desc: 'hours of z', required: true
  def opening_hours_per_week
    @restaurants = Restaurant.opening_hours_per_week(params[:x_hours], params[:z_hours])
    render json: @restaurants
  end


end
