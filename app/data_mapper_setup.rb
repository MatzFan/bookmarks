env = ENV['RACK_ENV'] || 'development'
heroku_db = `heroku config:get DATABASE_URL`

# setup DB depending on env we want
# DataMapper::Logger.new($stdout, :debug) # enables debug mode - puts SQL on command line - BEFORE SETUP
connection_string = ENV[heroku_db] || "postgres://localhost/bookmark_manager_#{env}"
DataMapper.setup(:default, connection_string)

#databaase address format as follows: dbtype://user:password@hostname:port/databasename

DataMapper.finalize # must be done after initializing - checks for consistency
