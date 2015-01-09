require 'rails_helper'

RSpec.describe Product, :type => :model do
  subject { build(:product) }

  it { should validate_presence_of(:display_name) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:reference) }
  it { should validate_presence_of(:uuid) }
  it { should validate_presence_of(:source) }
end
