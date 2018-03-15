require 'rails_helper'

describe "Merchant Revenue API" do
  before(:each) do
    @merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice,
                       customer: customer,
                       merchant: @merchant)
    item = create(:item, merchant: @merchant)
    create(:transaction, invoice: invoice_1)
    create(:invoice_item, invoice: invoice_1, item: item, quantity: 5, unit_price: 2000)
  end
  it "returns customer revenue" do
    get '/api/v1/merchants/1/revenue'

    expect(response).to be_success

    revenue = JSON.parse(response.body)

    expect(revenue['revenue']).to eq('100.0')
  end
end
