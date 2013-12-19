require 'dm-constraints'

class Tag

  include DataMapper::Resource

  property :text, String, key: true

  has n, :links, through: Resource, constraint: :protect

end
