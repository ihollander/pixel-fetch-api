class RecordMoveJob < ApplicationJob
  queue_as :default

  def perform(params)
    Move.create(params)
  end

end
