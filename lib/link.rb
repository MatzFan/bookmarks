class Link

  include DataMapper::Resource

  property :id, Serial # Serial auto-increments
  property :title, String
  property :url, String


end # of class
