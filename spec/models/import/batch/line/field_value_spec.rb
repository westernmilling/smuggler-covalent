require 'rails_helper'

RSpec.describe Import::Batch::Line::FieldValue, :type => :model do
  subject { build(:import_batch_line_field_value) }

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
    it { is_expected.to validate_presence_of(:name) }
  end
end
