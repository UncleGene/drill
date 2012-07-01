require 'date'
require_relative 'record'

class Exercise
  def self.workout(student)
    today = Time.now.to_date
    wo = student.exercises(:last_workout => today)
    return wo unless wo.empty?
    exs = student.exercises
    return [] if exs.empty?
    exs.sort_by(&:count).first(WORKOUT).each{|e| e.update(:last_workout => today)}.sort_by(&:id)
  end

  def self.init(name)
    new(:name => name.strip) if name 
  end
  
  def start
    Record.start(self)
  end
  
  def done
    Record.done(self)
    update(:count => count + 1)
  end

private # implementation details

  include DataMapper::Resource
  property :id, Serial
  property :last_workout, Date
  property :name, String, :length => 3..255, :required => true
  property :count, Integer, :default => 0
  belongs_to :student

  WORKOUT = 5

end


