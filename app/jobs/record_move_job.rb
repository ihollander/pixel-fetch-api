class RecordMoveJob < ApplicationJob
  queue_as :default

  def perform(move)
    move.save
  end

end
