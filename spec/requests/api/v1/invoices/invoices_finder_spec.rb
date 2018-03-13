require 'rails_helper'

describe "Invoices Finder API" do
  before(:each) do
    create(:customer, id: 3)
    create(:merchant, id: 3)
    create(:invoice,
           id: 11,
           status: "shipped",
           customer_id: 3,
           merchant_id: 3,
           created_at: DateTime.new(2018, 03, 12, 17, 10, 49),
           updated_at: DateTime.new(2018, 03, 13, 17, 10, 49))

    create(:invoice,
           id: 12,
           status: "pending",
           customer_id: 3,
           merchant_id: 3,
           created_at: DateTime.new(2018, 04, 12, 17, 10, 49),
           updated_at: DateTime.new(2018, 04, 13, 17, 10, 49))
  end

  it "can find one invoice by id" do

    get "/api/v1/invoices/find", params: {id: 11}

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(11)
  end

  it "can find one invoice by status" do
    get "/api/v1/invoices/find", params: {status: "pending"}

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(12)
  end

  it "can find one invoice by created_at" do
    get "/api/v1/invoices/find", params: {created_at: "2018-03-12T17:10:49+00:00"}

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(11)
  end

  it "can find one invoice by updated_at" do
    get "/api/v1/invoices/find", params: {updated_at: "2018-03-13T17:10:49+00:00"}

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(11)
  end
end
