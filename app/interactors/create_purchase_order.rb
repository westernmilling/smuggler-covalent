require 'creator'

class CreatePurchaseOrder
  include Interactor::Creator

  def call
    if context.purchase_order.save
      context.message = 'Purchase order successfully created'
    else
      context.fail!(:message => 'Purchase order not created')
    end
  end

  def create
    model.status = :new    
  end

  def validate
    unless model.valid?
      context.fail!(:message => 'Invalid unit of measure details')
    end
  end

end
