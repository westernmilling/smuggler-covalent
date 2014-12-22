require 'rails_helper'

feature 'user creates new purchase order line' do
  background { sign_in_as(user) }

  given(:user) { create(:user, :confirmed) }
  given(:purchase_order) { create(:purchase_order) }
  given(:product) { create(:product) }
  given(:unit_of_measure) { create(:unit_of_measure) }

  scenario 'visit new page' do
    visit new_purchase_order_line_path(purchase_order)

    expect(page).to have_content(/new purchase order/i)
  end

  scenario 'with valid details' do
    visit new_purchase_order_line_path(purchase_order)

    find(:xpath, "//input[@id='purchase_order_line_product_id']").
      set(product.id)
    fill_in(
      'purchase_order_line_product_display_string',
      :with => product.name)
    find(:xpath, "//input[@id='purchase_order_line_unit_of_measure_id']").set unit_of_measure.id
    fill_in 'purchase_order_line_unit_of_measure_display_string', :with => unit_of_measure.name
    fill_in 'purchase_order_line_quantity', :with => 10
    fill_in 'purchase_order_line_unit_price', :with => 100

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'with invalid details' do
    visit new_purchase_order_line_path(purchase_order)

    click_button 'Save'

    expect(page).not_to have_content(/created/i)
  end
end
