class PurchaseOrdersController < ApplicationController
  respond_to(:csv, :html)

  before_filter :set_purchase_order, :only => [:show]

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
    @purchase_orders = PurchaseOrder.all.decorate
  end

  def new
    @purchase_order = PurchaseOrder.new.decorate
  end

  def show
    respond_to do |format|
      format.html
      format.csv {
        send_data(
          PurchaseOrder::CsvBuilder.new.add(@purchase_order).csv_lines.join("\n"),
          :type => 'text/csv; charset=utf-8; header=present',
          :filename => 'purchase_order.csv',
          :disposition => 'attachment')
      }
    end
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

  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end
end
