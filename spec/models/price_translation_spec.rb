require 'rails_helper'

RSpec.describe PriceTranslation, :type => :model do
  let(:expression) { nil }
  subject(:price_translation) { build(:price_translation, :expression => expression) }

  it { should validate_presence_of(:sender_value) }
  it { should validate_presence_of(:expression) }

  describe '.translate' do    
    subject(:translate) { price_translation.translate(hash) }
    let(:hash) {  
      { :unit_price => 2, :other_value => 5 }
    }

    context 'valid expression' do
      let(:expression) { 'unit_price * other_value' }

      it 'translates the value correctly' do
        expect(translate.translated_value).to eq(10)
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
