require 'rails_helper'

describe "Relationship endpoints for customers" do
  before(:all) do
    customer = create(:customer)
    merchant = create(:merchant)
    create_list(:invoice, 2, customer: customer, merchant: merchant)
  end

  it "returns a collection of invoices for given customer" do
    get "/api/v1/customers/1/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(2)
    expect(invoices.first["id"]).to eq(1)
    expect(invoices.last["id"]).to eq(2)
  end
end
