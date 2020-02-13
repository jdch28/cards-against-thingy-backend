json.pin @current_game.pin
json.status @current_game.game_status

case @current_game.game_status
when 'waiting_players'
  json.sessions @current_game.sessions do |session|
    json.token session.token
    json.name session.name
  end
when 'ready'
  json.round 'A nice round object'
when 'complete'
  json.scores 'Player(s) score'
end
