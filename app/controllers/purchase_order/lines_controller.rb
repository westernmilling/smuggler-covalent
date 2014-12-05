class PurchaseOrder::LinesController < ApplicationController
  respond_to(:html)

  before_filter :set_purchase_order, :only => [:create, :new]

  def create
    context = nil
    PurchaseOrder::Line.transaction do
      context = CreatePurchaseOrderLine.call(
        line_params.merge(:created_by => current_user))
    end

    if context.success?
      puts 'success and redirect'
      notice_redirect(context.purchase_order_line, 
        context.message, 
        [context.purchase_order_line])
    else
      @purchase_order_line = context.purchase_order_line.decorate

      render :new
      # REVIEW: For some reason respond_with was causing a redirect
      # respond_with(@purchase_order_line = context.purchase_order_line.decorate)
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
