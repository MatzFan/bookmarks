require 'spec_helper'

feature "User adds a new link" do
  scenario "when browing the hoempage" do
    expect(Link.count).to eq(0)
    visit ('/')
    add_link("http://www.makersacademy.com", "Maker's Academy")
    expect(Link.count). to eq(1)
    link = Link.first
    expect(link.url).to eq("http://www.makersacademy.com")
    expect(link.title).to eq("Maker's Academy")
  end

  def add_link(url, title)
    within('#new-link') do # element id name 'new-link'
      fill_in 'url', with: url
      fill_in 'title', with: title
      click_button 'Add link'
    end
  end

end # of feature
