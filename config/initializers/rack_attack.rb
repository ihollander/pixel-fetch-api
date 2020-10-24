Rack::Attack.throttle("requests by ip", limit: 5, period: 3600) do |request|
  request.ip
end