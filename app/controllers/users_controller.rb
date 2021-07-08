class UsersController < ApplicationController
  def top_total_transaction
    users = User.top_total_transaction(params[:start_date], params[:end_date])
    render json: users
  end

end
