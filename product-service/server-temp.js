const express = require('express');
const { MongoClient } = require('mongodb');
const cors = require('cors');
const app = express();
app.use(cors({ origin: '*' })); // Allow all origins`
// const url = 'mongodb://mongo:27017'; when running in docker
const url = 'mongodb://localhost:27017';

const client = new MongoClient(url);
const dbName = "microservices_db";

app.get('/products', async (req, res) => {
    await client.connect();
    const db = client.db(dbName);
    const productsCollection = db.collection('products');
    const products = await productsCollection.find({}).toArray();
    res.json(products);
});

app.listen(5002, () => {
    console.log('Product Service running on port 5002');
});
