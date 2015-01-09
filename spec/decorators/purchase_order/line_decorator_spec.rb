require 'rails_helper'

RSpec.describe PurchaseOrder::LineDecorator, :type => :decorator do
  let(:product) { build(:product) }
  let(:unit_of_measure) { build(:unit_of_measure) }
  let(:purchase_order_line) do
    build(
      :purchase_order_line,
      :product => product,
      :unit_of_measure => unit_of_measure)
  end
  subject(:decorator) { purchase_order_line.decorate }

  its(:product_display_string) do
    is_expected.to eq(product.decorate.display_string)
  end
  its(:unit_of_measure_display_string) do
    is_expected.to eq(unit_of_measure.decorate.display_string)
  end
end
