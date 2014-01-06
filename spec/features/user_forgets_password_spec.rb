require 'spec_helper'
require_relative 'helpers/user'

include UserHelpers

feature 'User forgets password' do

  before(:each) do
    Sinatra::Application.any_instance.stub(:send_simple_message) # stops mailgun emails!
  end

  scenario 'Forgotten password button redirects to ' do
    visit('/sessions/new')
    click_button 'Forgot password'
    expect(page.current_path).to eq('/users/forgotten_password')
  end

  scenario 'entering an invalid email address displays an appropriate message' do
    visit('/users/forgotten_password')
    fill_in :email, with: 'notindatabase@test.com'
    click_button :Submit
    expect(page).to have_content('Not a valid email address')
  end

  scenario 'entering a valid email address displays a message confirming an email has been sent' do
    setup_user
    visit('/users/forgotten_password')
    fill_in :email, with: 'test@test.com'
    click_button :Submit
    expect(page).to have_content('message sent')
  end

  scenario 'entering a valid email address sets the password_token field for the user ' do
    user = setup_user
    expect(user.password_token).to be_nil
    visit('/users/forgotten_password')
    fill_in :email, with: 'test@test.com'
    click_button :Submit
    expect(user.reload.password_token).not_to be_nil
  end

  scenario 'valid user clicking on tokenised link should be redirected to password_reset' do
    user = setup_user
    token = '1234abcd'
    user.password_token = token
    user.password_token_timestamp = Time.now
    user.save
    visit("users/reset_password/#{token}")
    expect(User.first(password_token: token)).to eq(user)
    expect(page.current_path).to eq('/sessions/new')
  end

  scenario 'user clicking on an out of date tokenised link should be found in the database' do
    user = setup_user
    token = '1234abcd'
    user.password_token_timestamp = Time.now - 3601 # just over an hour
    visit("users/reset_password/#{token}")
    expect(User.first(password_token: '1234abcd')).to be_nil
  end

end # of feature