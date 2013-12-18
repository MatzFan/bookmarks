require 'spec_helper'

describe Link do
  context 'Demo of how DataMapper works' do
    it 'should be created and then retrieved from the db' do
      expect(Link.count).to eq(0)
      Link.create(title: "Maker's Academy", url: "http://makersacademy.com/")
      expect(Link.count).to eq(1)
      link = Link.first
      expect(link.url).to eq("http://makersacademy.com/")
      expect(link.title).to eq("Maker's Academy")
      link.destroy
      expect(Link.count).to eq(0)
    end

  end # of context
end # of describe

