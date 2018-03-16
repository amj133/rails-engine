class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :created_at, :updated_at
  has_many :invoices, dependent: :destroy
  has_many :merchants, through: :invoices

  default_scope { order(:id) }

  def favorite_merchant
    merchants
      .select('merchants.*, COUNT(transactions) as transaction_count')
      .joins(invoices: :transactions)
      .unscope(:order)
      .group(:id)
      .order('transaction_count DESC')
      .first
  end

end
