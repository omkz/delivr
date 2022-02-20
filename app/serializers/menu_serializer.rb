class MenuSerializer
  include JSONAPI::Serializer
  attributes :name, :price, :restaurant
  belongs_to :restaurant, serializer: RestaurantSerializer
end
