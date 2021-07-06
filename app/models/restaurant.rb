class Restaurant < ApplicationRecord
  has_many :business_hours
  has_many :menus

  def self.search_by_dishes(query)
    joins(:menus).where("menus.name ILIKE ?", "%#{query}%")
  end

end
