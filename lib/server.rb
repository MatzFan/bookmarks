#!/usr/bin/env ruby

require 'sinatra'
require 'data_mapper'
require 'capybara/rspec'

env = ENV['RACK_ENV'] || 'development' # default is 'development' database

# setup DB depending on env we want
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
#databaase address format as follows: dbtype://user:password@hostname:port/databasename

require './lib/link' # must be done after DataMapper is initialized

DataMapper.finalize # must be doen after initializing
DataMapper.auto_upgrade! # creartes the tables

Capybara.app = Sinatra::Application # tells Capy which type of app it is

get '/' do
  @links = Link.all
end
