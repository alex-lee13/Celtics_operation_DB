from flask import Blueprint, request, jsonify, make_response
import json
from src import db


coaches = Blueprint('coaches', __name__)