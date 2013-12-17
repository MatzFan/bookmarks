class Link

  include DataMapper::Resource

  has n, :tags, through: Resource

  property :id, Serial # Serial auto-increments
  property :title, String
  property :url, String

end # of class
