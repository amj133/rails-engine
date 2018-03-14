require 'rails_helper'

describe "Transactions Random Api" do
  before(:each) do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    create_list(:transaction, 5, invoice: invoice)
  end
  it 'should return random transaction' do
    get '/api/v1/transactions/random'

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction['id']).to_not be(nil)
  end
end
