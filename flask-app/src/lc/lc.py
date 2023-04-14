from flask import Blueprint, request, jsonify, make_response
import json
from src import db


lc = Blueprint('lc', __name__)

@lc.route('/players', methods = ['GET'])
def get_players():
  
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


# Get all practices from the databse
@lc.route('/players/{p_number}', methods = ['GET'])
def get_practices():
  
   cursor = db.get_db().cursor()
    
   cursor.execute('SELECT * FROM Players')

   column_headers = [x[0] for x in cursor.description]

   json_data = []

   theData = cursor.fetchall()

   for row in theData:
       json_data.append(dict(zip(column_headers, row)))

   return jsonify(json_data)

# Gets all the game data for a game
@lc.route('/games/{game_id}', methods = ['GET'])
def get_games():
  
   cursor = db.get_db().cursor()
    
   cursor.execute('SELECT gameID, game_date, num_tix, avg_tix_price, s_name FROM Games')

   column_headers = [x[0] for x in cursor.description]

   json_data = []

   theData = cursor.fetchall()

   for row in theData:
       json_data.append(dict(zip(column_headers, row)))

   return jsonify(json_data)


# LC can post any new games 
@lc.route('/games', methods = ['POST'])
def post_games():
  
   cursor = db.get_db().cursor()
    
   cursor.execute('INSERT INTO Games VALUES(51, '2023-01-01', 'Knicks', 1000, 100, 'Waters LLC')')

   column_headers = [x[0] for x in cursor.description]

   json_data = []

   theData = cursor.fetchall()

   for row in theData:
       json_data.append(dict(zip(column_headers, row)))

   return jsonify(json_data)
