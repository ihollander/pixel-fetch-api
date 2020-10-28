class Game < ApplicationRecord
  after_create :make_canvas, :take_snapshot

  has_many :moves
  has_many :snapshots

  def take_snapshot
    if canvas
      self.snapshots.create(board: canvas.bitfield)
    end
  end

  def canvas
    Canvas.find(self.cohort)
  end

  def make_canvas
    Canvas.create(self.cohort)
  end

end
