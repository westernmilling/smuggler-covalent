require 'creator'

class CreatePurchaseOrderLine
  include Interactor::Creator

  def call
    # TODO

  end

  def clazz
    PurchaseOrder::Line
  end

  def create_with_params
    context.to_h.except(:user)
  end
end
