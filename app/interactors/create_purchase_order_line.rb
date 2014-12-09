require 'creator'

class CreatePurchaseOrderLine
  include Interactor::Creator

  def call
    if context.purchase_order_line.save
      context.message = 'Purchase order line successfully created'
    else
      context.fail!(:message => 'Purchase order line not created')
    end
  end

  def create
    context.purchase_order_line.line_number = get_next_line_number
  end

  def get_next_line_number
    (PurchaseOrder::Line.maximum('line_number') || 0) + 1
  end

  def klazz
    PurchaseOrder::Line
  end
end
