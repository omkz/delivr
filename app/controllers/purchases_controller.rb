class PurchasesController < ApplicationController

  def create
    user = User.find(params[:user_id])
    restaurant = Restaurant.find(params[:restaurant_id])
    amount = Menu.find(params[:menu_id]).price

    purchase = Purchase.new(purchase_params) do |p|
      p.amount = amount
      p.date = Time.now
    end

    ActiveRecord::Base.transaction do
      purchase.save!
      user.reduce_balance(amount)
      restaurant.add_balance(amount)
    end

    if purchase.save
      render json: purchase, status: :created, location: purchase
    else
      render json: purchase.errors, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :restaurant_id, :menu_id)
  end
end
