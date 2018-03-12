require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:status)}
    it {should validate_presence_of(:created_at)}
    it {should validate_presence_of(:updated_at)}
  end

  describe "Relationships" do
    it {should belong_to(:merchant)}
    it {should belong_to(:customer)}
  end
end
