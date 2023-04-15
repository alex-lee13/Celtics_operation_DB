from flask import Blueprint, request, jsonify, make_response
import json
from src import db


coaches = Blueprint('coaches', __name__)

#Get all the players from the database
@coaches.route('/players', methods = ['GET'])
def get__all_players():
  
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
def get_all_practices():
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
  
