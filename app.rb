require 'sinatra/base'
require_relative 'student'

class App < Sinatra::Base
  configure :test do
    DataMapper.setup(:default, "sqlite3::memory:")
  end

  configure :development do
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
  end

  configure do
    DataMapper.finalize
    DataMapper.auto_upgrade!
  end

  get '/' do
  end

  run! if __FILE__ == $0
end

