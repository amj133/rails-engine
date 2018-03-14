require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  describe "Relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe "Class methods" do
    it "#formatted_price returns price as float" do
      merchant = create(:merchant)
      item = create(:item,
                    unit_price: 2345,
                    merchant: merchant)

      expect(item.formatted_price).to eq(23.45)
    end
  end
end
