require 'active_record'
require 'sqlite3' # or 'mysql2', pg' or 'sqlite3'
require 'friendly_id'

Dir.glob('../webapp/app/models/*.rb', &method(:require))

# As in: http://stackoverflow.com/questions/1643875/how-to-use-activerecord-in-a-ruby-script-outside-rails
# Change the following to reflect your database settings
ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3', # 'mysql2', or 'postgresql' or 'sqlite3'
  # host:     'localhost',
  database: '../webapp/db/development.sqlite3'
  #username: 'your_username',
  #password: 'your_password'
)

# Test queries:
# puts ActiveRecord::Base.connection.tables
# puts User.all.collect(&:name)