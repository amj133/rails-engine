FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number 231412341341341
    result "success"
    created_at "2018-03-12 17:21:52"
    updated_at "2018-03-12 17:21:52"
  end
end
