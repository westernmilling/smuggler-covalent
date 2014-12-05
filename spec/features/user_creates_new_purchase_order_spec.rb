require 'rails_helper'

feature 'user creates new purchase order' do
  background { sign_in_as(user) }

  given(:user) { create(:user, :confirmed) }

  scenario 'visit new page' do
    visit new_purchase_order_path

    expect(page).to have_content(/new purchase order/i)
  end

  scenario 'with valid details' do
    visit new_purchase_order_path

    entity = create(:entity)
    purchase_order_date = Time.now.to_date
    purchase_order_number = Faker::Number.number(10)
    earliested_request_date = Time.now.to_date
    latest_request_date = Time.now.to_date + 1.week


    find(:xpath, "//input[@id='purchase_order_ship_to_entity_id']").set entity.id
    fill_in 'purchase_order_ship_to_entity_display_string', :with => entity.name
    fill_in 'purchase_order_date', :with => purchase_order_date
    fill_in 'purchase_order_number', :with => purchase_order_number
    fill_in 'purchase_order_earliest_request_date', :with => earliested_request_date
    fill_in 'purchase_order_latest_request_date', :with => latest_request_date

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'with invalid details' do
    visit new_purchase_order_path

    click_button 'Save'

    expect(page).not_to have_content(/created/i)
  end

end
