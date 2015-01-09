require 'rails_helper'

RSpec.describe UnitOfMeasureDecorator, :type => :decorator do
  let(:unit_of_measure) { build(:unit_of_measure) }
  subject { unit_of_measure.decorate }

  its(:display_string) do
    is_expected.to eq("#{unit_of_measure.reference} - #{unit_of_measure.name}")
  end
end
