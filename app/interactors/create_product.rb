# An interactor for creating new Product instances.
#
# Creates a new Product ensuring system validity.
#
# REVIEW: Consider "Extract Class/Superclass" the create_* and validate methods
# Whats the best ractoring to avoid inheritance :)
class CreateProduct
  include Interactor

  before :create
  before :validate

  # Creates a new Product.
  def call
    if context.product.save
      context.message = 'Product successfully created'
    else
      fail!(:message => 'Product not created')
    end
  end

  # Create a new product in context using the parameters passed into the
  # interactors call method.
  #
  # We'll set some defaults here for missing values.
  # def create_product
  def create
    context.product = Product.new(context.to_h)
    context.product.uuid = UUID.generate(:compact)
    context.product.display_name ||= context.product.name
    context.product.source ||= :local
  end

  # Prevalidate the new Product before attempting to persist.
  def validate
    unless context.product.valid?
      context.fail!(:message => 'Invalid Product details')
    end
  end
end
