require 'rails_helper'

describe "Merchant customers with pending invoice" do
  before(:each) do
    regular_customer = create(:customer)
    @pending_customer = create(:customer, first_name: "bob", last_name: "smith")
    paid_customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice,
                       customer: paid_customer,
                       merchant: merchant)
    invoice_2 = create(:invoice,
                       customer: @pending_customer,
                       merchant: merchant)
    invoice_3 = create(:invoice,
                       customer: @pending_customer,
                       merchant: merchant)
    invoice_4 = create(:invoice,
                       customer: regular_customer,
                       merchant: merchant)
    item = create(:item, merchant: merchant)
    create(:transaction, invoice: invoice_1)
    create(:transaction, invoice: invoice_2, result: "failed")
    create(:transaction, invoice: invoice_3, result: "success")
    create(:transaction, invoice: invoice_4, result: "success")
  end

  it "returns all customers with pending invoices for given merchant" do
    get "/api/v1/merchants/1/customers_with_pending_invoices"

    pending_customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(pending_customers.count).to eq(1)
    expect(pending_customers.first["id"]).to eq(@pending_customer.id)
  end
end
