class User < ApplicationRecord
  has_many :purchases
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def self.top_total_transaction(start_date, end_date)
    joins(:purchases).
      select("users.id AS id, users.name, sum(purchases.amount) AS total").
      where("purchases.date BETWEEN ? AND ?", start_date, end_date).
      order("total desc").
      group("users.name, users.id")
  end

  def self.get_by_transactions_above(amount, start_date, end_date)
    joins(:purchases).
      where("purchases.date BETWEEN ? AND ?", start_date, end_date).
      having('SUM(purchases.amount) > ?', amount).
      group("users.id")
  end

  def self.get_by_transactions_below(amount, start_date, end_date)
    joins(:purchases).
      where("purchases.date BETWEEN ? AND ?", start_date, end_date).
      having('SUM(purchases.amount) < ?', amount).
      group("users.id")
  end

  def location
    latitude.to_s << "," << longitude.to_s
  end

  def reduce_balance(amount)
    update! balance: balance - amount
  end
end
