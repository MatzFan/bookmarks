require 'bcrypt'

class User

  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :email, String, :unique => true, :message => "This email is already taken"
  property :password_digest, Text # holds password & salt - text as string is 50 chars

  validates_confirmation_of :password # built in method of DataMapper to validate 'anything' with 'anything_confirmation'

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user # return user object from the db
    else
      nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end # of class
