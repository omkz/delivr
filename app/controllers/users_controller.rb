class UsersController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def transactions
    authenticate_with_http_basic do |id, password|
      user = User.find(id)
      if user && password == "hungry12345678"
        @user = User.find(id)
        @transactions = @user.purchases
        render json: @transactions
      else
        render json: { error: 'Incorrect credentials' }, status: 401
      end
    end
  end

  def top_total_transaction
    users = User.top_total_transaction(params[:start_date], params[:end_date])
    render json: users
  end

  def total_by_transactions_above
    users = User.get_by_transactions_above(params[:amount], params[:start_date], params[:end_date]).length
    render json: { "total_users": users}
  end

  def total_by_transactions_below
    users = User.get_by_transactions_below(params[:amount], params[:start_date], params[:end_date]).length
    render json: { "total_users": users}
  end

  def near_by
    user = User.find(params[:user_id])
    @restaurants = Restaurant.near(user.location, 10).order("distance")
    render json: @restaurants
  end

end
