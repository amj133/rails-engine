require 'rails_helper'

describe "Merchants with most revenue API finder" do
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

  it "returns top x merchants by most revenue" do
    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(2)
    expect(merchants.first["id"]).to eq(1)
    expect(merchants.last["id"]).to eq(2)
    expect(response.status).to eq(200)
  end
end
