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

  describe "#progress" do
    it "should have correct progress with 0 score" do
      student.score = 0
      student.starred?.should be false
      student.progress.should be 0
      student.stars.should be 0
      student.big_stars.should be 0
    end

    it "should have correct progress with starred score" do
      student.score = 150
      student.starred?.should be true
      student.progress.should be 0
      student.stars.should be 3
      student.big_stars.should be 1
    end

    it "should have correct progress with unstarred big score" do
      student.score = 159
      student.starred?.should be false
      student.progress.should be 9
      student.stars.should be 3
      student.big_stars.should be 1
    end

    
  end
end


