## Microservice Representation
![Microservices Representation](Microservices-representation.png)

# Three-Tier Web App Microservice

A comprehensive three-tier microservices architecture web application demonstrating modern development patterns with React frontend, Python/Node.js backend services, and MongoDB database, all orchestrated with Docker containers.

## 🏗️ Architecture Overview

This project implements a **three-tier microservices architecture** that separates concerns across different layers and technologies, providing scalability, maintainability, and development flexibility.

### Architecture Diagram

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Presentation  │    │   Application   │    │      Data       │
│      Tier       │    │      Tier       │    │      Tier       │
├─────────────────┤    ├─────────────────┤    ├─────────────────┤
│                 │    │                 │    │                 │
│  React Frontend │◄──►│  User Service   │◄──►│    MongoDB      │
│   (Port 80)     │    │   (Python)      │    │  (Port 27017)   │
│                 │    │  (Port 5001)    │    │                 │
│                 │    │                 │    │   Collections:  │
│   Material-UI   │    ├─────────────────┤    │   - users       │
│   Components    │    │ Product Service │    │   - products    │
│                 │    │   (Node.js)     │    │                 │
│                 │    │  (Port 5002)    │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │
         └───────────────────────┘
              Nginx Proxy
             (Port 8080)
```

## 🚀 Features

- **Microservices Architecture**: Independent, scalable services
- **Multi-Technology Stack**: Python, Node.js, React, MongoDB
- **Containerized Deployment**: Docker containers for each service
- **API-First Design**: RESTful APIs for service communication
- **Database Persistence**: MongoDB with pre-configured data
- **Load Balancing**: Nginx reverse proxy configuration
- **Development Flexibility**: Each service can be developed independently

## 🛠️ Technology Stack

### Frontend (Presentation Tier)
- **React.js**: Modern JavaScript UI library
- **Material-UI**: Professional React component library
- **Emotion**: CSS-in-JS styling solution
- **Docker**: Containerized deployment

### Backend Services (Application Tier)
- **User Service**: Python-based microservice
  - Framework: Flask/FastAPI
  - Port: 5001
  - Endpoint: `/users`
  
- **Product Service**: Node.js-based microservice
  - Framework: Express.js
  - Port: 5002
  - Endpoint: `/products`

### Database (Data Tier)
- **MongoDB 4.0.4**: NoSQL document database
- **Collections**: Users and Products
- **Authentication**: Admin credentials configured

### Infrastructure
- **Docker**: Container orchestration
- **Nginx**: Reverse proxy and load balancer
- **Docker Networks**: Inter-service communication

## 📁 Project Structure

```
Three-tier-web-app-microservice/
├── frontend/                    # React frontend application
│   ├── src/
│   ├── package.json
│   ├── Dockerfile
│   └── ...
├── user-service/               # Python user microservice
│   ├── app.py
│   ├── requirements.txt
│   ├── Dockerfile
│   └── ...
├── product-service/            # Node.js product microservice
│   ├── server.js
│   ├── package.json
│   ├── Dockerfile
│   └── ...
├── nginx/                      # Nginx configuration
│   ├── nginx.conf
│   └── Dockerfile
├── mongo/                      # MongoDB data directory
├── docker-compose.yml          # Container orchestration
└── README.md                   # This file
```

## 📋 Prerequisites

Before running the application, ensure you have:

- **Docker**: v20.10+ installed and running
- **Docker Compose**: v2.0+ for orchestration
- **Node.js**: v16+ (for local development)
- **Python**: v3.8+ (for local development)
- **Git**: For cloning the repository

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/AnonyIIMessiah/Three-tier-web-app-microservice.git
cd Three-tier-web-app-microservice
```

### 2. Create Docker Network

```bash
docker network create myapp-network
```

### 3. Start MongoDB Database

```bash
docker run -d --rm --network myapp-network --name mongo \
  -p 27017:27017 \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=pass \
  -v ./mongo:/data/db mongo:4.0.4
```

### 4. Initialize Database with Sample Data

```bash
docker exec -it mongo mongo

# Inside MongoDB shell
use microservices_db

db.users.insertMany([
  { "id": 1, "name": "John Doe" }, 
  { "id": 2, "name": "Jane Smith" }
])

db.products.insertMany([
  { "id": 1, "name": "Laptop" }, 
  { "id": 2, "name": "Phone" }
])

exit
```

### 5. Build and Run Services

#### User Service (Python)
```bash
cd user-service
docker build -t user-service .
docker run -d --rm -p 5001:5001 --network myapp-network --name user-service user-service
```

#### Product Service (Node.js)
```bash
cd product-service
docker build -t product-service .
docker run -d --network myapp-network --rm --name product-service -p 5002:5002 product-service
```

#### Frontend (React)
```bash
cd frontend
docker build -t frontend .
docker run -d --rm -p 80:80 --network myapp-network --name frontend frontend
```

#### Nginx Proxy
```bash
cd nginx
docker build -t nginx .
docker run --rm -d --name nginx -p 8080:8080 --network myapp-network nginx
```

### 6. Access the Application

- **Frontend Application**: http://localhost:80
- **User Service API**: http://localhost:5001/users
- **Product Service API**: http://localhost:5002/products
- **Nginx Proxy**: http://localhost:8080

## 🧑‍💻 Development Setup

### Local Development (Without Docker)

#### User Service
```bash
cd user-service
python3 -m venv myenv
source myenv/bin/activate  # On Windows: myenv\Scripts\activate
pip install -r requirements.txt
python app.py
```

#### Product Service
```bash
cd product-service
npm install
node server.js
```

#### Frontend
```bash
cd frontend
npm install @mui/material @emotion/react @emotion/styled
npm start
```

## 🐳 Docker Hub Images

Pre-built images are available on Docker Hub:

