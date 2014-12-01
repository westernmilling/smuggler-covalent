class ProductTypeaheadController < ApplicationController
  respond_to(:json)

  def index
    respond_with(products)
  end

  def products
    query = "%#{params[:q]}%"

    Product.where { (name =~ query) | (reference =~ query) }
  end  
end
