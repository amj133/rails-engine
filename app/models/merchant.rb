class Merchant < ApplicationRecord
  validates_presence_of :name, :created_at, :updated_at
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  default_scope { order(:id) }

  def self.random
    order('RANDOM()').first
  end

  def revenue
    invoice_items
      .joins(invoice: :transactions)
      .unscope(:order)
      .merge(Transaction.successful)
      .sum('unit_price * quantity')
  end

  def self.top_merchants_by_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.unscoped.successful)
      .unscope(:order)
      .group(:id)
      .order("total_revenue DESC")
      .limit(quantity)
  end

  def favorite_customer
    customers
      .select("customers.*, COUNT(transactions) AS transaction_count")
      .joins(invoices: :transactions)
      .unscope(:order)
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("transaction_count DESC").first
  end

  def self.merchants_with_most_items(quantity)
    select('merchants.*, SUM(invoice_items.quantity) AS items_sold')
      .joins(invoices: [:transactions, :invoice_items])
      .unscope(:order)
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order('items_sold DESC')
      .limit(quantity)
  end

  def customers_with_pending_invoices
    customers
      .find_by_sql("SELECT customers.* FROM customers INNER JOIN invoices ON customers.id = invoices.customer_id INNER JOIN transactions ON transactions.invoice_id = invoices.id WHERE transactions.result = 'failed' AND invoices.merchant_id = #{self.id} EXCEPT SELECT customers.* FROM customers INNER JOIN invoices ON customers.id = invoices.customer_id INNER JOIN transactions ON transactions.invoice_id = invoices.id WHERE transactions.result = 'success' AND invoices.merchant_id = #{self.id}")
  end

  def revenue_by_date(date)
    date = DateTime.parse(date)
    invoice_items
      .joins(invoice: :transactions)
      .unscope(:order)
      .merge(Transaction.unscoped.successful)
      .where(invoices: {updated_at: date.beginning_of_day..date.end_of_day})
      .sum('unit_price * quantity')
  end

end
