require 'rails_helper'

describe "Merchant Find API" do
  before(:each) do
    @merchant = create(:merchant, name: 'Caumbehrbalding')
  end
  it "returns single merchant by params" do
    get '/api/v1/merchants/find?name=Caumbehrbalding'

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['name']).to eq('Caumbehrbalding')
    expect(merchant['id']).to eq('1')
  end
end
