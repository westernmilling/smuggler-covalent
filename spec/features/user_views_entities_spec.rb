require 'rails_helper'

feature 'user views entities' do
  scenario 'there are no entities' do
    visit entities_path

    expect(page).to have_content(/no entities/i)
  end

  scenario 'there are entities' do
    create(:entity)

    visit entities_path

    expect(page).not_to have_content(/no entities/i)
  end
  
end
