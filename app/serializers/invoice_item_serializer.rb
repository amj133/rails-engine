class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :invoice_id, :item_id, :unit_price

  def unit_price
    sprintf('%.2f', (object.unit_price / 100.0).round(2))
  end
end
