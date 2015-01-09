FactoryGirl.define do
  factory :import_batch, :class => Import::Batch do
    status :new
  end
end
