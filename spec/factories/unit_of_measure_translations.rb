FactoryGirl.define do
  factory :unit_of_measure_translation do
    unit_of_measure { build(:unit_of_measure) }
    sender_value { Faker::Number.number(12) }
    source_field 'uom_basis_of_uom'
    source_value { 'EA' }
  end
end
