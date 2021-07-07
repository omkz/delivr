class RestaurantSerializer
  include JSONAPI::Serializer
  attributes :name, :balance, :latitude, :longitude
  has_many :menus
end
