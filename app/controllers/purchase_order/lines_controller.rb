class PurchaseOrder::LinesController < ApplicationController
  respond_to(:html)

  before_filter :set_purchase_order

  def create
    context = CreatePurchaseOrderLine.call(
      line_params.merge(:user => current_user))

    if context.success?
      notice_redirect(context.purchase_order_line, 
        context.message, 
        [context.purchase_order_line])
    else
      respond_with(@purchase_order_line = context.purchase_order_line.decorate)
    end
  end

  def index
  end

  def new
    @purchase_order_line = PurchaseOrder::Line.new(
      :purchase_order => @purchase_order).decorate
  end

  protected

  def line_params
    params.
      require(:purchase_order_line).
      permit(
        :purchase_order_id, 
        :product_id,
        :quantity, 
        :unit_of_measure_id,
        :unit_price)
  rescue ActionController::ParameterMissing
    {}
  end

  def set_purchase_order
    @purchase_order = PurchaseOrder::find(params[:purchase_order_id])
  end
end
