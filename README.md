# SETUP
* rvm install 2.7.0
* rvm use 2.7.0
* rvm gemset create hackathon
* rvm gemset user hackathon
* gem install bundler
* bundle install
* rails db:migrate
* rails db:seed
* rails s

# ENDPOINTS

## Sessions

### Create Session
* **POST** http://localhost:3000/sessions.json/?session[name]=**<NAME HERE\>**
* **Returns:**
  * "token":
    * "token": **<SESSION TOKEN\>**
    * "name": **<NAME HERE\>**

## Games

### Game Status
* **GET** http://localhost:3000/games/**<GAME PIN\>**/status.status
* **Returns:**
    * "type": "Game"
    * "pin": **<GAME PIN\>**
    * "status": **<GAME STATUS\>**
    * "sessions":
      * "token": **<SESSION TOKEN\>**
      * "name": **<NAME HERE\>**
* when round status == `waiting_for_players` you will also get:
  * "sessions":
    * "token": **<SESSION TOKEN\>**
    * "name": **<SESSION NAME\>**
* when round status == `ready` you will also get:
  * "round_data":
    * "round_number": **<ROUND NUMBER\>**
    * "black_card": **<ROUND BLACK CARD TEXT\>**
    * "czar_token": **<ROUND CZAR TOKEN\>**
    * "player_card": [ **<PLAYER HAND(TEXT)\>** ]
* when round status == `complete` you will also get:
  * "scores": **<TBD\>**

### Create Game
* **POST** http://localhost:3000/games.json?token=**<SESSION TOKEN\>**
* **Returns:**
  * "pin": **<GAME PIN\>**

### Join Game
* **POST** http://localhost:3000/games/**<GAME PIN\>**/join.json?token=**<SESSION TOKEN\>**
* **Returns:** Same as status

## Rounds

### Round Status
* **GET** http://localhost:3000/rounds/status.json?pin=**<GAME PIN\>**&token=**<SESSION TOKEN\>**
* **Returns:**
  * "type": "Round"
  * "pin": **<GAME PIN\>**
  * "status": **<ROUND STATUS\>**
#### Conditional Returns:
* when round status == `complete` you will also get:
  * "score": **<SESSION SCORE\>**,
  * "winner":
    * "card": **<CARD TEXT\>**
    * "name": **<SESSION NAME\>**
    * "token": "**<SESSION TOKEN\>**

### Cards For Rounds
* **GET** http://localhost:3000/rounds/card_list.json?pin=**<GAME PIN\>**&token=**<SESSION TOKEN\>**
* **Returns:** {
  * "pin": **<GAME PIN\>**
  * "cards":
    * "text": **<CARD TEXT\>,**
    * "token": **<SESSION TOKEN\>**

### Submit Card
* **POST** http://localhost:3000/rounds/submit_card.json?card_id=**<CARD ID\>**&pin=**<GAME PIN\>**&token=**<SESSION TOKEN\>**
* **Returns:** Same as status

### Submit Winner
* **POST** http://localhost:3000/rounds/submit_winner.json?winner_token=**<WINNER TOKEN\>**&pin=**<GAME PIN\>**&token=**<SESSION TOKEN\>**
* **Returns:** Same as status
