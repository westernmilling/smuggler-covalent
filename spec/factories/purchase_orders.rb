FactoryGirl.define do
  factory :purchase_order do
    association :ship_to_entity, :factory => :entity
    date { Time.now.to_date }
    number { Faker::Number.number(10) }
    earliest_request_date Time.now.to_date
    latest_request_date Time.now.to_date + 1.week
    status :new
  end
end
