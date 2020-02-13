json.pin @current_game.pin
json.cards @current_game.answers_for_current_round do |pc|
  json.text pc.card.text
  json.token pc.token
end
