require 'creator'

# Create a new +PurchaseOrder+
class CreatePurchaseOrder
  include Interactor::Creator

  def call
    model.whodunnit(context.user) { model.save! }

    context.message = 'Purchase order successfully created'
    # if context.purchase_order.save
    # else
    #   context.fail!(:message => 'Purchase order not created')
    # end
  end

  def after_build
    model.status = :new
  end

  def build_params
    base_params.except(:user)
  end
end
