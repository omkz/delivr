class User < ApplicationRecord
  has_many :purchases
  
  def self.top_total_transaction(start_date, end_date)
    joins(:purchases).
      select("users.id AS id, users.name, sum(purchases.amount) AS total").
      where("purchases.date BETWEEN ? AND ?", start_date, end_date).
      order("total desc").
      group("users.name, users.id")

  end
end
