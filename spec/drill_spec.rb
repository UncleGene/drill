require 'spec_helper'

describe "Drill" do
  let(:drill) { Drill.new }
  subject { drill }
  
  context "empty" do 
    it {should be_blank}
  end
  
  it 'should sample candidates' do
    drill.candidates = 10.times.map(&:to_i)
    pieces=[1]
    drill.pick
    drill.piece.should be
    drill.pieces.size.should == Drill::PIECES_IN_DRILL
  end
end


