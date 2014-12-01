class ProductsController < ApplicationController
  respond_to(:html)

  def create
    context = CreateProduct.call(product_params)

    if context.success?
      notice_redirect(context.product, context.message, [context.product])
    else
      respond_with(@product = context.product)
    end 
  end

  def index
    # TODO: Implement Ransack search
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  protected

  def product_params
    params.
      require(:product).
      permit(
        :name, 
        :display_name, 
        :reference)
  end
end
