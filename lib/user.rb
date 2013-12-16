require 'bcrypt'

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String
  # holds password & salt - text as string is 50 chars
  property :password_digest, Text

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

end # of class

