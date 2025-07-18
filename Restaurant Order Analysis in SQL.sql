USE restaurant_db;
/* Objective 1*/

-- 1. View the menu_items table.
select * from menu_items;

-- 2. Find the number of items on the menu.
select count(*)  from menu_items;

-- 3. What are the latest and most expensive items on the menu ?
select * from menu_items
ORDER BY price;
select * from menu_items
ORDER BY price DESC;

-- 4. how many Italian dishes are on the menu?
SELECT COUNT(*) FROM menu_items
WHERE category ='italian';

-- 5. what are the least and most expensive italian dishes on the menu?
SELECT * 
FROM menu_items
WHERE category ='italian'
ORDER BY price ;

SELECT * 
FROM menu_items
WHERE category ='italian'
ORDER BY price DESC;

-- 6. How many dishes are in each catogery?
SELECT category, COUNT(menu_item_id) AS num_dishes
FROM menu_items
GROUP BY category ;

-- 7. what is the average dish price within each catogary?
SELECT category, AVG(price) AS avg_price
FROM menu_items
GROUP BY category ;


/* Objective 2*/
-- 1. View the order details table.
SELECT * FROM order_details;

-- 2. what is the date range of the table?
SELECT MIN(order_date), MAX(order_date) FROM order_details;

-- 3. How many orders were made within this date range?
SELECT COUNT(DISTINCT order_id) FROM order_details;

-- 4. How many items were ordered within this date range ?
SELECT COUNT(*) FROM order_details;

-- 5. which order has the most number of items ?
SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- 6. How many orders had more than 12 items ?
SELECT COUNT(*) FROM

(SELECT order_id, COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders;

/* Objective 3*/
-- 1. Combine the menu_items and order_details tables into a single table.
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT * 
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items? what categories were they in ?
SELECT item_name,category, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, CATEGORY 
ORDER BY num_purchases ;

-- 3. What were the top 5 orders that spent the most money?
SELECT order_id, SUM(price) AS total_spend 
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
group by order_id
ORDER BY total_spend DESC
LIMIT 5;
    
-- 4. View the details of the highest spend order. What insights can you gather from the results?
SELECT category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id=440
GROUP BY category;

-- 5. View the details of the top 5 highest spend orders. What insights can you gather from the results?
SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075,1957,330,2675)
GROUP BY order_id, category;

'440', '192.15'
'2075', '191.05'
'1957', '190.10'
'330', '189.70'
'2675', '185.10'

