require 'spec_helper'

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
    expect(page).to have_content("Sorry, your passwords don't match")
  end

  def sign_up(email = "alice@example.com", password = "oranges!", password_confirmation = "oranges!")
    visit '/users/new'
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button "Sign up"
  end

end # of feature
