require 'rails_helper'

describe "Merchant Most Items API" do
  before(:each) do
    top_merchant = create(:merchant, name: "Favorito Lamora")
    middle_merchant = create(:merchant, name: "Adequito Masquera")
    bottom_merchant = create(:merchant, name: "Horriblea Formalsin")
    unimportant_merchant = create(:merchant, name: "The Unnamed One")
    customer = (:customer)
    invoice1 = create(:invoice, customer: top_merchant, merchant: top_merchant)
    invoice2 = create(:invoice, customer: middle_merchant, merchant: middle_merchant)
    invoice3 = create(:invoice, customer: bottom_merchant, merchant: bottom_merchant)
    invoice4 = create(:invoice, customer: unimportant_merchant, merchant: unimportant_merchant)
    create(:invoice_item, invoice: invoice1, quantity: 100)
    create(:invoice_item, invoice: invoice2, quantity: 50)
    create(:invoice_item, invoice: invoice3, quantity: 30)
    create(:invoice_item, invoice: invoice4, quantity: 2)
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
    expect(merchants[3]['id']).to eq(3)
    expect(merchants[3]['name']).to eq('Horriblea Formalsin')
    merchants.each do |merchant|
      expect(merchant['id']).to_not eq(4)
      expect(merchant['id']).to_not eq('The Unnamed One')
    end
  end
end
