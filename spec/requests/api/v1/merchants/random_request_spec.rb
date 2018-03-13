require 'rails_helper'

describe "Merchants Random API" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
  end
  it "should return random merchant" do
    get '/api/v1/merchants/random'

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant['id']).to_not be(nil)
  end
end
