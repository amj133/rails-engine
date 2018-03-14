require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:credit_card_number)}
    it {should validate_presence_of(:result)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  describe "Relationships" do
    it {should belong_to(:invoice)}
  end

  describe "Scopes" do
    it "scope returns successful transactions" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      transaction_1 = create(:transaction, result: "success", invoice: invoice)
      transaction_2 = create(:transaction, result: "failed", invoice: invoice)
      transaction_3 = create(:transaction, result: "pending", invoice: invoice)
      transaction_4 = create(:transaction, result: "success", invoice: invoice)

      expect(Transaction.successful).to eq([transaction_1, transaction_4])
    end
  end
end
