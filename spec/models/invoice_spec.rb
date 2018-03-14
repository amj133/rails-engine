require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  describe "Relationships" do
    it {should belong_to(:merchant)}
    it {should belong_to(:customer)}
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe "Scope" do
    it "default scope returns invoices with a successful transaction" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice_1 = create(:invoice, customer: customer, merchant: merchant)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant)
      invoice_3 = create(:invoice, customer: customer, merchant: merchant)
      transaction_1 = create(:transaction, result: "success", invoice: invoice_1)
      transaction_2 = create(:transaction, result: "failed", invoice: invoice_1)
      transaction_3 = create(:transaction, result: "pending", invoice: invoice_2)
      transaction_4 = create(:transaction, result: "success", invoice: invoice_3)

      expect(Invoice.all).to eq([invoice_1, invoice_3])
    end
  end
end
