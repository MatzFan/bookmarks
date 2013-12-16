require 'bcrypt'

class User

  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :email, String
  property :password_digest, Text # holds password & salt - text as string is 50 chars

  validates_confirmation_of :password # built in method of DataMapper to validate 'anything' with 'anything_confirmation'

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end # of class

