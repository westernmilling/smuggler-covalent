class PurchaseOrdersController < ApplicationController
  respond_to(:html)

  def create
    context = CreatePurchaseOrder.call(
      purchase_order_params.merge(:created_by => current_user))

    if context.success?
      notice_redirect(context.purchase_order, 
        context.message, 
        [context.purchase_order])
    else
      respond_with(@purchase_order = context.purchase_order.decorate)
    end
  end

  def index
  end

  def new
    @purchase_order = PurchaseOrder.new.decorate
  end

  protected

  def purchase_order_params
    params.
      require(:purchase_order).
      permit(
        :ship_to_entity_id, 
        :date, 
        :number, 
        :earliest_request_date, 
        :latest_request_date)
  rescue ActionController::ParameterMissing
    {}
  end
end
