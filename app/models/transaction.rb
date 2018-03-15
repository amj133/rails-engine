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
end
