class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  belongs_to :menu
end
