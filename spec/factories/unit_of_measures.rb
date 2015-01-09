FactoryGirl.define do
  factory :unit_of_measure do
    name { Faker::Lorem.word }
    reference { Faker::Number.number(8) }
    conversion_to_pounds { Faker::Number.number(4) }
    source { :local }
    uuid { UUID.generate(:compact) }
  end
end
