require 'rails_helper'

describe "Invoice items finder API" do
  before(:all) do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    create(:invoice_item,
           quantity: 1,
           unit_price: 5,
           invoice: invoice_1,
           item: item,
           created_at: DateTime.new(2018, 03, 12, 17, 10, 49),
           updated_at: DateTime.new(2018, 03, 13, 17, 10, 49))
    create(:invoice_item,
           quantity: 2,
           unit_price: 6,
           invoice: invoice_2,
           item: item,
           created_at: DateTime.new(2018, 04, 12, 17, 10, 49),
           updated_at: DateTime.new(2018, 04, 13, 17, 10, 49))
  end

  it "can find one invoice item by id" do
    get "/api/v1/invoice_items/find?id=1"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(1)
  end

  it "can find one invoice item by item id" do
    get "/api/v1/invoice_items/find?item_id=1"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(1)
  end

  it "can find one invoice item by invoice id" do
    get "/api/v1/invoice_items/find?invoice_id=1"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(1)
  end

  it "can find one invoice item by quantity" do
    get "/api/v1/invoice_items/find?quantity=1"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(1)
  end

  it "can find one invoice item by unit price" do
    get "/api/v1/invoice_items/find?unit_price=5"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(1)
  end

  it "can find one invoice item by created at" do
    get "/api/v1/invoice_items/find?created_at=2018-03-12T17:10:49.000Z"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(1)
  end

  it "can find one invoice item by updated at" do
    get "/api/v1/invoice_items/find?updated_at=2018-03-13T17:10:49.000Z"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(1)
  end

  describe "can find random" do
    it "returns random invoice item" do
      get "/api/v1/invoice_items/random"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item.class).to be(Hash)
      expect(invoice_item["id"].class).to be(Integer)
    end
  end

  describe "can find by multiple attributes" do
    it "can find by item id" do
      get "/api/v1/invoice_items/find_all?item_id=1"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.first["id"]).to eq(1)
      expect(invoice_items.last["id"]).to eq(2)
    end

    it "can find by item id and created at" do
      get "/api/v1/invoice_items/find_all", params: {item_id: 1, created_at: "2018-03-12T17:10:49.000Z"}

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(1)
      expect(invoice_items.first["id"]).to eq(1)
    end

    it "can find by customer id and merchand id" do
      get "/api/v1/invoice_items/find_all", params: {customer_id: 1, merchant_id: 1}

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.first["id"]).to eq(1)
      expect(invoice_items.last["id"]).to eq(2)
    end
  end
end
