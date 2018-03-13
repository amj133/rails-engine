require 'rails_helper'

describe "Invoices Finder API" do
  it "can find one invoice by id" do
    create(:customer, id: 3)
    create(:merchant, id: 3)
    create(:invoice, id: 11, status: "shipped", customer_id: 3, merchant_id: 3)
    create(:invoice, id: 12, status: "pending", customer_id: 3, merchant_id: 3)

    get "/api/v1/invoices/find", params: {id: 11}

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(11)
  end

  it "can find one invoice by status" do
    create(:customer, id: 3)
    create(:merchant, id: 3)
    create(:invoice, id: 11, status: "shipped", customer_id: 3, merchant_id: 3)
    create(:invoice, id: 12, status: "pending", customer_id: 3, merchant_id: 3)

    get "/api/v1/invoices/find", params: {status: "pending"}

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(12)
  end
end
