require 'rails_helper'

describe "Invoices Finder API" do
  before(:each) do
    create(:customer, id: 3)
    create(:customer, id: 4)
    create(:merchant, id: 5)
    create(:merchant, id: 6)
    create(:invoice,
           id: 11,
           status: "shipped",
           customer_id: 3,
           merchant_id: 5,
           created_at: DateTime.new(2018, 03, 12, 17, 10, 49),
           updated_at: DateTime.new(2018, 03, 13, 17, 10, 49))

    create(:invoice,
           id: 12,
           status: "pending",
           customer_id: 4,
           merchant_id: 6,
           created_at: DateTime.new(2018, 04, 12, 17, 10, 49),
           updated_at: DateTime.new(2018, 04, 13, 17, 10, 49))
  end

  it "can find one invoice by id" do
    get "/api/v1/invoices/find?id=11"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(11)
  end

  it "can find one invoice by customer id" do
    get "/api/v1/invoices/find?customer_id=3"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(11)
  end

  it "can find one invoice by merchant id" do
    get "/api/v1/invoices/find?merchant_id=5"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(11)
  end

  it "can find one invoice by status" do
    get "/api/v1/invoices/find?status=pending"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(12)
  end

  it "can find one invoice by created_at" do
    get "/api/v1/invoices/find?created_at=2018-03-12T17:10:49.000Z"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(11)
  end

  it "can find one invoice by updated_at" do
    get "/api/v1/invoices/find?updated_at=2018-03-13T17:10:49.000Z"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(11)
  end

  describe "can find random" do
    it "returns random invoice" do
      get "/api/v1/invoices/random"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice.class).to be(Hash)
      expect(invoice["id"].class).to be(Integer)
    end
  end

  describe "can find by multiple attributes" do
    it "can find by customer id and status" do
      get "/api/v1/invoices/find_all", params: {customer_id: 4, status: "pending"}

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice.first["id"]).to eq(12)
    end

    it "can find by merchant id and created at" do
      get "/api/v1/invoices/find_all", params: {merchant_id: 5, created_at: "2018-03-12T17:10:49.000Z"}

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice.first["id"]).to eq(11)
    end

    it "can find by merchant id and created at" do
      get "/api/v1/invoices/find_all", params: {merchant_id: 5, created_at: "2018-03-12T17:10:49.000Z"}

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice.first["id"]).to eq(11)
    end

    it "can find by created at and updated at" do
      get "/api/v1/invoices/find_all", params: {created_at: "2018-03-12T17:10:49.000Z",
                                                updated_at: "2018-03-13T17:10:49.000Z"}

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice.first["id"]).to eq(11)
    end
  end
end
