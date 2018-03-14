require 'rails_helper'

describe "Favorite customer for given merchant API Finder" do
  it "returns customer with most successful transactions" do
    @favorite_customer = create(:customer)
    regular_customer = create(:customer)
    @merchant = create(:merchant)
    invoice_1 = create(:invoice,
                       customer: @favorite_customer,
                       merchant: @merchant)
    invoice_2 = create(:invoice,
                       customer: regular_customer,
                       merchant: @merchant)
    invoice_3 = create(:invoice,
                       customer: @favorite_customer,
                       merchant: @merchant)
    create(:transaction, invoice: invoice_1)
    create(:transaction, invoice: invoice_2)
    create(:transaction, invoice: invoice_3)
    create(:transaction, invoice: invoice_3, result: "failed")

    get "/api/v1/merchants/1/favorite_customer"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer.class).to eq(Hash)
    expect(customer["id"]).to eq(1)
    expect(customer["name"]).to eq(nil)
  end
end
