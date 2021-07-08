class UsersController < ApplicationController
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

end
