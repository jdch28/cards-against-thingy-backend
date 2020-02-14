json.type 'Game'
json.pin @current_game.pin
json.status @current_game.game_status

case @current_game.game_status
  when 'waiting_for_players'
    json.sessions @current_game.sessions do |session|
      json.token session.token
      json.name session.name
    end
  when 'game_complete'
    json.scores @current_game.get_final_scores
end
