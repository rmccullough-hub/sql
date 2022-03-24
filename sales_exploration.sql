/*

Sales data exploration 

*/

-- create a table
CREATE TABLE sales (
  invoice_id INTEGER PRIMARY KEY,
  product TEXT NOT NULL,
  category TEXT NOT NULL,
  unit_cost FLOAT NOT NULL, 
  unit_price FLOAT NOT NULL,
  quantity INTEGER NOT NULL,
  date_sold DATE NOT NULL,
  date_shipped DATE,  
  state TEXT
);



-- revenue
 SELECT SUM(unit_price*quantity)
 FROM sales;

-- profit
SELECT SUM(unit_price*quantity) - SUM(unit_cost*quantity)
 FROM sales;

-- profit margin
SELECT CAST((SUM((unit_price*quantity)) - SUM(unit_cost*quantity)) / SUM(unit_price*quantity) * 100 AS int)
FROM sales;

-- most popular product
SELECT product
FROM sales
GROUP BY product
ORDER BY SUM(quantity) DESC
LIMIT 1;






-- least popular product
SELECT product
FROM sales
GROUP BY product
ORDER BY SUM(quantity)
LIMIT 1;

-- average fulfillment time 
SELECT DATEDIFF(date_shipped, date_sold) 
FROM sales
WHERE date_shipped IS NOT NULL
AND date_sold IS NOT NULL;

-- unfulfilled orders
SELECT * FROM sales WHERE date_shipped is NULL; 

-- sales by month
SELECT SUM(quantity)
FROM sales
GROUP BY strftime('%m', date_sold)
ORDER BY SUM(quantity) DESC;

-- state with most orders
SELECT state
FROM sales
GROUP BY state
ORDER BY SUM(quantity) DESC
LIMIT 1;

-- state with least orders
SELECT state
FROM sales
GROUP BY state
ORDER BY SUM(quantity) 
LIMIT 1;
