require 'rails_helper'

describe "Invoice Relationship Endpoint Specs" do
  before(:all) do
    merchant = create(:merchant)
    customer = create(:customer)
    items = create_list(:item, 2, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice2 = create(:invoice, merchant: merchant, customer: customer)
    create_list(:invoice_item, 1, invoice: invoice, item: items[0])
    create_list(:invoice_item, 1, invoice: invoice, item: items[1])
    create_list(:transaction, 4, invoice: invoice)
    create_list(:transaction, 4, invoice: invoice2)
  end
  it "should return related merchant" do
    get '/api/v1/invoices/1/merchant'

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant['id']).to eq(1)
    expect(merchant['name']).to eq("Melagum McNahony the Wise Sitter")
  end

  it "should return related customer" do
    get '/api/v1/invoices/1/customer'

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer['id']).to eq(1)
    expect(customer['first_name']).to eq("Leif")
    expect(customer['last_name']).to eq("Erikson")
  end

  it "should return related items" do
    get '/api/v1/invoices/1/items'

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(2)
    expect(items[0]['id']).to eq(1)
    expect(items[0]['name']).to eq('MyString')
    expect(items[0]['merchant_id']).to eq(1)
    expect(items[1]['id']).to eq(2)
    expect(items[1]['name']).to eq('MyString')
    expect(items[1]['merchant_id']).to eq(1)
  end

  it "should return related invoice items" do
    get '/api/v1/invoices/1/invoice_items'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(2)
    invoice_items.each do |invoice_item|
      expect(invoice_item['item_id']).to_not eq(nil)
      expect(invoice_item['quantity']).to eq(1)
      expect(invoice_item['unit_price']).to eq(1)
    end
    expect(invoice_items[0]['id']).to eq(1)
    expect(invoice_items[0]['unit_price']).to eq(1)
    expect(invoice_items[1]['id']).to eq(2)
    expect(invoice_items[1]['unit_price']).to eq(1)
  end

  it "should return related transactions" do
    get '/api/v1/invoices/1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(4)
    transactions.each do |transaction|
      expect(transaction['invoice_id']).to eq(1)
      expect(transaction['result']).to eq('success')
      expect(transaction['credit_card_number']).to eq('231412341341341')
    end
  end
end
