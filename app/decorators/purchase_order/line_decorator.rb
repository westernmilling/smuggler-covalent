class PurchaseOrder::LineDecorator < Draper::Decorator
  delegate_all

  def product_display_string
    if product
      product.decorate.display_string
    end
  end

  def unit_of_measure_display_string
    if unit_of_measure
      unit_of_measure.decorate.display_string
    end
  end

end
