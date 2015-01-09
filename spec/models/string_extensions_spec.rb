require 'rails_helper'
require 'string_extensions'

RSpec.describe StringExtensions, :type => :model do
  using StringExtensions

  let(:string) {}

  describe '.brute_underscore' do
    subject { string.brute_underscore }

    context "UOM\tBasis of UOM" do
      let(:string) { "UOM\tBasis of UOM" }

      it 'is equal to uom_basis_of_uom' do
        expect(subject).to eq('uom_basis_of_uom')
      end
    end
  end
end
