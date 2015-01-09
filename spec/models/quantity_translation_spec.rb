require 'rails_helper'

RSpec.describe QuantityTranslation, :type => :model do
  describe 'validations' do
    let(:expression) { nil }
    subject(:quantity_translation) do
      build(:quantity_translation, :expression => expression)
    end

    it { should validate_presence_of(:sender_value) }
    it { should validate_presence_of(:expression) }
  end

  describe '#translate' do
    before do
      create(
        :quantity_translation,
        :sender_value => sender_value,
        :expression => expression)
    end
    let(:expression) { nil }
    let(:hash) do
      {
        :sender => sender_value,
        :quantity => '100',
        :dtl_user_defined_field3 => '5'
      }
    end
    let(:sender_value) { Faker::Number.number(12) }
    subject(:translate) { QuantityTranslation.translate(hash) }

    context 'when expression is valid' do
      let(:expression) { 'quantity / dtl_user_defined_field3' }

      its(:success) { is_expected.to be_truthy }
      its(:value) { is_expected.to eq(20) }
    end

    context 'when expression is invalid' do
      let(:expression) { 'quantity *' }

      it 'raises a runtime error' do
        expect { translate }.to raise_exception(RuntimeError, /no rule matched/)
      end
    end

    context 'when there are no translations' do
      let(:expression) { 'quantity / dtl_user_defined_field3' }
      let(:hash) do
        {
          :po_number => Faker::Number.number(10),
          :line_nbr => 1,
          :sender => Faker::Number.number(12)
        }
      end

      its(:success) { is_expected.to be_falsey }
      its(:message) do
        is_expected.to(
          eq(I18n.t('default.error',
                    :name => 'quantity',
                    :purchase_order_number => hash[:po_number],
                    :line_number => hash[:line_nbr],
                    :scope => :field_translation))
        )
      end
    end
  end
end
