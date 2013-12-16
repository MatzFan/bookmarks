#!/usr/bin/env ruby

require 'sinatra'
require 'data_mapper'
require 'capybara/rspec'

env = ENV['RACK_ENV'] || 'development'

# setup DB depending on env we want
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
#databaase address format as follows: dbtype://user:password@hostname:port/databasename

require './lib/link' # must be done after DataMapper is initialized

DataMapper.finalize # must be doen after initializing
DataMapper.auto_upgrade! # creartes the tables

get '/' do
  @links = Link.all
  erb :index
end

post '/links' do
  url = params[:url]
  title = params[:title]
  Link.create(url: url, title: title)
  redirect to '/'
end
