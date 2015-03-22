require 'mongo'
include Mongo

MONGO_URI = ENV['MONGOLAB_URI']
CLIENT = MongoClient.from_uri(MONGO_URI)
DB = CLIENT.db("timetables")
COLL = DB.collection("teststudents")