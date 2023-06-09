from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


lc = Blueprint('lc', __name__)

@lc.route('/players', methods = ['GET'])
def get_players():
  
  # get a cursor object from the database
   cursor = db.get_db().cursor()
    
   # use cursor to query the database for a list of players
   cursor.execute('SELECT p_number, fName, lName, height, weight FROM Players')

   # grab the column headers from the returned data
   column_headers = [x[0] for x in cursor.description]

   # create an empty dictionary object to use in 
   # putting column headers together with data
   json_data = []

   # fetch all the data from the cursor
   theData = cursor.fetchall()

   # for each of the rows, zip the data elements together with
   # the column headers. 
   for row in theData:
       json_data.append(dict(zip(column_headers, row)))

   return jsonify(json_data)


# Get a players' stats from the databse
@lc.route('/players/<p_number>', methods = ['GET'])
def get_player(p_number):
  
   cursor = db.get_db().cursor()
    
   cursor.execute('SELECT * FROM Players WHERE p_number = {0}'.format(p_number))

   column_headers = [x[0] for x in cursor.description]

   json_data = []

   theData = cursor.fetchall()

   for row in theData:
       json_data.append(dict(zip(column_headers, row)))

   return jsonify(json_data)

# Gets all the games' gameIDs 
@lc.route('/games', methods = ['GET'])
def get_total_games():
  
   cursor = db.get_db().cursor()
    
   cursor.execute('SELECT * FROM Games')

   column_headers = [x[0] for x in cursor.description]

   json_data = []

   theData = cursor.fetchall()

   for row in theData:
       json_data.append(dict(zip(column_headers, row)))

   return jsonify(json_data)


# Gets all the game data for a game
@lc.route('/games/<gameID>', methods = ['GET'])
def get_games(gameID):
  
   cursor = db.get_db().cursor()
    
   cursor.execute('SELECT gameID, game_date, num_tix, avg_tix_price, s_name FROM Games WHERE gameID = {0}'.format(gameID))

   column_headers = [x[0] for x in cursor.description]

   json_data = []

   theData = cursor.fetchall()

   for row in theData:
       json_data.append(dict(zip(column_headers, row)))

   return jsonify(json_data)


# LC can post any new games 
@lc.route('/games', methods = ['POST'])
def post_games():
    # access json data from request object
    current_app.logger.info("Processing form data")
    req_data = request.get_json()
    current_app.logger.info(req_data)

    gameID = req_data['gameID']
    game_date = req_data['game_date']
    opponent = req_data['opponent']
    num_tix = req_data['num_tix']
    avg_tix_price = req_data['avg_tix_price']
    s_name = req_data['s_name']

    # construct insert statement
    insert_stmt = 'INSERT INTO Games VALUES ('
    insert_stmt += str(gameID) + ', "' + game_date + '", "' + opponent + '", ' + str(num_tix) + ', ' + str(avg_tix_price) + ', "' + s_name + '")'

    current_app.logger.info(insert_stmt)

    # execute the query
    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success!'

# Update date of the game
@lc.route('/games/<gameID>', methods=['PUT'])
def update_game_details(gameID):
    # access json data from request object
    current_app.logger.info("Processing form data")
    req_data = request.get_json()
    current_app.logger.info(req_data)

   # construct put statement
    game_date = req_data['gamedate']

    put_stmt = 'UPDATE Games SET game_date = "' + game_date + '" WHERE gameID = {0}'.format(gameID)

    current_app.logger.info(put_stmt)

    # execute the query
    cursor = db.get_db().cursor()
    cursor.execute(put_stmt)
    db.get_db().commit()
    return 'Success!'

# LC can delete a game
@lc.route('/games/<gameID>', methods=['DELETE'])
def delete_game(gameID):
    # construct delete statement
    delete_stmt = 'DELETE from Games WHERE gameID = {0}'.format(gameID)

    current_app.logger.info(delete_stmt)

    # execute the query
    cursor = db.get_db().cursor()
    cursor.execute(delete_stmt)
    db.get_db().commit()
    return 'Success!'

# Get all players' contracts from the databse
@lc.route('/playercontracts', methods = ['GET'])
def get_playercontracts():
  
   cursor = db.get_db().cursor()
    
   cursor.execute('SELECT p_number, salary, term FROM PlayerContracts')

   column_headers = [x[0] for x in cursor.description]

   json_data = []

   theData = cursor.fetchall()

   for row in theData:
       json_data.append(dict(zip(column_headers, row)))

   return jsonify(json_data)

# Get a player's contract details from the databse
@lc.route('/playercontracts/<p_number>', methods = ['GET'])
def get_playercontract(p_number):
  
   cursor = db.get_db().cursor()
    
   cursor.execute('SELECT * FROM PlayerContracts WHERE p_number = {0}'.format(p_number))

   column_headers = [x[0] for x in cursor.description]

   json_data = []

   theData = cursor.fetchall()

   for row in theData:
       json_data.append(dict(zip(column_headers, row)))

   return jsonify(json_data)

# Update the fine quantity for a player
@lc.route('/playercontracts/<p_number>', methods=['PUT'])
def update_player_contract(p_number):
    # access json data from request object
    current_app.logger.info("Processing form data")
    req_data = request.get_json()
    current_app.logger.info(req_data)

   # construct put statement
    fine = req_data['fine']

    put_stmt = 'UPDATE PlayerContracts SET fine = ' + str(fine) + ' WHERE p_number = {0}'.format(p_number)

    current_app.logger.info(put_stmt)

    # execute the query
    cursor = db.get_db().cursor()
    cursor.execute(put_stmt)
    db.get_db().commit()
    return 'Success!'

# LC can delete a player's contract
@lc.route('/playercontracts/<p_number>', methods=['DELETE'])
def delete_contract(p_number):
    # construct delete statement
    delete_stmt = 'DELETE from PlayerContracts WHERE p_number = {0}'.format(p_number)

    current_app.logger.info(delete_stmt)

    # execute the query
    cursor = db.get_db().cursor()
    cursor.execute(delete_stmt)
    db.get_db().commit()
    return 'Success!'