class Restaurant < ApplicationRecord
  has_many :business_hours
  has_many :menus

  def self.search_by_dishes(query)
    joins(:menus).where("menus.name ILIKE ?", "%#{query}%")
  end

  def self.search_by_dishes_price_range(min,max)
    includes(:menus).where("menus.price BETWEEN ? AND ?", min, max).references(:menus)
  end

end
