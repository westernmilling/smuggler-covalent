require 'rails_helper'

feature 'user creates new quantity translation' do
  background { sign_in_as(user) }

  given(:user) { create(:user, :confirmed) }
  
  scenario 'visit new page' do
    visit new_quantity_translation_path

    expect(page).to have_content(/new price translation/i)
  end

  # TODO: Add a javascript driver so we can test the Entity typeahead

  scenario 'saves with valid details' do
    visit new_quantity_translation_path

    fill_in 'quantity_translation_sender_value', :with => Faker::Number.number(12)
    fill_in 'quantity_translation_expression', :with => 'uom_basis_of_uom / dtl_user_defined_field3'

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'saves with invalid details' do
    visit new_quantity_translation_path

    click_button 'Save'

    expect(page).not_to have_content(/created/i)
  end

  # scenario 'user is not permitted' do
  
end