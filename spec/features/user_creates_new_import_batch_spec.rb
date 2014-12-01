require 'rails_helper'

feature 'user creates new import batch' do
  scenario 'visit new page' do
    visit new_import_batch_path

    expect(page).to have_content(/import batch/i)
  end

  given(:file) { build(:import_file) }
  given(:user) { create(:user, :confirmed) }

  scenario 'save with valid details' do
    sign_in

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

  def sign_in
      login_as(user, :scope => :user)
    end
end
