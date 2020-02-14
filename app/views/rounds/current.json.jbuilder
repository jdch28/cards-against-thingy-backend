json.round_number @current_game.current_round
json.black_card @current_game.get_black_card
json.czar_token @current_game.next_czar_token
json.player_hand @current_session.player_cards

json.last_round do
  json.score PlayedCard.get_session_score(@current_session.token)
  json.winner @current_game.get_last_round_winner
end
