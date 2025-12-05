// 1. Constraints
CREATE CONSTRAINT FOR (u:User) REQUIRE u.user_id IS UNIQUE;
CREATE CONSTRAINT FOR (p:Product) REQUIRE p.product_id IS UNIQUE;
CREATE CONSTRAINT FOR (o:Order) REQUIRE o.order_id IS UNIQUE;
CREATE CONSTRAINT FOR (i:Order_Item) REQUIRE i.item_id IS UNIQUE;
CREATE CONSTRAINT FOR (r:Review) REQUIRE r.review_id IS UNIQUE;
CREATE CONSTRAINT FOR (e:Event) REQUIRE e.event_id IS UNIQUE;

// 2. Import Users
LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
MERGE (u:User {user_id: row.user_id})
SET u.name = row.name, u.email = row.email, u.gender = row.gender, u.city = row.city, u.signup_date = date(row.signup_date);

// 3. Import Products
LOAD CSV WITH HEADERS FROM 'file:///products.csv' AS row
MERGE (p:Product {product_id: row.product_id})
SET p.name = row.product_name, p.category = row.category, p.brand = row.brand, p.price = toFloat(row.price), p.rating = toFloat(row.rating);

// 4. Import Orders
LOAD CSV WITH HEADERS FROM 'file:///orders.csv' AS row
MERGE (o:Order {order_id: row.order_id})
SET o.date = datetime(row.order_date), o.status = row.order_status, o.total_amount = toFloat(row.total_amount)
WITH o, row
MATCH (u:User {user_id: row.user_id})
MERGE (u)-[:PLACES]->(o);

// 5. Import Order Items (With CORRECTED relationship direction)
LOAD CSV WITH HEADERS FROM 'file:///order_items.csv' AS row
MERGE (item:Order_Item {item_id: row.order_item_id})
SET item.quantity = toInteger(row.quantity), item.price = toFloat(row.item_price), item.total = toFloat(row.item_total)
WITH item, row
MATCH (o:Order {order_id: row.order_id})
MATCH (p:Product {product_id: row.product_id})
MERGE (o)-[:HAS]->(item)
MERGE (p)-[:INCLUDED_IN]->(item);

// 6. Import Reviews
LOAD CSV WITH HEADERS FROM 'file:///reviews.csv' AS row
MERGE (r:Review {review_id: row.review_id})
SET r.rating = toInteger(row.rating), r.text = row.review_text, r.date = datetime(row.review_date)
WITH r, row
MATCH (u:User {user_id: row.user_id})
MATCH (p:Product {product_id: row.product_id})
MATCH (o:Order {order_id: row.order_id})
MERGE (u)-[:WRITES]->(r)
MERGE (r)-[:ABOUT]->(p)
MERGE (r)-[:LINKED_TO]->(o);

// 7. Import Events
LOAD CSV WITH HEADERS FROM 'file:///events.csv' AS row
MERGE (e:Event {event_id: row.event_id})
SET e.type = row.event_type, e.timestamp = datetime(row.event_timestamp)
WITH e, row
MATCH (u:User {user_id: row.user_id})
MATCH (p:Product {product_id: row.product_id})
MERGE (u)-[:GENERATES]->(e)
MERGE (e)-[:RELATED_TO]->(p);