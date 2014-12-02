require 'rails_helper'

feature 'user creates new product' do
  background { sign_in_as(user) }

  given(:user) { create(:user, :confirmed) }

  scenario 'with valid details' do
    visit new_product_path

    name = Faker::Company.name

    fill_in 'product_display_name', :with => name
    fill_in 'product_name', :with => name
    fill_in 'product_reference', :with => Faker::Number.number(8)

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'with invalid details' do
    visit new_product_path

    click_button 'Save'

    expect(page).not_to have_content(/created/i)
  end
  
end