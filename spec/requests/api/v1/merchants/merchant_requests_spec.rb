require 'rails_helper'

describe 'Merchants API' do
  before(:each) do
    merchants = create_list(:merchant, 3)
  end

  it "returns a list of all merchants" do
    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
    merchants.each do |merchant|
      expect(merchant['name']).to eq("Melagum McNahony the Wise Sitter")
    end 
  end

  it "returns one merchant by id" do
    get '/api/v1/merchants/4'

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant['id']).to eq(4)
  end
end
