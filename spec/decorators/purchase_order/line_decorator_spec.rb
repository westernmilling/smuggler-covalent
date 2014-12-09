require 'rails_helper'

RSpec.describe PurchaseOrder::LineDecorator, :type => :decorator do
  let(:product) { build(:product) }
  let(:unit_of_measure) { build(:unit_of_measure) }
  let(:purchase_order_line) { 
    build(:purchase_order_line, 
      :product => product,
      :unit_of_measure => unit_of_measure) }
  subject(:decorator) { purchase_order_line.decorate }

  its(:product_display_string) { should eq(product.decorate.display_string) }
  its(:unit_of_measure_display_string) { should eq(unit_of_measure.decorate.display_string) }

end
