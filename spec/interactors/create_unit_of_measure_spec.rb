require 'rails_helper'

RSpec.describe CreateUnitOfMeasure, :type => :interactor do
  let(:name) { Faker::Lorem.word }
  let(:reference) { Faker::Number.number(8) }
  let(:source) { nil }
  let(:uuid) { nil }
  subject(:context) do
    CreateUnitOfMeasure.call(
      :conversion_to_pounds => 1000,
      :name => name,
      :reference => reference,
      :uuid => uuid)
  end

  context 'valid parameters' do
    describe 'context' do
      its(:success?) { is_expected.to be_truthy }
      its(:message) { is_expected.to match(/success/i) }
      its(:unit_of_measure) { is_expected.to be_present }
    end

    describe UnitOfMeasure do
      subject(:unit_of_measure) { context.unit_of_measure }

      its(:persisted?) { is_expected.to be_truthy }
      its(:source) { is_expected.to eq(:local) }
      its(:errors) { is_expected.to be_empty }
    end
  end

  context 'invalid parameters' do
    let(:name) { nil }

    describe 'context' do
      its(:failure?) { is_expected.to be_truthy }
      its(:message) { is_expected.to match(/invalid/i) }
      its(:unit_of_measure) { is_expected.to be_present }
    end

    describe UnitOfMeasure do
      subject(:unit_of_measure) { context.unit_of_measure }

      its(:persisted?) { is_expected.to be_falsey }
      its(:errors) { is_expected.not_to be_empty }
    end
  end
end
