class UsersController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  api :GET, "/users/transactions", "List all transactions belonging to a user"
  param :id, :number, desc: 'Id for login', required: true
  param :password, String, desc: 'Password for login', required: true
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

  api :GET, '/users/top_total_transaction', "The top x users by total transaction amount within a date range"
  param :start_date, String, desc: 'start date transaction', required: true
  param :end_date, String, desc: 'end date transaction', required: true
  def top_total_transaction
    users = User.top_total_transaction(params[:start_date], params[:end_date])
    render json: users
  end

  api :GET, "/users/total_by_transactions_above", "Total number of users who made transactions above $v within a date range"
  param :amount, :number, desc: 'amount of transaction', required: true
  param :start_date, String, desc: 'start date transaction', required: true
  param :end_date, String, desc: 'end date transaction', required: true
  def total_by_transactions_above
    users = User.get_by_transactions_above(params[:amount], params[:start_date], params[:end_date]).length
    render json: { "total_users": users}
  end

  api :GET, "/users/total_by_transactions_below", "Total number of users who made transactions below $v within a date range"
  param :amount, :number, desc: 'amount of transaction', required: true
  param :start_date, String, desc: 'start date transaction', required: true
  param :end_date, String, desc: 'end date transaction', required: true
  def total_by_transactions_below
    users = User.get_by_transactions_below(params[:amount], params[:start_date], params[:end_date]).length
    render json: { "total_users": users}
  end

  api :GET, '/users/near_by', "List all restaurants within the vicinity of the user’s location"
  param :user_id, :number, desc: 'id of the requested user'
  def near_by
    user = User.find(params[:user_id])
    @restaurants = Restaurant.near(user.location, 10).order("distance")
    render json: @restaurants
  end

end
