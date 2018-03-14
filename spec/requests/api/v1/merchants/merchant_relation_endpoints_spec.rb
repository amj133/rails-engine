require 'rails_helper'

describe "Relationship endpoints for merchants" do
  before(:all) do
    merchant = create(:merchant)
    customer = create(:customer)
    create_list(:item, 2, merchant: merchant)
    create_list(:invoice, 2, merchant: merchant, customer: customer)
  end

  it "returns a collection of items for a given merchant" do
    get "/api/v1/merchants/1/items"

    merchant_items = JSON.parse(response.body)

    expect(merchant_items.count).to eq(2)
    expect(merchant_items.first["id"]).to eq(1)
    expect(merchant_items.first["name"]).to eq(nil)
    expect(merchant_items.last["id"]).to eq(2)
    expect(merchant_items.last["name"]).to eq(nil)
  end

  it "returns a collection of invoices for a given merchant" do
    get "/api/v1/merchants/1/invoices"

    merchant_invoices = JSON.parse(response.body)

    expect(merchant_invoices.count).to eq(2)
    expect(merchant_invoices.first["id"]).to eq(1)
    expect(merchant_invoices.first["name"]).to eq(nil)
    expect(merchant_invoices.last["id"]).to eq(2)
    expect(merchant_invoices.last["name"]).to eq(nil)
  end

end
