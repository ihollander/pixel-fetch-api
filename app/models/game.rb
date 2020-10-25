class Game < ApplicationRecord
  after_create :make_board, :take_snapshot

  has_many :moves
  has_many :snapshots

  def take_snapshot
    if board
      self.snapshots.create(board: board.bitfield)
    end
  end

  def board
    Board.find(self.cohort)
  end

  def make_board
    Board.create(self.cohort)
  end

end
