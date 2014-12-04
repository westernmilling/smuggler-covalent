require 'rails_helper'

RSpec.describe ProductTranslation, :type => :model do
  subject { build(:product_translation) }

  it { should validate_presence_of(:product) }
  it { should validate_presence_of(:sender_value) }
  it { should validate_presence_of(:source_field) }
  it { should validate_presence_of(:source_value) }

end
