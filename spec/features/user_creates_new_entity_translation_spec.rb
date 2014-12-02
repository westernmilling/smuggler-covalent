require 'rails_helper'

feature 'user creates new entity translation' do
  background { sign_in_as(user) }

  given(:user) { create(:user, :confirmed) }

  scenario 'visit new page' do
    visit new_entity_translation_path

    # TODO: Add some expectations here
  end

  # TODO: Add a javascript driver so we can test the Entity typeahead

  scenario 'saves with valid details' do
    visit new_entity_translation_path

    name = Faker::Company.name
    entity = create(:entity)

    find(:xpath, "//input[@id='entity_translation_entity_id']").set entity.id
    fill_in 'entity_translation_entity_string', :with => entity.cached_full_name
    fill_in 'entity_translation_sender_value', :with => Faker::Number.number(12)
    fill_in 'entity_translation_source_field', :with => 'Ship-To Location'
    fill_in 'entity_translation_source_value', :with => Faker::Number.number(11)

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'saves with invalid details' do
    visit new_entity_translation_path

    click_button 'Save'

    expect(page).not_to have_content(/created/i)
  end

  # scenario 'user is not permitted' do
  
end