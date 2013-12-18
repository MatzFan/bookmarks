get '/users/new' do
  @user = User.new # will be nil if user not sucessfully created
  erb :"users/new" # quotes to avoid interpreter trying to divide!
end

post '/users' do
  # may be in invalid state
  @user = User.create(email: params[:email],
              password: params[:password],
              password_confirmation: params[:password_confirmation])
  if @user.save # will be false if save fails - i.e. new users was't crearted (is nil?)
    session[:user_id] = @user.id # sets a session cookie for the user
    redirect to('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :"users/new" #redirect to same route
  end
end

get '/users/forgotten_password' do
  erb :"users/forgotten_password"
end
