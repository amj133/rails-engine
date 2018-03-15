require 'rails_helper'

describe "Items Most Items API" do
  before(:each) do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)
    item4 = create(:item, merchant: merchant)
    invoice1 = create(:invoice, customer: customer, merchant: merchant)
    invoice2 = create(:invoice, customer: customer, merchant: merchant)
    invoice3 = create(:invoice, customer: customer, merchant: merchant)
    invoice4 = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, invoice: invoice1)
    create(:transaction, invoice: invoice2)
    create(:transaction, invoice: invoice3)
    create(:transaction, invoice: invoice4)
    create(:invoice_item, invoice: invoice1, item: item, quantity: 100)
    create(:invoice_item, invoice: invoice2, item: item2, quantity: 50)
    create(:invoice_item, invoice: invoice3, item: item3, quantity: 30)
    create(:invoice_item, invoice: invoice4, item: item4, quantity: 2)
  end
  it "returns items by the most sold" do
    get '/api/v1/items/most_items?quantity=3'

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items[0]['id']).to eq(1)
    expect(items[1]['id']).to eq(2)
    expect(items[2]['id']).to eq(3)
  end
end
