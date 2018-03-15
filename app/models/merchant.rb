class Merchant < ApplicationRecord
  validates_presence_of :name, :created_at, :updated_at
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.random
    order('RANDOM()').first
  end

  def revenue
    invoice_items
      .joins(invoice: :transactions)
      .merge(Transaction.successful)
      .sum('unit_price * quantity')
  end

  def self.top_merchants_by_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.successful)
      .group(:id)
      .order("total_revenue DESC")
      .limit(quantity)
  end

  def favorite_customer
    customers.select("customers.*, COUNT(transactions) AS transaction_count")
      .joins(invoices: [:transactions])
      .merge(Transaction.successful)
      .group(:id)
      .order("transaction_count DESC").first
  end
end
