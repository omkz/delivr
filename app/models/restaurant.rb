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

  def add_balance(amount)
    update! balance: balance + amount
  end

  def self.open_at(time)
    includes(:business_hours).where("business_hours.open_at >= ? AND business_hours.close_at <= ?", time, time).references(:business_hours)
  end

  def self.opening_hours_per_day(hours_x, hours_z)
    hours_x = hours_x.to_i
    hours_z = hours_z.to_i

    #get restaurant ids
    resto = []
    BusinessHour.all.each do |b|
      opening_hours = (b.close_at - b.open_at) / 1.hours
      if opening_hours > 0
        if opening_hours >= hours_x and opening_hours <= hours_z
          resto << b.restaurant_id
        end
      else
        opening_hours += 24
        if opening_hours >= hours_x and opening_hours <= hours_z
          resto << b.restaurant_id
        end
      end
    end

    where(id: resto.uniq)
  end

end
