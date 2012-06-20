require 'rack/test'
require 'spec_helper'
ENV['RACK_ENV'] = 'test'
require_relative '../driller.rb'

module RSpecMixin
  include Rack::Test::Methods
  def app() Driller end
end

RSpec.configure do |config|
  config.include RSpecMixin
end
