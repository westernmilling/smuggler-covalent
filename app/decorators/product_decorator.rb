class ProductDecorator < Draper::Decorator
  delegate_all

  def display_string
    "#{reference} - #{name}"
  end
end
