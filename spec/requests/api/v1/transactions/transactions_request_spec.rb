require 'rails_helper'

describe 'transactions API' do
  before(:each) do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create_list(:transaction, 3, invoice: invoice)
  end

  it "returns a list of all transactions" do
    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions.count).to eq(3)
    transactions.each do |transaction|
      expect(transaction['credit_card_number']).to eq(231412341341341)
      expect(transaction['result']).to eq("success")
    end
  end

  it "returns one transaction by id" do
    get '/api/v1/transactions/4'

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction['id']).to eq(4)
  end
end
