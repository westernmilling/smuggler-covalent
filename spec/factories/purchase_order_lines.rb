FactoryGirl.define do
  factory :purchase_order_line, :class => PurchaseOrder::Line do    
    purchase_order
    product
    quantity 10
    unit_of_measure
    unit_price 100    
  end
end