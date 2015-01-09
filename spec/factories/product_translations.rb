FactoryGirl.define do
  factory :product_translation do
    product { build(:product) }
    sender_value { Faker::Number.number(12) }
    source_field 'buyer_item_nbr'
    source_value { Faker::Number.number(9) }
  end
end
