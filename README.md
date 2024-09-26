```
PUC-Rio
Especialização em Desenvolvimento Fullstack
Disciplina: Desenvolvimento Back-end Avançado

Aluno: Rodrigo Alves Costa
```

## Market Master: Product Management Service

The `mm-product` service is part of the Market Master project, a suite of microservices designed to manage various aspects of a supermarket e-commerce platform. This service handles product and category management, including CRUD operations for products and categories.

### Related Market Master Microservices:
- [mm-inventory](https://github.com/MarketMasterPlus/mm-inventory) — Inventory (available items) Management
- [mm-store](https://github.com/MarketMasterPlus/mm-store) — Store Management
- [mm-address](https://github.com/MarketMasterPlus/mm-address) — Address Management with ViaCEP API integration
- [mm-customer](https://github.com/MarketMasterPlus/mm-customer) — Customer/User Management
- [mm-shopping-cart](https://github.com/MarketMasterPlus/mm-shopping-cart) — Shopping Cart Management
- [mm-pact-broker](https://github.com/MarketMasterPlus/mm-pact-broker) — Pact Broker for Contract tests
- [mm-ui](https://github.com/MarketMasterPlus/mm-ui) — User Interface for Market Master

---

## Quick Start

### Prerequisites
- **Docker** and **Docker Compose** are required to run this service.

### Steps to Run the Service
1. Clone the repository:  
   git clone https://github.com/MarketMasterPlus/mm-product

2. Navigate to the project directory:  
   cd mm-product

3. Start the services with Docker Compose:  
   docker-compose up -d

4. Access the Product Management API at:  
   http://localhost:5704/

---

## Project Description

The `mm-product` service is responsible for managing product and category data, including CRUD operations for both entities. It enables the registration of new products, updating existing products, and associating them with specific categories.

### Key Features
- **Product Management**: Allows users to manage products, including name, description, category, and pricing.
- **Category Management**: Enables the management of product categories.
- **Integration with Other Services**: The service integrates with the inventory system to manage product availability across stores.

---

## Docker Setup

The `docker-compose.yml` file configures the `mm-product` service and a PostgreSQL database for data storage.

### Docker Compose Configuration:

version: '3.8'

services:
  db:
    image: postgres:latest
    container_name: mm-product-db
    environment:
      POSTGRES_DB: postgres
      POSTGRES_USER: marketmaster
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./db/mm-product.sql:/docker-entrypoint-initdb.d/mm-product.sql
    ports:
      - 5435:5432
    networks:
      - marketmaster-network

  product_service:
    build: .
    container_name: mm-product
    ports:
      - 5704:5704
    depends_on:
      - db
    environment:
      FLASK_APP: app.py
      FLASK_ENV: development
    volumes:
      - .:/app
    networks:
      - marketmaster-network

volumes:
  postgres_data:

networks:
  marketmaster-network:
    external: true

To start the service using Docker, run:

docker-compose up -d

---

## API Endpoints

### Product Management:
- **GET /mm-product/**  
  Retrieves a list of all products or allows filtering by attributes such as product name, category, description, and brand.  
  Example:  
  curl http://localhost:5704/mm-product/?name=productname

- **POST /mm-product/**  
  Allows users to create a new product record in the system.  
  Example:  
  curl -X POST http://localhost:5704/mm-product/ -d '{"name": "Product Name", "description": "Product Description", "categoryid": 1, "suggestedprice": 100.50}'

- **GET /mm-product/{id}**  
  Retrieves detailed information for a product by its unique identifier.  
  Example:  
  curl http://localhost:5704/mm-product/1

- **PUT /mm-product/{id}**  
  Updates a product by its unique identifier.  
  Example:  
  curl -X PUT http://localhost:5704/mm-product/1 -d '{"name": "Updated Product Name"}'

- **DELETE /mm-product/{id}**  
  Deletes a product by its unique identifier.  
  Example:  
  curl -X DELETE http://localhost:5704/mm-product/1

### Category Management:
- **GET /category/**  
  Retrieves a list of all categories or allows filtering by a query string.  
  Example:  
  curl http://localhost:5704/category/?q=electronics

- **POST /category/**  
  Allows users to create a new category in the system.  
  Example:  
  curl -X POST http://localhost:5704/category/ -d '{"name": "New Category"}'

- **GET /category/{id}**  
  Retrieves detailed information for a category by its unique identifier.  
  Example:  
  curl http://localhost:5704/category/1

- **PUT /category/{id}**  
  Updates a category by its unique identifier.  
  Example:  
  curl -X PUT http://localhost:5704/category/1 -d '{"name": "Updated Category"}'

- **DELETE /category/{id}**  
  Deletes a category by its unique identifier.  
  Example:  
  curl -X DELETE http://localhost:5704/category/1

---

## Swagger Documentation

The `mm-product` service comes with built-in **Swagger** documentation, which allows for easy interaction with the API.

### Accessing Swagger UI

Once the service is running, the **Swagger UI** is accessible at:

http://localhost:5704/swagger/

The Swagger UI provides a user-friendly interface to explore and test the API endpoints directly from your browser.

### How to Use Swagger UI

1. Navigate to the **Swagger UI** link mentioned above.
2. Explore the various API endpoints by clicking on them.
3. Try out the endpoints by providing the required parameters and executing the requests directly from the UI.

Swagger makes it easy to document and interact with the API, ensuring that developers and users can quickly test and understand the system.

---

## Running the Flask Application Locally

If you prefer to run the service without Docker, follow the steps below.

### Step 1: Install Dependencies

Make sure you have Python 3 and `pip` installed. Then, install the required dependencies:

pip install -r requirements.txt

### Step 2: Configure Environment Variables

Create a `.env` file in the root of the project with the following content:

FLASK_APP=app.py  
FLASK_ENV=development  
DATABASE_URL=postgresql://marketmaster:password@localhost:5435/postgres

### Step 3: Run the Application

With the environment variables set, you can run the Flask application:

flask run

By default, the service will be accessible at `http://localhost:5704`.

---

## Additional Information

This microservice is part of the Market Master system, providing product and category management features that are essential for supermarket operations. It is closely integrated with other services in the system, such as the `mm-inventory` and `mm-store` services.

For more details about the Market Master project and to explore other microservices, visit the respective repositories:

- [mm-inventory](https://github.com/MarketMasterPlus/mm-inventory)
- [mm-store](https://github.com/MarketMasterPlus/mm-store)
- [mm-shopping-cart](https://github.com/MarketMasterPlus/mm-shopping-cart)
- [mm-address](https://github.com/MarketMasterPlus/mm-address)
- [mm-customer](https://github.com/MarketMasterPlus/mm-customer)
- [mm-pact-broker](https://github.com/MarketMasterPlus/mm-pact-broker)
- [mm-ui](https://github.com/MarketMasterPlus/mm-ui)

For any further questions, feel free to open an issue on GitHub or consult the provided documentation within each repository.
