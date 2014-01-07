ENV['RACK_ENV'] = 'test' # specifies database to work with

require './app/server'
require 'database_cleaner'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.app = Sinatra::Application
Capybara.javascript_driver = :poltergeist

#DataMapper.auto_migrate! # to auto_migrate the Test database

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
