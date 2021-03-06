get '/sessions/new' do
  erb :"sessions/new", :layout => !request.xhr?
end

post '/sessions' do
  email, password = params[:email], params[:password]
  user  = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ["The email or password entered are incorrect"]
    erb :"sessions/new", :layout => !request.xhr?
  end
end

delete '/sessions' do
  session[:user_id] = nil
  flash[:notice] = "Good bye!"
  redirect to('/')
end
