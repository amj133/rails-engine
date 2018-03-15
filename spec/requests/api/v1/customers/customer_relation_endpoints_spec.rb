require 'rails_helper'

describe "Relationship endpoints for customers" do
  before(:all) do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    create_list(:transaction, 2, invoice: invoice_1)
  end

  it "returns a collection of invoices for given customer" do
    get "/api/v1/customers/1/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(2)
    expect(invoices.first["id"]).to eq(1)
    expect(invoices.last["id"]).to eq(2)
  end

  it "returns a collection of transactions for given customer" do
    get "/api/v1/customers/1/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(2)
    expect(transactions.first["id"]).to eq(1)
    expect(transactions.last["id"]).to eq(2)
  end
end
