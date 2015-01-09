require 'rails_helper'

RSpec.describe PurchaseOrder::Line, :type => :model do
  describe 'associations' do
    subject { build(:purchase_order_line) }

    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:purchase_order) }
    it { is_expected.to belong_to(:unit_of_measure) }
  end

  describe 'validations' do
    subject { build(:purchase_order_line) }

    it { is_expected.to validate_presence_of(:line_number) }
    it { is_expected.to validate_presence_of(:product) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:unit_of_measure) }
    it { is_expected.to validate_presence_of(:unit_price) }
  end
end
