require 'rails_helper'

feature 'user creates new import batch' do
  background { sign_in_as(user) }

  given(:file) { build(:import_file) }
  given(:user) { create(:user, :confirmed) }

  scenario 'visit new page' do
    visit new_import_batch_path

    expect(page).to have_content(/import batch/i)
  end

  scenario 'save with valid details' do
    # sign_in

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

  # scenario 'user is not permitted' do
end
