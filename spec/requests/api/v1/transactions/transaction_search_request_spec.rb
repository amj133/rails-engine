require 'rails_helper'

describe "Transaction Search Api" do
  before(:all) do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create(:transaction, invoice: invoice)
  end

  it "returns a single transaction by credit card number" do
    get '/api/v1/transactions/:id/find?credit_card_number=231412341341341'

    expect(response).to be_success

    transaction = JSON.parse(request.body)

    expect(transaction['id']).to eq(1)
    expect(transaction['credit_card_number']).to eq(231412341341341)
  end

  it "returns a single transaction by created at" do
    get '/api/v1/transactions/:id/find?created_at="2015-03-12T17:03:15.000Z"'

    expect(response).to be_success

    transaction = JSON.parse(request.body)

    expect(transaction['id']).to eq(1)
    expect(transaction['credit_card_number']).to eq(231412341341341)
  end

  it "returns a single transaction by updated at" do
    get '/api/v1/transactions/:id/find?updated_at="2018-05-12T17:03:15.000Z"'

    expect(response).to be_success

    transaction = JSON.parse(request.body)

    expect(transaction['id']).to eq(1)
    expect(transaction['credit_card_number']).to eq(231412341341341)
  end
end
