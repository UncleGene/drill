require 'rack/test'

require_relative '../driller.rb'

module RSpecMixin
  include Rack::Test::Methods
  def app() Driller end
end

RSpec.configure { |c| c.include RSpecMixin }
