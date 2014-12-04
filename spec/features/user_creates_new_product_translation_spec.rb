require 'rails_helper'

feature 'user creates new product translation' do
  background { sign_in_as(user) }

  given(:user) { create(:user, :confirmed) }
  
  scenario 'visit new page' do
    visit new_product_translation_path

    expect(page).to have_content(/new product translation/i)
  end

  # TODO: Add a javascript driver so we can test the Entity typeahead

  scenario 'saves with valid details' do
    visit new_product_translation_path

    name = Faker::Company.name
    product = create(:product)

    find(:xpath, "//input[@id='product_translation_product_id']").set product.id
    fill_in 'product_translation_product_display_string', :with => product.name
    fill_in 'product_translation_sender_value', :with => Faker::Number.number(12)
    fill_in 'product_translation_source_field', :with => 'Buyer Item Nbr'
    fill_in 'product_translation_source_value', :with => Faker::Number.number(11)

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'saves with invalid details' do
    visit new_product_translation_path

    click_button 'Save'

    expect(page).not_to have_content(/created/i)
  end

  # scenario 'user is not permitted' do
  
end