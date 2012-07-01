require 'data_mapper'
require_relative 'exercise'

class Student
  STAR_EX = 15
  BIGSTAR_EX = 7
  def on_plate
    return nil if workout.empty?
    workout[[current, workout.size - 1].min]
  end

  def progress
    score % STAR_EX
  end

  def starred?
    score > 0 && progress == 0
  end

  def stars
    score % (STAR_EX * BIGSTAR_EX) / STAR_EX
  end

  def big_stars
    score / STAR_EX / BIGSTAR_EX 
  end
  
  def start
    on_plate && on_plate.start
  end

  def done
    on_plate.done
    self.score += 1
    self.current = rand(workout.size)
    save
  end

  def add(ex)
    self.exercises << Exercise.init(ex)
    save
  rescue 
  end

private # implementation details
  include DataMapper::Resource
  property :id, Serial
  property :login_name, String, :length => 3..50, :required => true
  property :score, Integer, :default => 0
  property :current, Integer, :default => 0
  has n, :exercises

  def workout
    @workout ||= Exercise.workout(self)
  end
end


