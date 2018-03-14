require 'rails_helper'

describe "Relationship endpoints for merchants" do
  it "returns a collection of items for a given merchant" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/merchants/1/items"

    merchant_items = JSON.parse(response.body)

    expect(merchant_items.count).to eq(2)
    expect(merchant_items.first["id"]).to eq(1)
    expect(merchant_items.last["id"]).to eq(2)
  end
end
