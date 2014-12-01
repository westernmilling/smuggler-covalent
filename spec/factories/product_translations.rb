FactoryGirl.define do
  factory :product_translation do    
    product { build(:product) }
    sender_value { Faker::Number.number(12) }
    source_field 'Buyer Item Nbr'
    source_value { Faker::Number.number(11) }
  end
end