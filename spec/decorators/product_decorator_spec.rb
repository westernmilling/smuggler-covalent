require 'rails_helper'

RSpec.describe ProductDecorator, :type => :decorator do
  let(:product) { build(:product) }
  subject { product.decorate }

  its(:display_string) do
    is_expected.to eq("#{product.reference} - #{product.name}")
  end
end
