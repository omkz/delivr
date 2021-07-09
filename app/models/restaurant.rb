class Restaurant < ApplicationRecord
  include PgSearch::Model

  has_many :business_hours
  has_many :menus
  has_many :purchases

  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude

  pg_search_scope   :search_by_name,
                    :against => :name,
                    :using => { :tsearch => { :dictionary => "english" }},
                    :associated_against => { :menus => :name }


  def self.search_by_dishes(query)
    joins(:menus).where("menus.name ILIKE ?", "%#{query}%")
  end

  def self.search_by_dishes_price_range(min, max)
    includes(:menus).where("menus.price BETWEEN ? AND ?", min, max).references(:menus)
  end

  def self.most_popular
    joins(:purchases).
      select("restaurants.id, restaurants.name, sum(purchases.amount) AS total_amount, count(purchases.restaurant_id) AS total_transactions").
      order("total_amount DESC").order("total_transactions DESC").
      group("purchases.restaurant_id, restaurants.name, restaurants.id")
  end

end
