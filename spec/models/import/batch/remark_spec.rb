require 'rails_helper'

RSpec.describe Import::Batch::Remark, :type => :model do
  subject { build(:import_batch_remark) }

  describe 'associations' do
    it { is_expected.to belong_to(:batch) }
    it { is_expected.to belong_to(:line) }
  end

  describe 'paranoid' do
    it { is_expected.to act_as_paranoid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:batch) }
    it { is_expected.to validate_presence_of(:line) }
    it { is_expected.to validate_presence_of(:remark_message) }
    it { is_expected.to validate_presence_of(:remark_type) }
    it { is_expected.to validate_inclusion_of(:remark_type).in_array([:error]) }
  end
end
