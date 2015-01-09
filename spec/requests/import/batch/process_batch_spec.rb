require 'rails_helper'

RSpec.describe 'Process batch', :type => :request do
  before do
    create(
      :price_translation,
      :sender_value => entity_translation.sender_value,
      :expression => 'unit_price * quantity')
    create(
      :quantity_translation,
      :sender_value => entity_translation.sender_value,
      :expression => 'quantity / dtl_user_defined_field3')

    sign_in_as(user)
  end

  let(:batch) do
    temp_batch = build(:import_batch)
    temp_batch.upload = import_file
    with_versioning { temp_batch.save! }
    temp_batch
  end
  let(:entity) { create(:entity) }
  let(:entity_translation) do
    create(
      :entity_translation,
      :entity => entity)
  end
  let(:import_data) do
    [
      {
        :number => Faker::Number.number(10),
        :lines => [
          {
            :buyer_item_number => product_translation_1.source_value,
            :uom_basis_of_uom => unit_of_measure_translation.source_value
          }
        ],
        :sender => entity_translation.sender_value,
        :ship_to_location => entity_translation.source_value
      }
    ]
  end
  let(:import_lines) { create_import_file_lines(import_data) }
  let(:import_file) { create_import_file(import_lines) }
  let(:product_1) { create(:product) }
  let(:product_translation_1) do
    create(
      :product_translation,
      :product => product_1,
      :sender_value => entity_translation.sender_value)
  end
  let(:price_translation) do
    create(
      :price_translation,
      :sender_value => entity_translation.sender_value,
      :expression => 'unit_price * quantity')
  end
  let(:quantity_translation) do
    create(
      :quantity_translation,
      :sender_value => entity_translation.sender_value,
      :expression => 'quantity / dtl_user_defined_field3')
  end
  let(:unit_of_measure) { create(:unit_of_measure) }
  let(:unit_of_measure_translation) do
    create(
      :unit_of_measure_translation,
      :unit_of_measure => unit_of_measure,
      :sender_value => entity_translation.sender_value)
  end
  let(:user) { create(:user, :confirmed) }

  it 'processes the batch' do
    put process_import_batch_path(batch)

    expect(response).to redirect_to(import_batch_path(batch))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to match(/batch proccessed successfully/i)

    batch.reload

    expect(batch.status).to eq(:complete)
  end
end
