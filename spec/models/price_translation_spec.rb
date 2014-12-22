require 'rails_helper'

RSpec.describe PriceTranslation, :type => :model do
  describe 'validations' do
    let(:expression) { nil }
    subject(:price_translation) do
      build(:price_translation, :expression => expression)
    end

    it { should validate_presence_of(:sender_value) }
    it { should validate_presence_of(:expression) }
  end

  describe '#translate' do
    before do
      create(
        :price_translation,
        :sender_value => sender_value,
        :expression => expression)
    end
    let(:expression) { nil }
    let(:hash) do
      {
        :sender => sender_value,
        :unit_price => '2',
        :quantity => '5'
      }
    end
    let(:sender_value) { Faker::Number.number(12) }
    subject(:translate) { PriceTranslation.translate(hash) }

    context 'valid expression' do
      let(:expression) { 'unit_price * quantity' }

      it 'translates the value correctly' do
        expect(translate).to eq(10)
      end
    end

    context 'invalid expression' do
      let(:expression) { 'unit_price *' }

      it 'raises a runtime error' do
        expect { translate }.to raise_exception(RuntimeError, /no rule matched/)
      end
    end
  end
end
