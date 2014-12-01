require 'rails_helper'

RSpec.describe ProductTranslationDecorator do
  let(:product) { build(:product) }
  let(:product_translation) { build(:product_translation, :product => product) }
  subject(:decorator) { product_translation.decorate }

  its(:product_display_string) { should eq(product.decorate.display_string) }

end
