require 'rails_helper'

describe "Customer Search API" do
  before(:all) do
    create_list(:customer, 4)
  end
  it "returns single customer by first name" do
    get '/api/v1/customers/find?first_name=leif'

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer['id']).to eq(1)
    expect(customer['first_name']).to eq('Leif')
  end

  it "returns single customer by last name" do
    get '/api/v1/customers/find?last_name=erikson'

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer['id']).to eq(1)
    expect(customer['last_name']).to eq('Leif')
  end

  it "returns single customer by created at" do
    get '/api/v1/customers/find?created_at=2013-03-12T16:55:41'

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer['id']).to eq(1)
    expect(customer['created_at']).to eq('2013-03-12T16:55:41.000Z')
  end

  it "returns single customer by updated at" do
    get '/api/v1/customers/find?updated_at=2018-04-12T16:55:41'

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer['id']).to eq(1)
    expect(customer['updated_at']).to eq('2018-04-12T16:55:41.000Z')
  end
end
