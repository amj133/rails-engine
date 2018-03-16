require 'rails_helper'

describe "Invoice Items Relationships" do
    before(:all) do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      item = create(:item, merchant: merchant)
      create(:invoice_item, invoice: invoice, item: item)
    end

    it "should return invoice" do
      get '/api/v1/invoice_items/1/invoice'

      expect(response).to be_success

      invoice = JSON.parse(response.body)

      expect(invoice['id']).to eq(1)
      expect(invoice['customer_id']).to eq(1)
    end

    it "should return item" do
      get '/api/v1/invoice_items/1/item'

      expect(response).to be_success

      item = JSON.parse(response.body)

      expect(item['name']).to eq('MyString')
      expect(item['merchant_id']).to eq(1)
    end
end
