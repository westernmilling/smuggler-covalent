require 'rails_helper'

RSpec.describe UnitOfMeasure, :type => :model do
  subject { build(:unit_of_measure) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:reference) }
  it { should validate_presence_of(:uuid) }
  it { should validate_presence_of(:source) }

end
