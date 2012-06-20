require 'spec_helper'
require_relative '../../models/drill'

class DummyRecord
  attr_accessor :pieces
  attr_accessor :candidates
  def initialize
    @pieces = []
    @candidates = []
  end
end

describe "Drill" do
  let(:drill) { DummyRecord.new.extend Drill }
  subject { drill }
  
  context "empty" do 
    it {should be_blank}
    it 'should have no piece' do
      drill.piece.should_not be
    end
  end
  
  it 'should sample candidates' do
    drill.candidates = 10.times.map(&:to_i)
    pieces=[1]
    drill.pick
    puts drill.candidates
    puts drill.pieces
    drill.piece.should be
  end
end


