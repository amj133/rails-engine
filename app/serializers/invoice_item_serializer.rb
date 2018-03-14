class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :invoice_id, :item_id, :unit_price
end
