require 'spec_helper'

describe "Student" do
  let(:student) { Student.new }
  subject { student }
  
  context "empty"  do
    it "should have nothing on plate" do
      Exercise.should_receive(:workout).with(student) { [] }
      student.on_plate.should_not be
    end

    it "should heve zero score" do 
      student.score.should == 0 
    end
  end

  describe "#on_plate" do
    it "should have something on plate if workout exists" do
      Exercise.should_receive(:workout).with(student) { [42, 24] }
      student.on_plate.should be
    end
    
    it "should return exercise from a single-element workout" do 
      Exercise.should_receive(:workout).with(student) { [42] }
      student.on_plate.should == 42
    end
  end
end


