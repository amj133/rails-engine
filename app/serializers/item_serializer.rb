class ItemSerializer < ActiveModel::Serializer
  attributes :id, :unit_price, :name, :description
  belongs_to :merchant
end
