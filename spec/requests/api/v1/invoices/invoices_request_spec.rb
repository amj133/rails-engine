require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    create(:customer)
    create(:merchant)
    create_list(:invoice, 3, customer_id: 1, merchant_id: 1)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
    expect(invoices.first["id"]).to eq(1)
    expect(invoices.last["id"]).to eq(3)
  end

  it "can get one invoice by its id" do
    create(:customer, id: 2)
    create(:merchant, id: 2)
    id = create(:invoice, customer_id: 2, merchant_id: 2).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(id)
    expect(invoice["status"]).to eq("shipped")
  end
end
