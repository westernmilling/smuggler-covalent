require 'rails_helper'

feature 'user creates new unit of measure translation' do
  background { sign_in_as(user) }

  given(:user) { create(:user, :confirmed) }

  scenario 'visit new page' do
    visit new_unit_of_measure_translation_path

    expect(page).to have_content(/unit of measure translation/i)
  end

  scenario 'saves with valid details' do
    visit new_unit_of_measure_translation_path

    unit_of_measure = create(:unit_of_measure)

    find(
      :xpath,
      "//input[@id='unit_of_measure_translation_unit_of_measure_id']"
    ).set unit_of_measure.id
    fill_in 'unit_of_measure_translation_unit_of_measure_display_string',
            :with => unit_of_measure.name
    fill_in 'unit_of_measure_translation_sender_value',
            :with => Faker::Number.number(12)
    fill_in 'unit_of_measure_translation_source_field',
            :with => 'UOM  Basis of UOM'
    fill_in 'unit_of_measure_translation_source_value', :with => 'EA'

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'saves with invalid details' do
    visit new_unit_of_measure_translation_path

    click_button 'Save'

    expect(page).not_to have_content(/created/i)
  end

  # scenario 'user is not permitted' do

end
