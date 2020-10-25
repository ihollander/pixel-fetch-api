# 10 request per minute per IP
Rack::Attack.throttle("requests_by_ip", limit: 10, period: 60) do |request|
  # only throttle requests to /api/v1/canvas/:id
  if request.path.match(/api\/v1\/canvas\/(.*)/)
    request.ip
  end
end