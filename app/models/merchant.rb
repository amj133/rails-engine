class Merchant < ApplicationRecord
  validates_presence_of :name, :created_at, :updated_at
  has_many :invoices

  def self.random
    order('RANDOM()').first
  end

  def top_merchants_by_revenue(quantity)

  end

end
