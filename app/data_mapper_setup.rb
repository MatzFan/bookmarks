env = ENV['RACK_ENV'] || 'development'

Dir.glob("./app/models/*").each { |model| require model }

# setup DB depending on env we want
# DataMapper::Logger.new($stdout, :debug) # enables debug mode - puts SQL on command line - BEFORE SETUP

#database address format as follows: dbtype://user:password@hostname:port/databasename
connection_string = ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{env}"

DataMapper.setup(:default, connection_string)
DataMapper.finalize # must be done after initializing - checks for consistency
