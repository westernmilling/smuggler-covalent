require 'rails_helper'

RSpec.describe Import::Batch::Line, :type => :model do
  describe 'associations' do
    subject { build(:import_batch_line) }

    it { is_expected.to belong_to(:batch) }
    it { is_expected.to have_many(:values) }
  end

  describe 'paranoid' do
    subject { build(:import_batch_line) }

    it { is_expected.to act_as_paranoid }
  end

  describe 'validations' do
    subject { build(:import_batch_line) }

    it { is_expected.to validate_presence_of(:batch) }
    it { is_expected.to validate_presence_of(:purchase_order_number) }
    it { is_expected.to validate_presence_of(:sender) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe '.value_hash' do
    let(:line) do
      line = build(:import_batch_line)
      line.values << build(
        :import_batch_line_field_value,
        :name => 'sender',
        :value => Faker::Number.number(12))
      line
    end
    subject { line.value_hash }

    describe 'first value' do
      it 'exists in hash' do
        expect(subject[:sender]).to be_present
      end
    end
  end
end
