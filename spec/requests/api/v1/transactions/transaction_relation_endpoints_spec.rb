require 'rails_helper'

describe "Relationship endpoints for transactions" do
  before(:all) do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, invoice: invoice)
  end

  it "returns the invoice for a given transaction" do
    get "/api/v1/transactions/1/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice.class).to eq(Hash)
    expect(invoice["id"]).to eq(1)
  end
end
