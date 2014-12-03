class UnitOfMeasureTranslationDecorator < Draper::Decorator
  delegate_all

  def unit_of_measure_display_string
    if unit_of_measure
      unit_of_measure.decorate.display_string
    end
  end

end
