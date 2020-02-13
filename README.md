# ENDPOINTS
* rvm install 2.7.0
* gem install bundler
* bundle install
* rails db:migrate 
* rails db:seed
* rails s

# ENDPOINTS

## Sessions

### Create Session
* **POST** http://localhost:3000/sessions.json/?session[name]=<NAME HERE\>
* **Returns:** {"token": <SESSION TOKEN\>, "name": <NAME HERE\>}

## Games

### Game Status
* **GET** http://localhost:3000/games.json/<GAME PIN\>/status
* **Returns:** { "pin": <GAME PIN\>, "status": "waiting", "sessions": [{"token": <SESSION TOKEN\>, "name": <NAME HERE\>}]}

### Create Game
* **POST** http://localhost:3000/games.json?token=<SESSION TOKEN\>
* **Returns:** { "pin": <GAME PIN\> }

### Join Game
* **POST** http://localhost:3000/games/<GAME PIN\>/join.json?token=<SESSION TOKEN\>
* **Returns:** Same as status
