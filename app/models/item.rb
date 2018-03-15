class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates_presence_of :name, :description, :unit_price, :created_at, :updated_at

  def self.random
    order('RANDOM()').first
  end

  def self.top_items_by_total_revenue(quantity)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoice_items: [invoice: [:transactions]])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("revenue DESC")
      .limit(quantity)
  end

  def self.most_items_sold(quantity)
    select('items.*, SUM(invoice_items.quantity) AS items_sold')
      .joins(:invoice_items)
      .group(:id)
      .order('items_sold DESC')
      .limit(quantity)
  end

  def best_day
    invoices
      .select('invoices.created_at, SUM(invoice_items.quantity) as items_sold')
      .joins(:transactions, :invoice_items)
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order('items_sold DESC')
      .first
  end

end
