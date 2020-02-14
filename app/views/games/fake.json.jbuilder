json.pin @game.pin
json.sessions @game.sessions do |session|
  json.token session.token
  json.name session.name
end
