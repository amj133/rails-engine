FactoryBot.define do
  factory :invoice do
    customer nil
    merchant nil
    status "shipped"
    created_at DateTime.new(2018, 03, 12, 17, 10, 49)
    updated_at DateTime.new(2018, 04, 12, 18, 11, 30)
  end
end
