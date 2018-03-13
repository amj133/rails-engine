class Transaction < ApplicationRecord
  belongs_to :invoice
  validates_presence_of :credit_card_number, :result, :created_at, :updated_at

  default_scope { where(result: "success") }#{ where(published: true) }
end
