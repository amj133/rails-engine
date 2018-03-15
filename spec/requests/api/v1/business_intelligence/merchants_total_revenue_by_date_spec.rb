require 'rails_helper'

describe "Merchants total revenue by date API Finder" do
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

  it "returns total revenue across merchants for given date" do
    get "/api/v1/merchants/revenue?date=2012-03-16"

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue).to eq({"total_revenue" => "0.14"})
  end
end
