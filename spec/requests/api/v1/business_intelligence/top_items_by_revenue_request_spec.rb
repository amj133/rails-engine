require 'rails_helper'

describe "Top items by total revenue Finder API" do
  it "returns top x items by total revenue" do
    get "/api/v1/items/most_revenue?quantity=2"

    items = JSON.parse(response.body)

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

    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(1)
    expect(items.last["id"]).to eq(2)
  end
end
