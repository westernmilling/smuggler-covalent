class ProductTranslationDecorator < Draper::Decorator
  delegate_all

  def product_display_string
    if product
      product.decorate.display_string
    end
  end

end
