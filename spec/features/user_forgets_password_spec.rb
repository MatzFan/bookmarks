require 'spec_helper'

feature 'User forgets password' do
  scenario 'Forgotten password button redirects to ' do
    visit('/sessions/new')
    click_button 'Forgot password'
    expect(page.current_path).to eq('/users/forgotten_password')
  end

  scenario 'Submit button on /forgotten_password page records user email address' do
    visit('/users/forgotten_password')
    fill_in :email, with: 'test@test.com'
    expect(page.current_path).to eq('/users/forgotten_password')
  end

end # of feature
