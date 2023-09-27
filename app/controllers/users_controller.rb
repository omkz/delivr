class UsersController < ApplicationController

  def transactions
    user = User.find(params[:id])
    transactions = user.purchases
    render json: transactions
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
