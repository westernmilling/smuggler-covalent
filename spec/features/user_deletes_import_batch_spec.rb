require 'rails_helper'

feature 'User deletes import batch' do
  background { sign_in_as(user) }

  given(:file) { build(:import_file) }
  given(:user) { create(:user, :confirmed) }
  
  scenario 'batch is deleted' do
    visit entities_path

    # TODO: Click the first delete button

    # TODO: Check for a delete confirmation flash

    # TODO: Check that the batch has been deleted
    # Exists with .with_deleted and has deleted_at
    # Does not exist in a normal query
  end
end
