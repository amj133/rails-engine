require 'rails_helper'

describe "Invoice items relationship endpoints" do
  before(:all) do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create(:invoice_item, invoice: invoice, item: item)
  end

  it "should return associated invoice" do
    get "/api/v1/invoice_items/1/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice.class).to eq(Hash)
    expect(invoice["id"]).to eq(1)
  end
end
