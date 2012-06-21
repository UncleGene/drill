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
  
  before do
    @s = Student.get(1) 
  end
  
  get '/' do
    return "Welcome" unless @s
    @s.new_workout if @s.on_plate.nil?
    "#{@s.on_plate} #{@s.progress}"
  end

  get '/done' do
    @s.advance
    "#{@s.on_plate} #{@s.progress}"
  end

  run! if __FILE__ == $0
end

