require 'rails_helper'

feature 'User visits new import batch page' do
  background { sign_in_as(user) }

  given(:file) { build(:import_file) }
  given(:user) { create(:user, :confirmed) }

  scenario 'they see the new import batch page' do
    visit new_import_batch_path

    expect(page).to have_content(/import batch/i)
  end
end
