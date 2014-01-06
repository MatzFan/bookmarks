require 'dm-constraints'
require 'bcrypt'
require 'rest_client'

class User

  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  MAILGUN_API_KEY, MAILGUN_DOMAIN = ENV['MAILGUN_API_KEY'], ENV['MAILGUN_BOOKMARKS']#'key-9-beatnxb3hehaihwauvqj54p0yb70e2', 'app20456058.mailgun.org'

  property :id, Serial, key: true
  property :email, String, :unique => true, :message => 'This email is already taken'
  property :password_digest, Text # holds password & salt - text as string is 50 chars
  property :password_token, Text
  property :password_token_timestamp, DateTime

  validates_confirmation_of :password # built in method of DataMapper to validate 'anything' with 'anything_confirmation'

  def self.authenticate(email, password)
    user = first(email: email)
    user if user && BCrypt::Password.new(user.password_digest) == password
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def send_password_reset_message
   RestClient.post "https://api:#{MAILGUN_API_KEY}"\
   "@api.mailgun.net/v2/#{MAILGUN_DOMAIN}/messages",
                    :from => "Password reset <noreply@#{MAILGUN_DOMAIN}>",
                    :to => "#{self.email}",
                    :subject => 'Hello',
                    :text => "Follow this link to reset your password:\n localhost:4567/users/reset_password/#{self.password_token}"
  end

end # of class

