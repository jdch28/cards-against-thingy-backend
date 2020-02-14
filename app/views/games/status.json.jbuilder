json.type 'Game'
json.pin @current_game.pin
json.status @current_game.game_status

case @current_game.game_status
  when 'waiting_for_players'
    json.sessions @current_game.sessions do |session|
      json.token session.token
      json.name session.name
    end
  when 'ready'
    json.round_data do
      json.round_number @current_game.current_round
      json.black_card @current_game.get_black_card
      json.czar_token @current_game.next_czar_token
      json.player_hand @current_session.player_cards
    end
  when 'complete'
    json.scores 'Player(s) score'
end
