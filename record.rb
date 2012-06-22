require 'date'
require_relative 'errors'

class Record
  MAX = 180
  MIN = 30

  def self.start(exercise)
    first_or_create({:exercise => exercise, :time =>nil}, {:exercise => exercise, :time =>nil, :started_at => Time.now})
  end

  def self.done(exercise)
    r = last(:exercise => exercise, :time => nil)
    raise "Something wrong" unless r
    start_time = r.started_at.to_time 
    time = [Time.now - start_time, MAX].min
    raise CheatError.new if time < MIN
    start_time = Time.now - time # mitigate user-delayed finish
    r.update(:time => time, :started_at => start_time)
  end

private # implementation details

  include DataMapper::Resource
  property :id, Serial
  property :started_at, DateTime
  property :time, Integer
  belongs_to :exercise
end
