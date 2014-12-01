require 'rails_helper'

RSpec.describe CreateProduct, :type => :interactor do

  let(:name) { Faker::Commerce.product_name }
  let(:reference) { Faker::Number.number(8) }
  let(:source) { nil }
  let(:uuid) { nil }
  subject(:context) { 
    CreateProduct.call(
      :name => name, 
      :reference => reference, 
      :uuid => uuid) 
  }

  context 'valid parameters' do
    describe 'context' do
      its(:success?) { is_expected.to be_truthy }
      its(:message) { is_expected.to match(/success/i) }
      its(:success?) { is_expected.to be_truthy }
      its(:message) { is_expected.to match(/success/i) }
      its(:product) { is_expected.to be_present }
    end

    describe Product do
      subject(:product) { context.product }

      its(:persisted?) { is_expected.to be_truthy }
      its(:display_name) { is_expected.to eq(name) }
      its(:source) { is_expected.to eq(:local) }
      its(:errors) { is_expected.to be_empty }
    end
  end

  context 'invalid parameters' do
    let(:name) { nil }

    describe 'context' do
      it 'is failure' do
        expect(context).to be_a_failure
      end

      it 'message contains fail' do
        expect(context.message).to match(/invalid/i)
      end

      it 'has set the product' do
        expect(context.product).to be_present
      end
    end

    describe Product do
      subject(:product) { context.product }

      it 'has not been persisted' do
        expect(product).not_to be_persisted
      end
      its(:persisted?) { is_expected.to be_falsey }
      its(:errors) { is_expected.not_to be_empty }
    end
  end

end
