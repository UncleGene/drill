require 'rack/test'
ENV['RACK_ENV'] = 'test'
require_relative '../app'

module RSpecMixin
  include Rack::Test::Methods
  def app() App end
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.color_enabled = true
  config.formatter     = 'documentation'
end
