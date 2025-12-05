import tkinter as tk
from tkinter import scrolledtext
import json
from neo4j import GraphDatabase

# Configuration - Update with your credentials if needed
URI = "neo4j://localhost:7687"
AUTH = ("neo4j", "your_password") 
DB_NAME = "assignment3"

class CypherGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Neo4j E-Commerce Query Tool")
        self.root.geometry("700x600")

        # Label
        tk.Label(root, text="Enter Cypher Query:", font=("Arial", 12, "bold")).pack(pady=10)
        
        # Input Field
        self.query_entry = tk.Entry(root, width=80, font=("Consolas", 10))
        self.query_entry.pack(pady=5)
        
        # Placeholder / Default Query (Task 2e)
        self.default_query = """MATCH (u:User)-[:PLACES]->(o:Order)-[:HAS]->(item:Order_Item)<-[:INCLUDED_IN]-(p:Product)
WITH u, p, count(DISTINCT o) AS order_count
WHERE order_count >= 2
RETURN u.name, p.name, order_count
ORDER BY order_count DESC"""
        
        self.query_entry.insert(0, self.default_query)

        # Button
        self.submit_btn = tk.Button(root, text="Run Query", command=self.run_query, bg="#4CAF50", fg="white", font=("Arial", 10, "bold"))
        self.submit_btn.pack(pady=10)

        # Results Area
        tk.Label(root, text="JSON Results:", font=("Arial", 12, "bold")).pack(pady=5)
        self.result_area = scrolledtext.ScrolledText(root, width=80, height=25, font=("Consolas", 9))
        self.result_area.pack(pady=5)

    def run_query(self):
        query = self.query_entry.get()
        self.result_area.delete(1.0, tk.END)
        
        try:
            with GraphDatabase.driver(URI, auth=AUTH) as driver:
                with driver.session(database=DB_NAME) as session:
                    result = session.run(query)
                    keys = result.keys()
                    data = [record.values() for record in result]
                    response = {"columns": keys, "data": data}
                    formatted_json = json.dumps(response, indent=4, default=str)
                    self.result_area.insert(tk.INSERT, formatted_json)
        except Exception as e:
            self.result_area.insert(tk.INSERT, f"Error: {str(e)}")

if __name__ == "__main__":
    root = tk.Tk()
    app = CypherGUI(root)
    root.mainloop()