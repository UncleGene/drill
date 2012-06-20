require 'sinatra/base'
require_relative 'drill'

class Driller < Sinatra::Base
  get '/' do
  end

  run! if __FILE__ == $0
end

