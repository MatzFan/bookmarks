MAILGUN_API_KEY, MAILGUN_DOMAIN = ENV['MAILGUN_API_KEY'], ENV['MAILGUN_BOOKMARKS']
require 'rest_client'

get '/users/new' do
  @user = User.new # will be nil if user not sucessfully created
  erb :'users/new' # quotes to avoid interpreter trying to divide!
end

post '/users' do
  # may be in invalid state
  @user = User.create(email: params[:email],
              password: params[:password],
              password_confirmation: params[:password_confirmation])
  if @user.save # will be false if save fails - i.e. new users wasn't created (is nil?)
    session[:user_id] = @user.id # sets a session cookie for the user
    redirect to('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :'users/new' #redirect to same route
  end
end

get '/users/forgotten_password' do
  erb :'users/forgotten_password'
end

post '/users/forgotten_password' do
  user = User.first(email: params[:email])
  if user
    @token = Array.new(64) {(65 + rand(58)).chr}.join
    user.password_token = @token
    user.password_token_timestamp = Time.now
    a = user.save
    puts "Saved: #{a}"
    send_simple_message(user)
    flash.now[:notice] = 'message sent'
  else
    flash.now[:notice] = 'Not a valid email address'
  end
  erb :'users/forgotten_password'
end

get '/users/reset_password/:token' do
  user = User.first(password_token: params[:token])
  if user
    erb :'users/password_reset'
  end
end

def send_simple_message(user)
  RestClient.post "https://api:#{MAILGUN_API_KEY}"\
  "@api.mailgun.net/v2/#{MAILGUN_DOMAIN}/messages",
                  :from => "Password reset <noreply@#{MAILGUN_DOMAIN}>",
                  :to => "#{user.email}",
                  :subject => 'Hello',
                  :text => "Follow this link to reset your password:\n #{user.password_token}"
end
