require 'data_mapper'
require_relative 'exercise'

class Student
  def on_plate
    return nil if workout.empty?
    workout[[current, workout.size - 1].max]
  end

  def new_workout
    @workout = Exercise.new_workout(self)
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

  #def new_workout
  #  @workout = Exercise.new_workout(self)
  #end
end


