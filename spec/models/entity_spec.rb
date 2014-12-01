require 'rails_helper'

RSpec.describe Entity, :type => :model do
  subject { build(:entity) }

  it { should validate_presence_of(:display_name) }
  it { should validate_presence_of(:cached_full_name) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:reference) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:region) }
  it { should validate_presence_of(:region_code) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:roles) }
  it { should validate_presence_of(:uuid) }
  it { should validate_presence_of(:source) }

end
