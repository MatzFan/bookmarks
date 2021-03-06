require 'spec_helper'

feature 'User adds a new link' do
  scenario "from the homepage using an ajax form", :js => true do
    visit '/'
    click_link "New link"
    add_link("http://www.example.com/", "Example")
    expect(page).to have_content('Example')
    expect(current_path).to eq('/') # we're still on the frontpage
  end

  scenario 'without tags', :js => true do
    expect(Link.count).to eq(0)
    visit ('/')
    click_link 'New link' # needed to render the Ajax form
    add_link('http://www.makersacademy.com', "Maker's Academy")
    expect(Link.count). to eq(1)
    link = Link.first
    expect(link.url).to eq('http://www.makersacademy.com')
    expect(link.title).to eq("Maker's Academy")
  end

  scenario 'with a few tags' do
    visit '/'
    click_link 'New link' # needed to render the Ajax form
    add_link('http://makersacademy.com', "Maker's Academy", ['education', 'ruby'])
    link = Link.first
    expect(link.tags.map(&:text)).to include('education')
    expect(link.tags.map(&:text)).to include('ruby')
  end

  def add_link(url, title, tags = []) # optimal tags parameter
    fill_in 'url', with: url
    fill_in 'title', with: title
    # tags will be space-separated
    fill_in 'tags', with: tags.join(' ')
    click_button 'Add link'
  end

end # of feature
