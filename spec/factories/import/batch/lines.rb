FactoryGirl.define do
  factory :import_batch_line, :class => Import::Batch::Line do
    status :new
  end
end
