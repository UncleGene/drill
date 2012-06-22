require 'sinatra/base'
require 'haml'
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
    @student = Student.last
  end
  
  get '/' do
    return "Welcome" unless @student
    haml :workout, :locals => { :student => @student }
  end

  post '/done' do
    @student.advance
    haml :workout, :locals => { :student => @student }
  end

  run! if __FILE__ == $0
end

