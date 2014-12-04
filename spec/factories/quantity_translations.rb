FactoryGirl.define do
  factory :quantity_translation do    
    sender_value { Faker::Number.number(12) }
    expression 'quantity'
  end
end
