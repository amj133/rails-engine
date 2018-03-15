require 'rails_helper'

describe "Invoice Relationships" do
  before(:all) do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create_list(:invoice_item, 5, invoice: invoice, item: item)
  end
  it "Should return items merchant" do
    get '/api/v1/items/1/merchant'

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant['id']).to eq(1)
    expect(merchant['name']).to eq('Melagum McNahony the Wise Sitter')
  end

  it "Should return invoice_items" do
    get '/api/v1/items/1/invoice_items'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    invoice_items.each do |ii|
      expect(ii['item_id']).to eq(1)
    end
  end
end
