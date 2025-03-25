from flask import Flask, jsonify
from pymongo import MongoClient
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
# Connect to MongoDB
# Use 'mongodb://mongo:27017/' if running in Docker Compose
# Use 'mongodb://localhost:27017/' if running MongoDB on your local machine
MONGO_URI = "mongodb://localhost:27017/"
client = MongoClient(MONGO_URI)
db = client["microservices_db"]
users_collection = db["users"]

@app.route('/users')
def get_users():
    users = list(users_collection.find({}, {"_id": 0}))  # Fetch all users
    return jsonify(users)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
