require 'rails_helper'

feature 'user creates new unit of measure' do
  background { sign_in_as(user) }

  given(:user) { create(:user, :confirmed) }

  scenario 'with valid details' do
    visit new_unit_of_measure_path

    name = Faker::Company.name

    fill_in 'unit_of_measure_name', :with => name
    fill_in 'unit_of_measure_reference', :with => Faker::Number.number(8)
    fill_in 'unit_of_measure_conversion_to_pounds', :with => 2000

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'with invalid details' do
    visit new_unit_of_measure_path

    click_button 'Save'

    expect(page).not_to have_content(/created/i)
  end
end
