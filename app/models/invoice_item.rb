class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :invoices
  validates_presence_of :quantity, :unit_price, :created_at, :updated_at

  default_scope { order(:id) }
end
