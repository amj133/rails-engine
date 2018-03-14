class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates_presence_of :name, :description, :unit_price, :created_at, :updated_at

  def formatted_price
    (unit_price / 100.0).round(2)
  end
end
