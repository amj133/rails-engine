require 'rails_helper'

describe "Customer Favorite Merchant API" do
  before(:each) do
    favorite_merchant = create(:merchant, name: 'Favorito Lamora')
    regular_merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: favorite_merchant, customer: customer)
    second_invoice = create(:invoice, merchant: regular_merchant, customer: customer)
    create_list(:transaction, 5, invoice: invoice)
    create(:transaction, invoice: second_invoice)
  end
  it "should return favorite merchant" do
    get '/api/v1/customers/1/favorite_merchant'

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant['id']).to eq(1)
    expect(merchant['name']).to eq('Favorito Lamorag')
  end
end
