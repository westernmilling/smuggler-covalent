FactoryGirl.define do
  factory :product do
    display_name { name }
    name { Faker::Commerce.product_name }
    reference { Faker::Number.number(8) }
    source { :local }
    uuid { UUID.generate(:compact) }
  end
end
