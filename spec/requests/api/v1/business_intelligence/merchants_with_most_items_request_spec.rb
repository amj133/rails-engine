require 'rails_helper'

describe "Merchant Most Items API" do
  before(:each) do
    top_merchant = create(:merchant, name: "Favorito Lamora")
    middle_merchant = create(:merchant, name: "Adequito Masquera")
    bottom_merchant = create(:merchant, name: "Horriblea Formalsin")
    unimportant_merchant = create(:merchant, name: "The Unnamed One")
    customer = create(:customer)
    item = create(:item, merchant: top_merchant)
    item2 = create(:item, merchant: middle_merchant)
    item3 = create(:item, merchant: bottom_merchant)
    item4 = create(:item, merchant: unimportant_merchant)
    invoice1 = create(:invoice, customer: customer, merchant: top_merchant)
    invoice2 = create(:invoice, customer: customer, merchant: middle_merchant)
    invoice3 = create(:invoice, customer: customer, merchant: bottom_merchant)
    invoice4 = create(:invoice, customer: customer, merchant: unimportant_merchant)
    create(:transaction, invoice: invoice1)
    create(:transaction, invoice: invoice2)
    create(:transaction, invoice: invoice3)
    create(:transaction, invoice: invoice4)
    create(:invoice_item, invoice: invoice1, item: item, quantity: 100)
    create(:invoice_item, invoice: invoice2, item: item2, quantity: 50)
    create(:invoice_item, invoice: invoice3, item: item3, quantity: 30)
    create(:invoice_item, invoice: invoice4, item: item4, quantity: 2)
  end

  it "should return merchant with most items" do
    get '/api/v1/merchants/most_items?quantity=3'

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
    expect(merchants[0]['id']).to eq(1)
    expect(merchants[0]['name']).to eq('Favorito Lamora')
    expect(merchants[1]['id']).to eq(2)
    expect(merchants[1]['name']).to eq('Adequito Masquera')
    expect(merchants[2]['id']).to eq(3)
    expect(merchants[2]['name']).to eq('Horriblea Formalsin')
    merchants.each do |merchant|
      expect(merchant['id']).to_not eq(4)
      expect(merchant['id']).to_not eq('The Unnamed One')
    end
  end
end
