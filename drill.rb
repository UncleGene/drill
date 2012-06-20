class Drill
  PIECES_IN_DRILL = 5
  attr_accessor :pieces, :candidates
  def initielize
    @pieces = []
    @candidates = []
  end

  def blank?
    true
  end

  def piece
    self.pieces.first
  end

  def pick
    self.pieces = candidates.sample(PIECES_IN_DRILL)
  end
end
