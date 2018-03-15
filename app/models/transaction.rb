class Transaction < ApplicationRecord
  belongs_to :invoice
  validates_presence_of :credit_card_number, :result, :created_at, :updated_at

  scope :successful, -> { where(result: "success") }

  def self.transactions_by_customer(customer_id)
    select("transactions.*")
      .joins(invoice: [:customer])
      .where("customers.id = #{customer_id}")
      .order(:id)
  end 

  def self.total_revenue_for_date(date)
    date = DateTime.strptime(date, '%Y-%m-%d')
    select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoice: [:invoice_items])
      .merge(Transaction.successful)
      .where(invoices: {updated_at: (date.beginning_of_day..date.end_of_day)})
      .group(:id)
      .sum(&:revenue)
  end
end
