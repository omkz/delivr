class MenuSerializer
  include JSONAPI::Serializer
  attributes :name, :price
  belongs_to :restaurant
end
