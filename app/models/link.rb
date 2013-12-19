require 'dm-constraints'

class Link

  include DataMapper::Resource

  property :id, Serial, key: true # Serial auto-increments
  property :title, String
  property :url, String

  has n, :tags, through: Resource, constraint: :protect

end # of class
