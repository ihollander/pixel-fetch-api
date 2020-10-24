class Api::V1::CanvasController < ApplicationController

  def show
    board = Board.find(params[:id])
    if board
      render body: board.bitfield
    else
      render json: { message: "No board matches that ID" }, status: :not_found
    end
  end

  def create
    board = Board.find(params[:id])
    if board
      render body: board.bitfield, status: :ok
    else
      board = Board.create(params[:id])
      render body: board.bitfield, status: :created
    end
  end

  def update
    # validate request
    board = Board.find(params[:id])
    unless board
      return render json: { message: "No board matches that ID. Make sure the board ID is in the URL: /api/canvas/:id" }, status: :not_found
    end

    begin
      x, y = coords_from_params
      r, g, b, a = rgba_from_params
      start_index = ((y * 100) + x) * 4
      board.set_pixel(start_index, r, g, b, a)

      response = { coords: [x, y], color: [r, g, b, a] }

      BoardChannel.broadcast_to board, response
      
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