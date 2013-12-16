env = ENV['RACK_ENV'] || 'development'

# setup DB depending on env we want
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
#databaase address format as follows: dbtype://user:password@hostname:port/databasename

DataMapper.finalize # must be doen after initializing
DataMapper.auto_upgrade! # creates the tables
