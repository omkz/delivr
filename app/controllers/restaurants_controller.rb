class RestaurantsController < ApplicationController

  def search
    restaurants = Restaurant.search_by_name(params[:query])
    options = {
      include: [:menus]
    }
    render json: RestaurantSerializer.new(restaurants, options)
  end

  def transactions
    restaurant = Restaurant.find(params[:id])
    transactions = restaurant.purchases
    render json: transactions
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

  def near_by
    @restaurants = Restaurant.near(params[:location]).order("distance")
    render json: @restaurants
  end

  def open_at
    @restaurants = Restaurant.open_at(params[:time])
    render json: @restaurants
  end

  def opening_hours_per_day
    @restaurants = Restaurant.opening_hours_per_day(params[:hours_x], params[:hours_z])
    render json: @restaurants
  end

  def opening_hours_per_week
    @restaurants = Restaurant.opening_hours_per_week(params[:x_hours], params[:z_hours])
    render json: @restaurants
  end

end
