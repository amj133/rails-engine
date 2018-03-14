class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  validates_presence_of :status, :created_at, :updated_at

  # default_scope { joins(:transactions).distinct }
  # scope :paid, -> { joins(:transactions).where(transactions: {result: "success"}).distinct }#{ where(published: true) }
end
