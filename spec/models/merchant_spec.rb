require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  describe "Relationships" do
    it {should have_many(:invoices)}
    it {should have_many(:items)}
  end

  describe "Class methods" do
    before(:each) do
      @top_merchant = create(:merchant)
      @second_merchant = create(:merchant)
      @bottom_merchant = create(:merchant)
      create_list(:merchant, 3)
      customer = create(:customer)
      invoice_1 = create(:invoice,
                         customer: customer,
                         merchant: @top_merchant)
      invoice_2 = create(:invoice,
                         customer: customer,
                         merchant: @second_merchant)
      invoice_3 = create(:invoice,
                         customer: customer,
                         merchant: @bottom_merchant)
      invoice_4 = create(:invoice,
                         customer: customer,
                         merchant: @bottom_merchant)
      create(:transaction, invoice: invoice_1)
      create(:transaction, invoice: invoice_2)
      create(:transaction, invoice: invoice_3, result: "failed")
      create(:transaction, invoice: invoice_4, result: "failed")
      item = create(:item, merchant: @top_merchant)
      create_list(:invoice_item, 3,
                  quantity: 2,
                  unit_price: 1000,
                  item: item,
                  invoice: invoice_1)
      create_list(:invoice_item, 2,
                  quantity: 3,
                  unit_price: 500,
                  item: item,
                  invoice: invoice_2)
      create_list(:invoice_item, 1,
                  quantity: 1,
                  unit_price: 1800,
                  item: item,
                  invoice: invoice_3)
      create(:invoice_item,
             quantity: 100,
             unit_price: 500000,
             item: item,
             invoice: invoice_4)
    end

    describe "#top_merchants_by_revenue" do
      it "returns top x merchants" do
        expect(Merchant.top_merchants_by_revenue(2)).to eq([@top_merchant, @second_merchant])

        expect(Merchant.top_merchants_by_revenue(1)).to eq([@top_merchant])
      end
    end
  end
end
