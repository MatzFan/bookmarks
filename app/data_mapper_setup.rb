env = ENV['RACK_ENV'] || 'development'

# setup DB depending on env we want
# DataMapper::Logger.new($stdout, :debug) # enables debug mode - puts SQL on command line - BEFORE SETUP
connection_string = ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{env}"
connection_string = 'postgres://gmzwineienaomx:bKmoAZiPhuNtI8DQrd6U1_oYim@ec2-54-221-223-92.compute-1.amazonaws.com:5432/d85vpvt7nnd29f'
DataMapper.setup(:default, connection_string)

#databaase address format as follows: dbtype://user:password@hostname:port/databasename

DataMapper.finalize # must be done after initializing - checks for consistency
