# 5 request per minute per IP
Rack::Attack.throttle("requests by ip", limit: 5, period: 60) do |request|
  request.ip
end