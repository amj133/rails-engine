FactoryBot.define do
  factory :customer do
    first_name "Leif"
    last_name "Erikson"
    created_at DateTime.parse("2013-03-12 16:55:41")
    updated_at DateTime.parse("2018-04-12 16:55:41")
  end
end
