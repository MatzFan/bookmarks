#!/usr/bin/env ruby

require 'sinatra'
require 'data_mapper'
require 'capybara/rspec'

env = ENV['RACK_ENV'] || 'development'

# setup DB depending on env we want
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
#databaase address format as follows: dbtype://user:password@hostname:port/databasename

require './lib/link' # must be done after DataMapper is initialized
require './lib/tag' # must be done after DataMapper is initialized

DataMapper.finalize # must be doen after initializing
DataMapper.auto_upgrade! # creates the tables

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
