FactoryGirl.define do
  factory :unit_of_measure_translation do    
    unit_of_measure { build(:unit_of_measure) }
    sender_value { Faker::Number.number(12) }
    source_field 'Buyer Item Nbr'
    source_value { Faker::Number.number(9) }
  end
end