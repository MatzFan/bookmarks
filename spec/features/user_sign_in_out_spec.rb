require_relative 'helpers/session'
require_relative 'helpers/user'

include UserHelpers
include SessionHelpers

feature 'User signs in' do

  before(:each) do
    setup_user
  end

  scenario 'with correct credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, test@test.com')
    sign_in('test@test.com', 'test')
    expect(page).to have_content('Welcome, test@test.com')
  end

  scenario 'with incorrect credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, test@test.com')
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end

feature 'User signs out' do

  before(:each) do
    setup_user
  end

  scenario 'while signed in' do
    sign_in('test@test.com', 'test')
    click_button 'Sign out'
    expect(page).to have_content('Good bye!')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end # of feature
