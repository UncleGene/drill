class Exercise
  def self.workout(student)
    student.exercises(:when => :now)
  end

  def self.new_workout(student)
    all = student.exercises
    all.update(:when => :postpone)
    all.sample(WORKOUT).each{|e| e.update(:when => :now)}
  end

private # implementation details

  include DataMapper::Resource
  property :id, Serial
  property :when, Enum[:now, :postpone], :default => :postpone
  property :name, String, :length => 255
  property :count, Integer, :default => 0
  belongs_to :student

  WORKOUT = 5

end


