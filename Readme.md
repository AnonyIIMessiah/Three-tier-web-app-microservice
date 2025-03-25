## Start Mongo inside Docker
docker run -d --name mongo -p 27017:27017 mongo:4.0.4

 docker run -d --name mongo \
	-e MONGO_INITDB_ROOT_USERNAME=admin \
	-e MONGO_INITDB_ROOT_PASSWORD=admin \
	mongo:4.0.4


## Maually insert data
docker exec -it mongo mongo
mongo
use microservices_db
db.users.insertMany([{ "id": 1, "name": "John Doe" }, { "id": 2, "name": "Jane Smith" }])
db.products.insertMany([{ "id": 1, "name": "Laptop" }, { "id": 2, "name": "Phone" }])
exit

## Run User Service 
cd user-service
python3 -m venv myenv
source myenv/bin/activate
pip install -r requirements.txt
python app.py

Now visit: http://localhost:5001/users

## Run Product Service

cd product-service
npm install
node server.js

Now visit: http://localhost:5002/products

## Run Frontend Service
cd frontend
npm install @mui/material @emotion/react @emotion/styled

npm start
Now visit: http://localhost:3000

