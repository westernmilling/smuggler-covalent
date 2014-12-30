require 'rails_helper'

feature 'User visits import batch page' do
  background { sign_in_as(user) }

  given(:file) { build(:import_file) }
  given(:import_batch) { create(:import_batch, :upload => file) }
  given(:user) { create(:user, :confirmed) }

  scenario 'they see the import batch page' do
    visit import_batch_path(import_batch)

    expect(page).to have_content(/new/i)
    expect(page).to have_content(import_batch.upload_file_name)
  end
end
