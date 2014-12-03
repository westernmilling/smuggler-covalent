require 'rails_helper'

RSpec.describe UnitOfMeasureTranslationDecorator do
  let(:unit_of_measure) { build(:unit_of_measure) }
  let(:unit_of_measure_translation) { 
    build(:unit_of_measure_translation, :unit_of_measure => unit_of_measure) 
  }
  subject(:decorator) { unit_of_measure_translation.decorate }

  its(:unit_of_measure_display_string) { 
    is_expected.to eq(unit_of_measure.decorate.display_string) 
  }

end
