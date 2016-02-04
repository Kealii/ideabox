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
      expect(page).to have_content 'Swill'
    end

    expect(page).to have_field 'Title', with: ''
    expect(page).to have_field 'Body', with: ''

    visit '/'

    within '.ideas' do
      expect(page).to have_content 'Idea #1'
      expect(page).to have_content 'This is such an awesome idea yo'
    end

    within 'li', text: 'Idea #1' do
      click_on 'Edit'
      fill_in 'Title', with: 'Edited Idea'
      fill_in 'Body', with: 'Even more awesome Idea'
      click_on 'Save'
    end

    within '.ideas' do
      expect(page).to_not have_content 'Idea #1'
      expect(page).to_not have_content 'This is such an awesome idea yo'
      expect(page).to have_content 'Edited Idea'
      expect(page).to have_content 'Even more awesome Idea'
    end

    visit '/'

    within '.ideas' do
      expect(page).to_not have_content 'Idea #1'
      expect(page).to_not have_content 'This is such an awesome idea yo'
      expect(page).to have_content 'Edited Idea'
      expect(page).to have_content 'Even more awesome Idea'
    end

    within 'li', text: 'Edited Idea' do
      click_on 'Delete'
    end

    expect(page).to_not have_content 'Edited Idea'
    expect(page).to_not have_content 'Even more awesome Idea'

    visit '/'

    expect(page).to_not have_content 'Edited Idea'
    expect(page).to_not have_content 'Even more awesome Idea'
  end

  it 'has ratings that can be managed' do
    visit '/'
    fill_in 'Title', with: 'Idea #1'
    fill_in 'Body', with: 'This is such an awesome idea yo'
    click_on 'Save'

    expect(page).to have_content 'Swill'

    click_on '+'

    expect(page).to_not have_content 'Swill'
    expect(page).to have_content 'Plausible'

    click_on '+'

    expect(page).to_not have_content 'Plausible'
    expect(page).to have_content 'Genius'

    click_on '+'

    expect(page).to have_content 'Genius'

    click_on '-'

    expect(page).to_not have_content 'Genius'
    expect(page).to have_content 'Plausible'

    click_on '-'

    expect(page).to_not have_content 'Plausible'
    expect(page).to have_content 'Swill'

    click_on '-'

    expect(page).to have_content 'Swill'
  end

  it 'can be searched' do
    visit '/'
    fill_in 'Title', with: 'Idea #1'
    fill_in 'Body', with: 'This is such an awesome idea yo'
    click_on 'Save'
    fill_in 'Title', with: 'Idea #2'
    fill_in 'Body', with: 'Sketchy plans'
    click_on 'Save'

    fill_in 'Search', with: 'Idea'

    expect(page).to have_content 'Idea #1'
    expect(page).to have_content 'Idea #2'

    fill_in 'Search', with: 'Sketchy'

    expect(page).to_not have_content 'Idea #1'
    expect(page).to have_content 'Idea #2'
  end
end