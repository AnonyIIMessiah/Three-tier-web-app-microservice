const express = require('express');
const { MongoClient } = require('mongodb');
const cors = require('cors');
const dotenv = require('dotenv');

dotenv.config();

const app = express();
app.use(cors({ origin: '*' })); // Enable CORS
app.use(express.json()); // Middleware to parse JSON requests

// MongoDB Connection
const url=`mongodb://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@mongodb:27017`; // Change to 'mongodb://mongo:27017' if using Docker

// const url = 'mongodb://admin:pass@localhost:27017'; // Change to 'mongodb://mongo:27017' if using Docker
const client = new MongoClient(url);
const dbName = "microservices_db";

// async function connectDB() {
//     await client.connect();
//     return client.db(dbName).collection('products');
// }
async function connectDB() {
    try {
        await client.connect();
        console.log('Connected to MongoDB successfully');
        return client.db(dbName).collection('products');
    } catch (error) {
        console.error('MongoDB Connection Error:', error);
        throw error;
    }
}


// 📌 GET all products
app.get('/products', async (req, res) => {
    try {
        const productsCollection = await connectDB();
        const products = await productsCollection.find({}).toArray();
        res.json(products);
    } catch (error) {
        res.status(500).json({ error: "Error fetching products" });
    }
});

// 📌 GET a single product by ID
app.get('/products/:id', async (req, res) => {
    try {
        const productsCollection = await connectDB();
        const product = await productsCollection.findOne({ id: req.params.id });
        if (!product) return res.status(404).json({ error: "Product not found" });
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: "Error fetching product" });
    }
});

// 📌 POST - Add a new product
app.post('/products', async (req, res) => {
    try {
        const { id, name } = req.body;
        if (!id || !name ) {
            return res.status(400).json({ error: "Missing id, name, or price" });
        }

        const productsCollection = await connectDB();
        const existingProduct = await productsCollection.findOne({ id });

        if (existingProduct) {
            return res.status(400).json({ error: "Product ID already exists" });
        }

        await productsCollection.insertOne({ id, name });
        res.status(201).json({ message: "Product added" });
    } catch (error) {
        res.status(500).json({ error: "Error adding product" });
    }
});

// 📌 PUT - Update a product by ID
app.put('/products/:id', async (req, res) => {
    try {
        const { name, price } = req.body;
        if (!name || !price) {
            return res.status(400).json({ error: "Missing name or price" });
        }

        const productsCollection = await connectDB();
        const updated = await productsCollection.updateOne(
            { id: req.params.id },
            { $set: { name, price } }
        );

        if (updated.matchedCount === 0) {
            return res.status(404).json({ error: "Product not found" });
        }

        res.json({ message: "Product updated" });
    } catch (error) {
        res.status(500).json({ error: "Error updating product" });
    }
});

// 📌 DELETE - Remove a product by ID
app.delete('/products/:id', async (req, res) => {
    try {
        const productsCollection = await connectDB();
        const deleted = await productsCollection.deleteOne({ id: req.params.id });
        console.log(req.params.id)

        if (deleted.deletedCount === 0) {
            return res.status(404).json({ error: "Product not found" });
        }

        res.json({ message: "Product deleted" });
    } catch (error) {
        res.status(500).json({ error: "Error deleting product" });
    }
});

// Start the server
app.listen(5002, () => {
    console.log('Product Service running on port 5002');
});
