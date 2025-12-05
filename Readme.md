# Neo4j E-Commerce Analysis Tool 🛒

This repository demonstrates how to model an E-commerce dataset into a Graph Database (Neo4j) and interact with it using a Python GUI.

## 📂 Project Structure

- `import_data.cypher`: The Cypher scripts to create constraints and import the CSV datasets into Neo4j.
- `app.py`: A Python application using Tkinter and the Neo4j Driver to run queries on the database.
- `dataset/`: (Optional) Place your CSV files here.

## 🚀 Prerequisites

1. **Neo4j Desktop** installed and running.
2. **Python 3.x** installed.
3. The Neo4j Python driver. Install it via terminal:
   ```bash
   pip install neo4j

## 🛠️ How to Setup
1. Database Import
Create a new database in Neo4j (e.g., assignment3).

Place the 6 CSV files (users.csv, products.csv, etc.) into the import folder of your database.

Open Neo4j Browser and run the commands found in import_data.cypher block by block.

2. Running the Application
Open app.py.

Update the AUTH variable with your database password:
AUTH = ("neo4j", "your_super_password")

3. Run the script via your terminal/command prompt:
python app.py

##📊 Features
- Graph Modeling: Converts relational CSV tables into Nodes (:User, :Product, :Order) and Relationships.

- Data Analysis: Includes a pre-loaded query to find loyal customers who bought the same product in multiple orders.

- GUI: A user-friendly interface to test arbitrary Cypher queries and view results in JSON format.

- Recommendation Engine: (Code included) Logic to suggest products based on collaborative filtering.

👤 Author

Harisson Zeufack - TU Clausthal



