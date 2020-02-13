json.score PlayedCard.get_user_score(@current_session.token)
json.winner @round.get_winner
json.status @current_game.round_status
