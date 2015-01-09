require 'rails_helper'

RSpec.describe PurchaseOrderDecorator, :type => :decorator do
  let(:entity) { build(:entity) }
  let(:purchase_order) { build(:purchase_order, :ship_to_entity => entity) }
  subject(:decorator) { purchase_order.decorate }

  its(:ship_to_entity_display_string) do
    is_expected.to eq(entity.decorate.display_string)
  end
end
