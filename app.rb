require 'sinatra/base'
require 'haml'
require 'sinatra/flash'
require_relative 'student'
class App < Sinatra::Base
  enable :sessions unless test?
  register Sinatra::Flash
  
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
  end

  helpers do
    def student
      @student ||= Student.first_or_create(:login_name => params[:name]) if params[:name]
    end

    def root
      "/#{student.login_name}"
    end  
  end
  
  get '/:name' do
    student.start
    haml :workout
  end

  post '/:name' do
    begin
      student.done
      flash.now[:notice] = "You've got star!" if student.starred?
    rescue CheatError
      flash.now[:notice] = "Please do not cheat!"
    end
    student.start
    haml :workout
  end

  run! if __FILE__ == $0
end

