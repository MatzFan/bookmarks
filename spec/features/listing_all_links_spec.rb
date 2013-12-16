require 'spec_helper'

feature "User browses the list of links" do

  before(:each) {
    Link.create(url: "http://makersacaemy.com", title: "Maker's Academy")
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Maker's Academy")
  end

end # of feature
