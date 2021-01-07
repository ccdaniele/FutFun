require 'bundler'
require 'pry'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
