require 'data_mapper'
require './app/data_mapper_setup'

task :auto_upgrade do
  DataMapper.auto_upgrade!
  #DataMapper.finalize
  puts 'Auto-upgrade complete (no data loss)'
end

task :auto_migrate do
  DataMapper.auto_migrate!
  #DataMapper.finalize
  puts 'Auto-migrate complete (data was lost)'
end
