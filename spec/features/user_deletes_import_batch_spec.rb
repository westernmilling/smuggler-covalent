require 'rails_helper'

feature 'User deletes import batch' do
  background { sign_in_as(user) }

  given(:file) { build(:import_file) }
  given(:import_batch) { create(:import_batch, :upload => file) }
  given(:user) { create(:user, :confirmed) }
  
  scenario 'batch is deleted' do
    visit import_batch_path(import_batch)

    click_link 'Delete'

    import_batch.reload

    expect(import_batch.deleted_at).to be_present
    expect(page).to have_content(/was successfully deleted/i)
  end
end
