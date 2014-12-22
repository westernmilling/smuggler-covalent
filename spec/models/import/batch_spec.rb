require 'rails_helper'

RSpec.describe Import::Batch, :type => :model do
  subject { build(:import_batch) }

  describe 'associations' do
    it { is_expected.to have_many(:lines) }
  end

  describe 'paranoid' do
    it { is_expected.to act_as_paranoid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:upload) }
  end
  
end
