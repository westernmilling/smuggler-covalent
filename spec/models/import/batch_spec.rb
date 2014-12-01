require 'rails_helper'

RSpec.describe Import::Batch, :type => :model do
  subject { build(:import_batch) }

  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:upload) }
  
end
