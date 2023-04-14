from flask import Blueprint, request, jsonify, make_response
import json
from src import db


lc = Blueprint('lc', __name__)