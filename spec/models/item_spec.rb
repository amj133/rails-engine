require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  describe "Relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe "Class methods" do
    describe "#top_items_by_total_revenue" do
      it "returns top x items by total revenue" do
        customer = create(:customer)
        merchant = create(:merchant)
        invoice_1 = create(:invoice, customer: customer, merchant: merchant)
        invoice_2 = create(:invoice, customer: customer, merchant: merchant)
        invoice_3 = create(:invoice, customer: customer, merchant: merchant)
        transaction_1 = create(:transaction, invoice: invoice_1)
        transaction_2 = create(:transaction, invoice: invoice_2)
        transaction_3 = create(:transaction, invoice: invoice_3, result: "failed")

        top_item = create(:item, merchant: merchant)
        middle_item = create(:item, merchant: merchant)
        bottom_item = create(:item, merchant: merchant)

        create(:invoice_item, invoice: invoice_1,
               quantity: 5, unit_price: 2, item: top_item)
        create(:invoice_item, invoice: invoice_2,
               quantity: 4, unit_price: 2, item: middle_item)
        create(:invoice_item, invoice: invoice_3,
               quantity: 6, unit_price: 2, item: bottom_item)

        expect(Item.top_items_by_total_revenue(2).to_a.count).to eq(2)
        expect(Item.top_items_by_total_revenue(2).first).to eq(top_item)
        expect(Item.top_items_by_total_revenue(2).last).to eq(middle_item)
        expect(Item.top_items_by_total_revenue(1).last).to eq(top_item)
      end

      it 'returns items by most sold' do
        merchant = create(:merchant)
        customer = create(:customer)
        item = create(:item, merchant: merchant)
        item2 = create(:item, merchant: merchant)
        item3 = create(:item, merchant: merchant)
        item4 = create(:item, merchant: merchant)
        invoice1 = create(:invoice, customer: customer, merchant: merchant)
        invoice2 = create(:invoice, customer: customer, merchant: merchant)
        invoice3 = create(:invoice, customer: customer, merchant: merchant)
        invoice4 = create(:invoice, customer: customer, merchant: merchant)
        create(:transaction, invoice: invoice1)
        create(:transaction, invoice: invoice2)
        create(:transaction, invoice: invoice3)
        create(:transaction, invoice: invoice4)
        create(:invoice_item, invoice: invoice1, item: item, quantity: 100)
        create(:invoice_item, invoice: invoice2, item: item2, quantity: 50)
        create(:invoice_item, invoice: invoice3, item: item3, quantity: 30)
        create(:invoice_item, invoice: invoice4, item: item4, quantity: 2)

        expect(Item.most_items_sold(3)).to eq([item, item2, item3])
      end
    end
  end
end
