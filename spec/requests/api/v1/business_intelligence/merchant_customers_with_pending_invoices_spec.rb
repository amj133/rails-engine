require 'rails_helper'

describe "Merchant customers with pending invoice" do
  before(:each) do
    create_list(:customer, 2)
    @pending_customer = create(:customer)
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
    item = create(:item, merchant: merchant)
    create(:transaction, invoice: invoice_1)
    create(:transaction, invoice: invoice_2, result: "failed")
  end

  it "returns all customers with pending invoices for given merchant" do
    get "/api/v1/merchants/1/customers_with_pending_invoices"

    pending_customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(pending_customers.count).to eq(1)
    expect(pending_customers.first["id"]).to eq(@pending_customer.id)
  end
end
