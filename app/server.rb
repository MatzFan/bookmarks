#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/partial'
require 'data_mapper'
require 'dm-constraints'
require 'rack-flash'

require_relative 'helpers/application'

Dir.glob("./app/models/*").each { |model| require model }
Dir.glob("./app/controllers/*").each { |controller| require controller }

require_relative 'data_mapper_setup' # AFTER MODELS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

enable :sessions # Sinatra
set :session_secret, 'my unique encryption key!'
use Rack::Flash
set :partial_template_engine, :erb # erb as oppose to HAML which is default
