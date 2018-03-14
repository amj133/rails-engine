require 'rails_helper'

describe 'Customers API' do
  before(:each) do
    customers = create_list(:customer, 3)
  end

  it "returns a list of all customers" do
    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body)
    expect(customers.count).to eq(3)
    customers.each do |customer|
      expect(customer['first_name']).to eq("Leif")
      expect(customer['last_name']).to eq("Erikson")
    end
  end

  it "returns one customer by id" do
    get '/api/v1/customers/4'

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer['id']).to eq(4)
  end
end
