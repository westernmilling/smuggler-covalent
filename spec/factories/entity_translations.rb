FactoryGirl.define do
  factory :entity_translation do    
    entity { build(:entity) }
    sender_value { Faker::Number.number(12) }
    source_field 'Ship-To Location'
    source_value { Faker::Number.number(11) }
  end
end