```bash
# Pull pre-built images
docker pull demoniiexe/microservice-user
docker pull demoniiexe/microservice-product
docker pull demoniiexe/microservice-frontend

# Run with pre-built images
docker run -d --rm -p 5001:5001 --network myapp-network --name user-service demoniiexe/microservice-user
docker run -d --network myapp-network --rm --name product-service -p 5002:5002 demoniiexe/microservice-product
docker run -d --rm -p 80:80 --network myapp-network --name frontend demoniiexe/microservice-frontend
```

## 🔧 Configuration

### Environment Variables

#### MongoDB Configuration
- `MONGO_INITDB_ROOT_USERNAME`: Database admin username (default: admin)
- `MONGO_INITDB_ROOT_PASSWORD`: Database admin password (default: pass)

#### Service Ports
- Frontend: 80
- User Service: 5001
- Product Service: 5002
- Nginx: 8080
- MongoDB: 27017

### Service URLs
```bash
# Internal service communication (within Docker network)
USER_SERVICE_URL=http://user-service:5001
PRODUCT_SERVICE_URL=http://product-service:5002
MONGODB_URL=mongodb://admin:pass@mongo:27017/microservices_db
```

## 📊 API Documentation

### User Service Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/users` | Get all users |
| GET | `/users/:id` | Get user by ID |
| POST | `/users` | Create new user |
| DELETE | `/users/:id` | Delete user |

### Product Service Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/products` | Get all products |
| GET | `/products/:id` | Get product by ID |
| POST | `/products` | Create new product |
| DELETE | `/products/:id` | Delete product |

## 🧪 Testing

### Manual Testing

```bash
# Test User Service
curl http://localhost:5001/users

# Test Product Service
curl http://localhost:5002/products

# Test Frontend
curl http://localhost:80
```

### Health Checks

```bash
# Check service status
docker ps

# View service logs
docker logs user-service
docker logs product-service
docker logs frontend
docker logs nginx
```

## 🔄 Docker Compose (Alternative Deployment)

Create a `docker-compose.yml` file for easier orchestration:

```yaml
version: '3.8'
services:
  mongo:
    image: mongo:4.0.4
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: pass
    ports:
      - "27017:27017"
    volumes:
      - ./mongo:/data/db

  user-service:
    build: ./user-service
    ports:
      - "5001:5001"
    depends_on:
      - mongo

  product-service:
    build: ./product-service
    ports:
      - "5002:5002"
    depends_on:
      - mongo

  frontend:
    build: ./frontend
    ports:
      - "80:80"
    depends_on:
      - user-service
      - product-service

  nginx:
    build: ./nginx
    ports:
      - "8080:8080"
    depends_on:
      - frontend
```

Run with Docker Compose:
```bash
docker-compose up -d
```

## 🛑 Stopping Services

### Stop Individual Containers
```bash
docker stop mongo frontend user-service product-service nginx
```

### Stop All Services (Docker Compose)
```bash
docker-compose down
```

### Clean Up
```bash
# Remove containers
docker rm mongo frontend user-service product-service nginx

# Remove network
docker network rm myapp-network

# Remove images (optional)
docker rmi user-service product-service frontend nginx
```

## 🐛 Troubleshooting

### Common Issues

1. **Port Already in Use**
   ```bash
   # Find process using port
   lsof -i :5001
   # Kill process or use different port
   ```

2. **Docker Network Issues**
   ```bash
   # Recreate network
   docker network rm myapp-network
   docker network create myapp-network
   ```

3. **Database Connection Issues**
   ```bash
   # Check MongoDB logs
   docker logs mongo
   # Verify connection string in services
   ```

4. **Service Communication Issues**
   ```bash
   # Check if services are on same network
   docker network inspect myapp-network
   ```

### Debug Commands

```bash
# Check container status
docker ps -a

# View container logs
docker logs <container-name>

# Access container shell
docker exec -it <container-name> /bin/bash

# Check network connectivity
docker exec -it user-service ping product-service
```

## 🔒 Security Considerations

- **Database Authentication**: Change default MongoDB credentials
- **API Security**: Implement authentication and authorization
- **Network Security**: Use Docker secrets for sensitive data
- **Container Security**: Use specific image versions, not `latest`
- **HTTPS**: Configure SSL/TLS for production deployment

## 📈 Scaling and Performance

### Horizontal Scaling

```bash
# Scale individual services
docker run -d --rm -p 5003:5001 --network myapp-network --name user-service-2 user-service
docker run -d --rm -p 5004:5002 --network myapp-network --name product-service-2 product-service
```

### Load Balancing

Configure Nginx to distribute traffic across multiple service instances.

### Performance Monitoring

- Monitor container resource usage: `docker stats`
- Use logging and monitoring solutions (Prometheus, Grafana)
- Implement health checks and circuit breakers

## 🚀 Production Deployment

### Kubernetes Deployment

Consider using Kubernetes for production:
- Pod orchestration
- Service discovery
- Auto-scaling
- Rolling updates
- Health checks

### CI/CD Pipeline

Implement automated deployment:
- Build automation
- Testing integration
- Container registry
- Deployment automation

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test thoroughly across all services
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Guidelines

- Follow microservices best practices
- Maintain service independence
- Document API changes
- Test inter-service communication
- Update Docker configurations as needed

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [React](https://reactjs.org/) for the amazing frontend framework
- [Material-UI](https://mui.com/) for beautiful React components
- [Node.js](https://nodejs.org/) for the JavaScript runtime
- [Python](https://python.org/) for the versatile programming language
- [MongoDB](https://mongodb.com/) for the flexible database solution
- [Docker](https://docker.com/) for containerization platform
- [Nginx](https://nginx.org/) for the web server and proxy

---

**Happy Coding! 🚀✨**
