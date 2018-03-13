require 'rails_helper'

describe "Merchants Revenue API" do
  before(:each) do
    @merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: @merchant, customer: customer)
    item = create(:item, merchant: @merchant)
    create(:invoice_item, invoice: invoice, item: item, quantity: 5, unit_price: 200)
    create(:transaction, invoice: invoice)
  end
  xit "should return total revenue for a merchant" do
    get '/api/v1/merchants/1/revenue'

    expect(response).to be_success
  end
end
