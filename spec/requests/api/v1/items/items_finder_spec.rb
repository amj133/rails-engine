require 'rails_helper'

describe "Items finder API" do
  before(:all) do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    create(:item, merchant: merchant_1)
    create(:item,
           name: "Billy",
           description: "Muffins are awesome",
           unit_price: 1550,
           merchant: merchant_2,
           created_at: DateTime.new(2018, 03, 12, 17, 10, 49),
           updated_at: DateTime.new(2018, 03, 13, 17, 10, 49))
    create(:item, merchant: merchant_1)
  end

  describe "can find by single attribute" do
    it "can find one item by id" do
      get "/api/v1/items/find?id=2"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.class).to eq(Hash)
      expect(item["id"]).to eq(2)
    end

    it "can find one item by name, case-insensitive" do
      get "/api/v1/items/find?name=Billy"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.class).to eq(Hash)
      expect(item["id"]).to eq(2)

      get "/api/v1/items/find?name=billy"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.class).to eq(Hash)
      expect(item["id"]).to eq(2)
    end

    it "can find one item by description, case-insensitive" do
      get "/api/v1/items/find?description=muffins are awesome"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.class).to eq(Hash)
      expect(item["id"]).to eq(2)
    end

    it "can find one item by unit price" do
      get "/api/v1/items/find?unit_price=15.50"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.class).to eq(Hash)
      expect(item["id"]).to eq(2)
    end

    it "can find one item by merchant id" do
      get "/api/v1/items/find?merchant_id=2"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.class).to eq(Hash)
      expect(item["id"]).to eq(2)
    end

    it "can find one item by created at" do
      get "/api/v1/items/find?created_at=2018-03-12T17:10:49.000Z"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.class).to eq(Hash)
      expect(item["id"]).to eq(2)
    end

    it "can find one item by updated at" do
      get "/api/v1/items/find?updated_at=2018-03-13T17:10:49.000Z"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.class).to eq(Hash)
      expect(item["id"]).to eq(2)
    end
  end

  describe "can find by multiple attributes" do
    it "can find multiple by merchant id" do
      get "/api/v1/items/find_all?merchant_id=1"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
      expect(items.first["id"]).to eq(1)
      expect(items.last["id"]).to eq(3)
    end

    it "can find by merchant id and created at" do
      get "/api/v1/items/find_all", params: {merchant_id: 2, created_at: "2018-03-12T17:10:49.000Z"}

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(1)
      expect(items.first["id"]).to eq(2)
    end
  end
end
