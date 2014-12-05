require 'rails_helper'

feature 'user creates new purchase order line' do
  background { sign_in_as(user) }

  given(:user) { create(:user, :confirmed) }
  given(:purchase_order) { create(:purchase_order) }

  scenario 'visit new page' do
    visit new_purchase_order_line_path(purchase_order)

    expect(page).to have_content(/new purchase order/i)
  end

  scenario 'with valid details' do
    visit new_purchase_order_line_path(purchase_order)

    
    # find(:xpath, "//input[@id='purchase_order_ship_to_entity_id']").set entity.id
    # fill_in 'purchase_order_ship_to_entity_display_string', :with => entity.name
    # fill_in 'purchase_order_date', :with => purchase_order_date
    # fill_in 'purchase_order_number', :with => purchase_order_number
    # fill_in 'purchase_order_earliest_request_date', :with => earliested_request_date
    # fill_in 'purchase_order_latest_request_date', :with => latest_request_date

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'with invalid details' do
    visit new_purchase_order_line_path(purchase_order)

    click_button 'Save'

    expect(page).not_to have_content(/created/i)
  end

end
