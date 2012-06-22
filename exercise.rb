require 'date'
class Exercise
  def self.workout(student)
    today = Time.now.to_date
    wo = student.exercises(:last_workout => today)
    return wo unless wo.empty?
    all = student.exercises
    return [] if all.empty?
    all.sample(WORKOUT).each{|e| e.update(:last_workout => today)}.sort_by(&:id)
  end

  def advance
    update(:count => count + 1)
  end

private # implementation details

  include DataMapper::Resource
  property :id, Serial
  property :last_workout, Date
  property :name, String, :length => 255
  property :count, Integer, :default => 0
  belongs_to :student

  WORKOUT = 5

end


