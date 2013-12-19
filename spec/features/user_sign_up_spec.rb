require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User signs up" do
  scenario "when being logged out" do
    lambda { sign_up }.should change(User, :count).by(1)
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq("alice@example.com")
  end

  scenario "with a password that doesn't match" do
    lambda { sign_up('a@a.com', 'pass', 'wrong') }.should change(User, :count).by(0)
    # ensure user is not redirected and an error message is displayed
    expect(current_path).to eq('/users') # current_path is Capy built in!
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario "with an email that is already registered" do
    lambda { sign_up }.should change(User, :count).by(1)
    lambda { sign_up }.should change(User, :count).by(0) # duplicate user email should not be added
    expect(page).to have_content("This email is already taken")
  end

end # of feature
