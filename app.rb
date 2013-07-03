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
    def require_student
      # cannot go to before filter because params are not available
      halt(403, "Looking for something?") unless student
    end

    def student
      @student ||= Student.first(:login_name => params[:name]) if params[:name]
    end

    def done_path
      "/#{student.login_name}"
    end

    def add_path
      "/#{student.login_name}/list"
    end
  end
  
  get '/:name' do
    require_student
    student.start
    haml :workout
  end

  post '/:name' do
    require_student
    begin
      student.done
      flash.now[:notice] = "You've got star!" if student.starred?
    rescue CheatError
      flash.now[:notice] = "Please do not cheat!"
    end
    student.start
    haml :workout
  end
  
  get '/:name/list' do
    require_student
    haml :list
  end

  post '/:name/list' do
    require_student
    student.add(params[:title]) 
    haml :list
  end

  run! if __FILE__ == $0
end

