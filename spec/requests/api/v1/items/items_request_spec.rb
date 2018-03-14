require 'rails_helper'

describe "Items API" do
  before(:all) do
    merchant = create(:merchant)
    create_list(:item, 2, merchant: merchant)
  end

  it "sends a list of items" do
    get "/api/v1/items"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(1)
    expect(items.last["id"]).to eq(2)
  end

  it "can get one item by its id" do
    get "/api/v1/items/2"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item.class).to eq(Hash)
    expect(item["id"]).to eq(2)
  end
end
