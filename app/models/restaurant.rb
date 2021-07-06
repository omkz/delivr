class Restaurant < ApplicationRecord
  has_many :business_hours
  has_many :menus

end
