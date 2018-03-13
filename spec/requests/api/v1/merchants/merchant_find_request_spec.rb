require 'rails_helper'

describe "Merchant Finder API" do
  before(:all) do
    @merchant = create(:merchant, name: 'Caumbehrbalding', created_at: DateTime.parse("2013-05-12 17:03:15"), updated_at: DateTime.parse("2013-05-23 17:03:15"))
    @merchant = create_list(:merchant, 3, name: 'Liversinklepim')
  end
  it "returns single merchant by name" do
    get '/api/v1/merchants/find?name=Caumbehrbalding'

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['name']).to eq('Caumbehrbalding')
    expect(merchant['id']).to eq(1)
  end

  it "returns single merchant by created at" do
    get '/api/v1/merchants/find?created_at="2013-05-12T17:03:15.000Z"'

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['id']).to eq(1)
  end

  it "returns single merchant by updated at" do
    get '/api/v1/merchants/find?updated_at="2013-05-23T17:03:15.000Z"'

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant['id']).to eq(1)
  end

  it 'returns all merchants by name' do
    get '/api/v1/merchants/find_all?name=liversinklepim'

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to be(3)
    merchants.each do |merchant|
      expect(merchant['name']).to eq('Liversinklepim')
    end
  end

  it 'returns all merchants by updated at' do
    get '/api/v1/merchants/find_all?updated_at=2018-03-12T17:03:15.000Z'

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to be(3)
  end

  it 'returns all merchants by created at' do
    get '/api/v1/merchants/find_all?created_at=2013-05-23T17:03:15.000Z'

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to be(3)
  end

  it 'returns a single merchant by id' do
    get '/api/v1/merchants/find?id=2'

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant['id']).to eq(2)
  end
end
