env = ENV['RACK_ENV'] || 'development'

# setup DB depending on env we want
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
#databaase address format as follows: dbtype://user:password@hostname:port/databasename

DataMapper.finalize # must be done after initializing - checks for consistency
DataMapper.auto_upgrade! # creates the tables
# c.c. auto_migrate! - which forces any schema changes & potentially destroys data
# auto_update! will not make schema changes that would destroy data
