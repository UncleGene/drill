module Drill
  PIECES_IN_DRILL = 5

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
