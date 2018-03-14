class ItemSerializer < ActiveModel::Serializer
  attributes :id, :formatted_price, :name, :description
end
