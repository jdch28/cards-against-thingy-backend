json.type 'Round'
json.pin @current_game.pin
json.status @current_game.round_status

case @current_game.round_status
  when 'round_complete'
    json.score PlayedCard.get_user_score(@current_session.token)
    json.winner @current_game.get_current_round_winner
end
