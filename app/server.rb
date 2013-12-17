#!/usr/bin/env ruby

require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require './lib/link' # must be done after DataMapper is initialized
require './lib/tag' # ditto
require './lib/user' # ditto
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions # Sinatra
set :session_secret, 'my unique encryption key!'
use Rack::Flash

get '/' do
  @links = Link.all
  erb :index
end

post '/links' do
  url = params[:url]
  title = params[:title]
  tags = params['tags'].split(' ').map do |tag|
    #find or create a new tag
    Tag.first_or_create(text: tag) # first_or_create is DataMapper method
  end
  Link.create(url: url, title: title, tags: tags) # tags is array
  redirect to '/'
end

get '/tags/:text' do
  tag = Tag.first(text: params[:text])
  @links = tag ? tag.links : []
  erb :index
end

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

get '/sessions/new' do
  erb :"sessions/new"
end

post '/sessions' do
  email, password = params[:email], params[:password]
  user  = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ["The email or password entered are incorrect"]
    erb :"sessions/new"
  end
end


