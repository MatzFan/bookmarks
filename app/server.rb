#!/usr/bin/env ruby

require 'sinatra'
require 'data_mapper'
require './lib/link' # must be done after DataMapper is initialized
require './lib/tag' # ditto
require './lib/user' # ditto
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions # Sinatra
set :session_secret, 'super secret'

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
  erb :"users/new" # quotes to avoid interpreter trying to divide!
end

post '/users' do
  user = User.create(email: params[:email],
              password: params[:password])
  session[:user_id] = user.id # sets a session cookie for the user
  redirect to('/')
end
