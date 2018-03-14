require 'rails_helper'

describe "Cusotomer Random API" do
  before(:each) do
    create_list(:customer, 5)
  end
  it "it returns random customer" do
    get '/api/v1/customers/random'

    expect(response).to be_success

    transaction = JSON.parse(response.body)

    expect(transaction['id']).to_not be(nil)
  end
end
