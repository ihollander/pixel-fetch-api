class CanvasChannel < ApplicationCable::Channel
  def subscribed
    canvas = Canvas.find(params[:id])
    stream_for canvas
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
