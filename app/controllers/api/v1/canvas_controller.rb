class Api::V1::CanvasController < ApplicationController

  def show
    canvas = Canvas.find(params[:id])
    if canvas
      render body: canvas.bitfield
    else
      render json: { message: "No canvas matches that ID" }, status: :not_found
    end
  end

  # def create
  #   canvas = Canvas.find(params[:id])
  #   if canvas
  #     render body: canvas.bitfield, status: :ok
  #   else
  #     canvas = Canvas.create(params[:id])
  #     render body: canvas.bitfield, status: :created
  #   end
  # end

  def update
    # validate request
    canvas = Canvas.find(params[:id])
    unless canvas
      return render json: { message: "No canvas matches that ID. Make sure the canvas ID is in the URL: /api/canvas/:id" }, status: :not_found
    end

    begin
      x, y = coords_from_params
      r, g, b, a = rgba_from_params
      start_index = ((y * 100) + x) * 4
      canvas.set_pixel(start_index, r, g, b, a)

      # backup
      game = Game.find_by(cohort: canvas.id)
      if game 
        # snapshot every 5 minutes
        if game.snapshots.last && game.snapshots.last.updated_at < (Time.now - (60 * 5))
          game.take_snapshot
        end
        # record move
        params = { game_id: game.id, x: x, y: y, r: r, g: g, b: b, a: a, ip: request.ip }
        RecordMoveJob.perform_later params
      end

      response = { coords: [x, y], color: [r, g, b, a] }

      CanvasChannel.broadcast_to canvas, response

      render json: response
    rescue ActionController::ParameterMissing => e
      render json: { message: e.message }, status: 400
    rescue StandardError => e
      render json: { message: e.message }, status: 400
    end
  end

  private

  def coords_from_params
    x = get_clamped_value(params.require(:x), 0, 99)
    y = get_clamped_value(params.require(:y), 0, 99)

    [x, y]
  end

  def rgba_from_params
    if params[:color].present?
      color = Color::RGB.by_css(params[:color])
      r = color.red.to_i
      g = color.green.to_i
      b = color.blue.to_i
      a = 255
    else
      r = get_clamped_value(params.require(:r), 0, 255)
      g = get_clamped_value(params.require(:g), 0, 255)
      b = get_clamped_value(params.require(:b), 0, 255)
      a = get_clamped_value(params.require(:a), 0, 255)
    end
    [r, g, b, a]
  end

  def get_clamped_value(value, min, max)
    value = value.to_i
    return min if value < min
    return max if value > max
    value
  end

end