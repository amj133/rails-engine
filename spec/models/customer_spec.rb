require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  describe "Relationships" do
    it {should have_many(:invoices)}
  end

  describe "Instance Methods" do
    before(:each) do
      @favorite_merchant = create(:merchant)
      regular_merchant = create(:merchant)
      @customer = create(:customer)
      invoice = create(:invoice, merchant: @favorite_merchant, customer: @customer)
      second_invoice = create(:invoice, merchant: regular_merchant, customer: @customer)
      create_list(:transaction, 5, invoice: invoice)
      create(:transaction, invoice: second_invoice)
    end
    describe "#favorite_merchant" do
      it "should return favorite merchant" do
        expect(@customer.favorite_merchant).to eq(@favorite_merchant)
      end
    end
  end
end
