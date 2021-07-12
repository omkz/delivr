class BusinessHour < ApplicationRecord
  belongs_to :restaurant
  enum day: { monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7 }

end
