json.pin @current_game.pin
json.status @current_game.status

json.sessions @current_game.sessions do |session|
  json.token session.token
  json.name session.name
end
