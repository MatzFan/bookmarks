get '/users/new' do
  @user = User.new # will be nil if user not sucessfully created
  erb :'users/new', :layout => !request.xhr? # quotes to avoid interpreter trying to divide!
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
    erb :'users/new', :layout => !request.xhr? #redirect to same route
  end
end

get '/users/forgotten_password' do
  erb :'users/forgotten_password', :layout => !request.xhr?
end

post '/users/forgotten_password' do
  user = User.first(email: params[:email])
  if user
    @token = Array.new(64) {(65 + rand(25)).chr}.join
    user.password_token = @token
    user.password_token_timestamp = Time.now
    user.save
    user.send_password_reset_message # Mailgun
    flash.now[:notice] = 'message sent'
  else
    flash.now[:notice] = 'Not a valid email address'
  end
  erb :'users/forgotten_password', :layout => !request.xhr?
end

get '/users/reset_password/:token' do
  user = User.first(password_token: params[:token])
  redirect '/sessions/new' if user
end
