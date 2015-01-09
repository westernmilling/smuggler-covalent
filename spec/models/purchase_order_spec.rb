require 'rails_helper'

RSpec.describe PurchaseOrder, :type => :model do
  subject { build(:purchase_order) }

  describe 'associations' do
    it { is_expected.to belong_to(:ship_to_entity) }
    it { is_expected.to have_many(:lines) }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:ship_to_entity) }
    it { is_expected.to validate_presence_of(:earliest_request_date) }
    it { is_expected.to validate_presence_of(:latest_request_date) }
  end

  describe '.valid?' do
    # it 'is invalid if there are no lines' do
    #   purchase_order = build(:purchase_order)
    #   expect(purchase_order.valid?).to be_falsey
    #   expect(purchase_order.errors[:lines]).to include(
    #     'must have at least one line')
    # end

    it 'is invalid if date is not a date' do
      purchase_order = build(:purchase_order, :date => 'abc')
      expect(purchase_order.valid?).to be_falsey
      expect(purchase_order.errors[:date]).to include('must be a valid date')
    end

    # rubocop:disable Metrics/LineLength
    it 'is invalid if the latest_request_date is before the earliest_request_date' do
      purchase_order = build(
        :purchase_order,
        :earliest_request_date => Time.now.to_date,
        :latest_request_date => Time.now.to_date - 1.week)
      expect(purchase_order.valid?).to be_falsey
      expect(purchase_order.errors[:latest_request_date]).to include(
        'must be after earliest request date')
    end
    # rubocop:enable Metrics/LineLength
  end
end
