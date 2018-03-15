require 'rails_helper'

describe "Merchant Revenue By Date API" do
  before(:each) do
    @merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice,
                       customer: customer,
                       merchant: @merchant,
                       updated_at: '2015-03-22T03:55:09.000Z')
    invoice_2 = create(:invoice,
                       customer: customer,
                       merchant: @merchant,
                       updated_at: '2015-03-22T06:55:09.000Z')
    item = create(:item, merchant: @merchant)
    create(:transaction, invoice: invoice_1)
    create(:transaction, invoice: invoice_2)
    create(:invoice_item, invoice: invoice_1, item: item, quantity: 5, unit_price: 2000)
    create(:invoice_item, invoice: invoice_2, item: item, quantity: 5, unit_price: 2000)
  end

  it "returns revenue for date" do
    get "/api/v1/merchants/revenue?date=2015-03-22"

    expect(response).to be_success

    revenue = JSON.parse(response.body)

    expect(revenue['total_revenue']).to eq('200.0')
  end
end
