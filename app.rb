require 'sinatra/base'
require 'haml'
require 'sinatra/flash'
require_relative 'student'
class App < Sinatra::Base
  enable :sessions unless test?
  register Sinatra::Flash
  
  set :root, File.dirname(__FILE__)

  configure :test do
    DataMapper.setup(:default, "sqlite3::memory:")
  end

  configure :development do
    DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
  end

  configure :production do
    DataMapper.setup(:default, ENV['DATABASE_URL'])
  end

  configure do
    DataMapper.finalize
    DataMapper.auto_upgrade!
  end
  
  before do
    @student = Student.get(session[:uid])
  end
  
  get '/' do
    return "Welcome" unless @student
    @student.start
    haml :workout, :locals => { :student => @student }
  end

  post '/done' do
    begin
      @student.done
      flash.now[:notice] = "You've got star!" if @student.starred?
      @student.start
    rescue CheatError
      flash.now[:notice] = "Please do not cheat!"
    end
    haml :workout, :locals => { :student => @student }
  end

  get '/start/:login_name' do
    session[:uid] = Student.first_or_create(:login_name => params[:login_name]).id
    redirect to '/'
  end

  run! if __FILE__ == $0
end

