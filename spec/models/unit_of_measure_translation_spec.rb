require 'rails_helper'

RSpec.describe UnitOfMeasureTranslation, :type => :model do
  subject { build(:unit_of_measure_translation) }

  it { should validate_presence_of(:unit_of_measure) }
  it { should validate_presence_of(:sender_value) }
  it { should validate_presence_of(:source_field) }
  it { should validate_presence_of(:source_value) }
end
