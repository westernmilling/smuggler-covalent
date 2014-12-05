require 'rails_helper'

RSpec.describe 'routes for PurchaseOrder::Line', :type => :routing do
  let(:purchase_order) { create(:purchase_order) }
  let(:purchase_order_line) { create(:purchase_order_line) }

  it 'routes /purchase_order/{po id}/lines/new' do
  expect(:get => '/purchase_orders/1/lines/new').to route_to(
    :action => 'new',
    :controller => 'purchase_order/lines',
    :purchase_order_id => '1'
  )
  end

end

