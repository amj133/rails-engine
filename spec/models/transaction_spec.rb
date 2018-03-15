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

  describe "Class methods" do
    before(:all) do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice_1 = create(:invoice, customer: customer, merchant: merchant, updated_at: DateTime.strptime("2012-03-16", '%Y-%m-%d'))
      invoice_2 = create(:invoice, customer: customer, merchant: merchant, updated_at: DateTime.strptime("2012-03-16", '%Y-%m-%d'))
      invoice_3 = create(:invoice, customer: customer, merchant: merchant, updated_at: DateTime.strptime("2012-03-18", '%Y-%m-%d'))
      transaction_1 = create(:transaction, result: "success", invoice: invoice_1)
      transaction_2 = create(:transaction, result: "success", invoice: invoice_2)
      transaction_3 = create(:transaction, result: "success", invoice: invoice_3)
      item = create(:item, merchant: merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, quantity: 1, unit_price: 2, item: item)
      invoice_item_2 = create(:invoice_item, invoice: invoice_2, quantity: 3, unit_price: 4, item: item)
      invoice_item_3 = create(:invoice_item, invoice: invoice_3, quantity: 5, unit_price: 6, item: item)
    end

    before(:all) do
      customer = create(:customer, id: 23)
      merchant = create(:merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      @transactions = create_list(:transaction, 2, invoice: invoice)
    end

    describe "#transactions_by_customer" do
      it "returns transactions for given customer" do
        expect(Transaction.transactions_by_customer(23)).to eq(@transactions)
      end
    end 

    describe "#total_revenue_for_date" do
      it "returns total revenue across all merchants for given date" do
        expect(Transaction.total_revenue_for_date("2012-03-16")).to eq(14)
      end
    end
  end
end
