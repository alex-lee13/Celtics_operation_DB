from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


coaches = Blueprint('coaches', __name__)

#Get all the players from the database
@coaches.route('/players', methods = ['GET'])
def get_all_players():
  
  # get a cursor object from the database
   cursor = db.get_db().cursor()
    
   # use cursor to query the database for a list of products
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

@coaches.route('/players/<p_number>', methods = ['GET'])
def get_player(p_number):
  # get a cursor object from the database
   cursor = db.get_db().cursor()
    
   # use cursor to query the database for a list of products
   cursor.execute('SELECT * from Players WHERE p_number = {0}'.format(p_number))

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

@coaches.route('/practices', methods = ['GET'])
def get_all_practices():
    # get a cursor object from the database
   cursor = db.get_db().cursor()
    
   # use cursor to query the database for a list of products
   cursor.execute('SELECT * from Practices')

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

@coaches.route('/games', methods = ['GET'])
def get_all_games():
    # get a cursor object from the database
   cursor = db.get_db().cursor()
    
   # use cursor to query the database for a list of products
   cursor.execute('SELECT gameID, game_date, opponent from Games')

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

@coaches.route('/practices', methods = ['POST'])
def post_practice():
    # access json data from request object
    current_app.logger.info("Processing form data")
    req_data = request.get_json()
    current_app.logger.info(req_data)

    practice_num = req_data['practice_num']
    pract_date = req_data['pract_date']
    duration = req_data['duration']
    location = req_data['location']

    # construct insert statement
    insert_stmt = 'INSERT INTO Practices VALUES ('
    insert_stmt += str(practice_num) + ', "' + pract_date + '", ' + str(duration) + ', "' + location + '")'

    current_app.logger.info(insert_stmt)

    # execute the query
    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success!'

@coaches.route('/practices/<practice_num>', methods = ['DELETE'])
def delete_practice(practice_num):

    # construct delete statement
    delete_stmt = 'DELETE from Practices WHERE practice_num = {0}'.format(practice_num)

    current_app.logger.info(delete_stmt)

    # execute the query
    cursor = db.get_db().cursor()
    cursor.execute(delete_stmt)
    db.get_db().commit()
    return 'Success!'

@coaches.route('/practices/<practice_num>', methods = ['PUT'])
def update_practice(practice_num):
    # access json data from request object
    current_app.logger.info("Processing form data")
    req_data = request.get_json()
    current_app.logger.info(req_data)
   # construct putstatement

    pract_date = req_data['pract_date']

    put_stmt = 'UPDATE Practices SET pract_date = "' + pract_date + '" WHERE practice_num = {0}'.format(practice_num)

    current_app.logger.info(put_stmt)

    # execute the query
    cursor = db.get_db().cursor()
    cursor.execute(put_stmt)
    db.get_db().commit()
    return 'Success!'

@coaches.route('/games/<gameID>', methods = ['PUT'])
def update_scoutingreport(gameID):
    # access json data from request object
    current_app.logger.info("Processing form data")
    req_data = request.get_json()
    current_app.logger.info(req_data)

    play_1 = req_data['play_1']
    play_2 = req_data['play_2']
    play_3 = req_data['play_3']

    # construct insert statement
    update_stmt = 'UPDATE ScoutingReports SET play_1 = "' + play_1 + '", play_2 = "' + play_2 + '", play_3 = "' + play_3 + '"'
    update_stmt += 'WHERE gameID = {0}'.format(gameID)

    current_app.logger.info(update_stmt)

    # execute the query
    cursor = db.get_db().cursor()
    cursor.execute(update_stmt)
    db.get_db().commit()
    return 'Success!'

@coaches.route('/games', methods = ['POST'])
def post_scoutingreport():
    # access json data from request object
    current_app.logger.info("Processing form data")
    req_data = request.get_json()
    current_app.logger.info(req_data)

    gameID = req_data['gameID']
    DRTG = req_data['DRTG']
    ORTG = req_data['ORTG']
    play_1 = req_data['play_1']
    play_2 = req_data['play_2']
    play_3 = req_data['play_3']

    # construct insert statement
    insert_stmt = 'INSERT INTO ScoutingReports VALUES ('
    insert_stmt +=  str(gameID) + ', ' + str(DRTG) + ', ' + str(ORTG) + ', "' + play_1 + '", "' + play_2 + '", "' + play_3 + '")'.format(gameID)

    current_app.logger.info(insert_stmt)

    # execute the query
    cursor = db.get_db().cursor()
    cursor.execute(insert_stmt)
    db.get_db().commit()
    return 'Success!'



  
