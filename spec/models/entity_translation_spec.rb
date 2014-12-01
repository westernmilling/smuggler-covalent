require 'rails_helper'

RSpec.describe EntityTranslation, :type => :model do
  subject { build(:entity_translation) }

  it { should validate_presence_of(:entity) }
  it { should validate_presence_of(:sender_value) }
  it { should validate_presence_of(:source_field) }
  it { should validate_presence_of(:source_value) }
end
