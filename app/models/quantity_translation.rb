# Translate quantity values
class QuantityTranslation < ActiveRecord::Base
  include FieldTranslation

  validates_presence_of :expression

  def get_value(hash)
    Dentaku::Calculator.new.evaluate(
      expression,
      hash_values_to_f(expression_hash(hash)))
  end

  def expression_hash(hash)
    hash.slice(*symbols_in_expression)
  end

  def hash_values_to_f(hash)
    hash.inject({}) do |h, (k, v)|
      h[k] = v.to_f
      h
    end
  end

  def match?(*)
    true
  end

  def symbols_in_expression
    expression.scan(/\w+\b/).map { |x| x.to_sym }
  end
end
