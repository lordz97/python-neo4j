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