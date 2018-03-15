require 'rails_helper'

describe "Items Best Day API" do
  before(:each) do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice1 = create(:invoice, customer: customer, merchant: merchant, created_at: '2015-03-22T03:55:09.000Z')
    invoice2 = create(:invoice, customer: customer, merchant: merchant, created_at: '2013-03-22T03:55:09.000Z')
    invoice3 = create(:invoice, customer: customer, merchant: merchant, created_at: '2012-03-22T03:55:09.000Z')
    invoice4 = create(:invoice, customer: customer, merchant: merchant, created_at: '2014-03-22T03:55:09.000Z')
    create(:transaction, invoice: invoice1)
    create(:transaction, invoice: invoice2)
    create(:transaction, invoice: invoice3)
    create(:transaction, invoice: invoice4)
    create(:invoice_item, invoice: invoice1, item: item, quantity: 100)
    create(:invoice_item, invoice: invoice2, item: item, quantity: 50)
    create(:invoice_item, invoice: invoice3, item: item, quantity: 30)
    create(:invoice_item, invoice: invoice4, item: item, quantity: 2)
  end

  it "returns date of with most sold items" do
    get '/api/v1/items/1/best_day'

    expect(response).to be_success

    date = JSON.parse(response.body)

    expect(date['best_day']).to eq('2015-03-22T03:55:09.000Z')
  end
end
