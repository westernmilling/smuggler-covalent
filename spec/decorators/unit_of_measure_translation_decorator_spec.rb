require 'rails_helper'

RSpec.describe UnitOfMeasureTranslationDecorator do
  let(:unit_of_measure) { build(:unit_of_measure) }
  let(:unit_of_measure_translation) do
    build(:unit_of_measure_translation, :unit_of_measure => unit_of_measure)
  end
  subject(:decorator) { unit_of_measure_translation.decorate }

  its(:unit_of_measure_display_string) do 
    is_expected.to eq(unit_of_measure.decorate.display_string)
  end
end
