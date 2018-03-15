require 'rails_helper'

describe "Invoice items API" do
  before(:all) do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    create(:invoice_item, invoice: invoice_1, item: item)
    create(:invoice_item, invoice: invoice_2, item: item)
  end

  it "sends a list of invoice items" do
    get "/api/v1/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first["id"]).to eq(1)
    expect(invoice_items.last["id"]).to eq(2)
  end

  it "can get one invoice item by id" do
    get "/api/v1/invoice_items/1"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
    expect(invoice_item["id"]).to eq(1)
  end
end
