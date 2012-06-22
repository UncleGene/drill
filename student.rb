require 'data_mapper'
require_relative 'exercise'

class Student
  def on_plate
    return nil if workout.empty?
    workout[[current, workout.size - 1].min]
  end

  def progress
    score
  end

  def advance
    on_plate.advance
    self.score += 1
    self.current = rand(workout.size)
    save
  end

private # implementation details
  include DataMapper::Resource
  property :id, Serial
  property :score, Integer, :default => 0
  property :current, Integer, :default => 0
  has n, :exercises

  def workout
    @workout ||= Exercise.workout(self)
  end
end


