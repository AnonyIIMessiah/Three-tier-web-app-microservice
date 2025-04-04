from flask import Flask, jsonify, request
from flask_cors import CORS
from pymongo import MongoClient

app = Flask(__name__)
CORS(app)  # Enable CORS for frontend access

# Connect to MongoDB
# MONGO_URI="mongodb://admin:pass@mongo:27017/" #for docker
MONGO_URI="mongodb://admin:pass@mongodb:27017/" #for kubernetes and have to change the url as the service name in deployment.yaml is mongodb

# MONGO_URI = "mongodb://admin:pass@localhost:27017/"  # Change to 'mongodb://mongo:27017/' if using Docker
client = MongoClient(MONGO_URI)
db = client["microservices_db"]
users_collection = db["users"]

# 📌 GET all users
@app.route('/users', methods=['GET'])
def get_users():
    users = list(users_collection.find({}, {"_id": 0}))  # Exclude _id from response
    return jsonify(users)

# 📌 GET a single user by ID
@app.route('/users/<int:user_id>', methods=['GET'])
def get_user(user_id):
    user = users_collection.find_one({"id": user_id}, {"_id": 0})
    if user:
        return jsonify(user)
    return jsonify({"error": "User not found"}), 404

# 📌 POST - Add a new user
@app.route('/users', methods=['POST'])
def add_user():
    data = request.json
    if not data or "name" not in data:
        return jsonify({"error": "Missing id or name"}), 400

    # Check if user ID already exists
    if users_collection.find_one({"id": data["id"]}):
        return jsonify({"error": "User ID already exists"}), 400

    users_collection.insert_one({"id": data["id"], "name": data["name"]})
    return jsonify({"message": "User added"}), 201

# 📌 PUT - Update a user by ID
@app.route('/users/<user_id>', methods=['PUT'])
def update_user(user_id):
    data = request.json
    if not data or "name" not in data:
        return jsonify({"error": "Missing name"}), 400

    updated = users_collection.update_one({"id": user_id}, {"$set": {"name": data["name"]}})
    if updated.matched_count == 0:
        return jsonify({"error": "User not found"}), 404

    return jsonify({"message": "User updated"}), 200

# 📌 DELETE - Remove a user by ID
@app.route('/users/<user_id>', methods=['DELETE'])
def delete_user(user_id):
    deleted = users_collection.delete_one({"id": user_id})
    if deleted.deleted_count == 0:
        return jsonify({"error": "User not found"}), 404

    return jsonify({"message": "User deleted"}), 200

# Run the app
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
