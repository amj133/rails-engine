class ItemSerializer < ActiveModel::Serializer
  attributes :id, :unit_price, :name, :description, :merchant_id

  def unit_price
    (object.unit_price / 100.0).round(2).to_s
  end
end
