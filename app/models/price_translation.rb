class PriceTranslation < ActiveRecord::Base
  validates_presence_of :expression
  validates_presence_of :sender_value

  def translate(hash)
    @translated_value = Dentaku::Calculator.new.evaluate(expression, hash)

    self
  end

  def translated_value
    @translated_value
  end

end
