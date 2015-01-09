FactoryGirl.define do
  factory :price_translation do
    sender_value { Faker::Number.number(12) }
    expression 'unit_price'
  end
end
