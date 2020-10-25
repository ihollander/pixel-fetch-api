# 5 request per minute per IP
Rack::Attack.throttle("requests by ip", limit: 5, period: 60) do |request|
  # only throttle PATCH /api/v1/canvas/:id
  if request.path.match(/api\/v1\/canvas\/(.*)/) && request.patch?
    request.ip
  end
end