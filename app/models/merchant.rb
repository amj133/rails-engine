class Merchant < ApplicationRecord
  validates_presence_of :name, :created_at, :updated_at
  has_many :invoices
  has_many :items

  def self.random
    order('RANDOM()').first
  end

  def self.top_merchants_by_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue").joins(invoices: [:transactions, :invoice_items]).group(:id).order("total_revenue DESC").limit(quantity)
  end

end
