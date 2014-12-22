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

    context 'valid expression' do
      let(:expression) { 'quantity / dtl_user_defined_field3' }

      it 'translates the value correctly' do
        expect(translate).to eq(20)
      end
    end

    context 'invalid expression' do
      let(:expression) { 'quantity *' }

      it 'raises a runtime error' do
        expect { translate }.to raise_exception(RuntimeError, /no rule matched/)
      end
    end
  end
end
