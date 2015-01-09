require 'rails_helper'

feature 'user creates new entity' do
  background { sign_in_as(user) }

  given(:user) { create(:user, :confirmed) }

  scenario 'with valid details' do
    visit new_entity_path

    name = Faker::Company.name

    fill_in 'entity_display_name', :with => name
    fill_in 'entity_name', :with => name
    fill_in 'entity_reference', :with => Faker::Number.number(8)
    fill_in 'entity_street_address', :with => Faker::Address.street_address
    fill_in 'entity_city', :with => Faker::Address.street_address
    fill_in 'entity_region', :with => Faker::Address.state
    fill_in 'entity_region_code', :with => Faker::Address.zip_code
    fill_in 'entity_country', :with => 'United States'
    fill_in 'entity_roles', :with => 'customer'

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'with invalid details' do
    visit new_entity_path

    click_button 'Save'

    expect(page).not_to have_content(/created/i)
  end
end
