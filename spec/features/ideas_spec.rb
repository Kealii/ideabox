require 'rails_helper'

feature 'Ideas', js: true do
  it 'can be managed' do
    visit '/'

    fill_in 'Title', with: 'Idea #1'
    fill_in 'Body', with: 'This is such an awesome idea yo'
    click_on 'Save'

    within '.ideas' do
      expect(page).to have_content 'Idea #1'
      expect(page).to have_content 'This is such an awesome idea yo'
    end

    expect(page).to have_field 'Title', with: ''
    expect(page).to have_field 'Body', with: ''

    visit '/'

    within '.ideas' do
      expect(page).to have_content 'Idea #1'
      expect(page).to have_content 'This is such an awesome idea yo'
    end
  end
end