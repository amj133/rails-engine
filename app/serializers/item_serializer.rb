class ItemSerializer < ActiveModel::Serializer
  attributes :id, :unit_price, :name, :description, :merchant_id

  def unit_price
    sprintf('%.2f', (object.unit_price / 100.0).round(2))
  end
end
