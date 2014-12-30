require 'rails_helper'

feature 'User creates new import batch' do
  background { sign_in_as(user) }

  given(:file) { build(:import_file) }
  given(:user) { create(:user, :confirmed) }

  scenario 'save with valid details' do
    visit new_import_batch_path

    attach_file('import_batch_input_upload_file', file.path)

    click_button 'Save'

    expect(page).to have_content(/created/i)
  end

  scenario 'save with invalid details' do
    visit new_import_batch_path

    click_button 'Save'

    expect(page).to have_content(/error/i)
  end
end
