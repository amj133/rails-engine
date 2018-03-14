require 'rails_helper'

describe "Transaction Search Api" do
  before(:all) do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create_list(:transaction, 3, invoice: invoice)
  end

  it "returns a single transaction by credit card number" do
    get '/api/v1/transactions/find?credit_card_number=231412341341341'

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction['id']).to eq(1)
    expect(transaction['credit_card_number']).to eq(231412341341341)
  end

  it "returns a single transaction by created at" do
    get '/api/v1/transactions/find?created_at="2015-03-12T17:21:52.000Z"'

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction['id']).to eq(1)
    expect(transaction['credit_card_number']).to eq(231412341341341)
  end

  it "returns a single transaction by updated at" do
    get '/api/v1/transactions/find?updated_at="2018-03-12T17:21:52.000Z"'

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction['id']).to eq(1)
    expect(transaction['credit_card_number']).to eq(231412341341341)
  end

  it "returns all transactions by credit card number" do
    get '/api/v1/transactions/find_all?credit_card_number=231412341341341'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
    transactions.each do |transaction|
      expect(transaction['credit_card_number']).to eq(231412341341341)
    end
  end

  it "returns all transactions by created at" do
    get '/api/v1/transactions/find_all?created_at="2015-03-12T17:21:52.000Z"'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
    transactions.each do |transaction|
      expect(transaction['created_at']).to eq('2015-03-12T17:21:52.000Z')
    end
  end

  it "returns all transactions by updated at" do
    get '/api/v1/transactions/find_all?updated_at="2018-03-12T17:21:52.000Z"'

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
    transactions.each do |transaction|
      expect(transaction['updated_at']).to eq('2018-03-12T17:21:52.000Z')
    end
  end
end