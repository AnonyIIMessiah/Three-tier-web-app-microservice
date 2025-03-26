## Start Mongo inside Docker
docker run -d --rm  --network myapp-network --name mongo -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=pass  mongo:4.0.4

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

docker build -t user-service .

docker run -d --rm -p 5001:5001 --network myapp-network --name user-service user-service

Now visit: http://localhost:5001/users

## Run Product Service

cd product-service
npm install
node server.js

docker build -t product-service .
docker run -d  --network myapp-network --rm --name product-service -p 5002:5002 product-service

Now visit: http://localhost:5002/products

## Run Frontend Service
cd frontend
npm install @mui/material @emotion/react @emotion/styled

npm start

docker build -t frontend .
docker run -d --rm -p 3000:3000 --network myapp-network --name frontend frontend
Now visit: http://localhost:3000

## Test containers
docker run -d --network myapp-network --rm --name node  node
