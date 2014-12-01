require 'rails_helper'

RSpec.describe ProductDecorator, :type => :decorator do
  let(:product) { build(:product) }
  subject { product.decorate }

  its(:display_string) { should eq("#{product.reference} - #{product.name}") }
end
