-- CREATE DATABASE P1_RetailSales;

-- Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
	(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(15),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
	);

SELECT * FROM RETAIL_SALES LIMIT 10;

SELECT COUNT(*) FROM RETAIL_SALES;

SELECT * FROM retail_sales WHERE transactions_id IS NULL;
SELECT * FROM retail_sales WHERE sale_date IS NULL;

SELECT * FROM retail_sales 
WHERE 
	transactions_id IS NULL
	OR
	sale_time IS NULL 
	OR
	sale_date IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

DELETE FROM RETAIL_SALES  
WHERE 
	transactions_id IS NULL
	OR
	sale_time IS NULL 
	OR
	sale_date IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

SELECT COUNT(*) FROM RETAIL_SALES;

-- DATA EXPLORATIONS

-- Q1: How many SALES we have?
SELECT COUNT(*) AS "TOTAL_SALES" FROM RETAIL_SALES;  

-- Q2: How many UNIQUE CUSTOMER we have?
SELECT COUNT( DISTINCT customer_id) AS "Unique Customer" FROM RETAIL_SALES;

-- Q3: How many UNIQUE CATEGORY we have?
SELECT COUNT( DISTINCT category) AS "CATEGORY" FROM RETAIL_SALES;
SELECT DISTINCT(category) FROM RETAIL_SALES;

-- Q4: Who have high total sale Male or Female?
SELECT gender, MAX(total_sale)  FROM RETAIL_SALES WHERE gender IN ('Male' , 'Female') group by gender;

-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM RETAIL_SALES 
	WHERE sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT * FROM RETAIL_SALES 
	WHERE category = 'Clothing' AND quantiy > 3 AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'; 


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) AS "Total Sales", COUNT(*) AS "Total Order"
	FROM RETAIL_SALES GROUP BY category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT category, ROUND(AVG(age), 0) AS average_age FROM RETAIL_SALES
	WHERE category = 'Beauty' GROUP BY category;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM RETAIL_SALES WHERE total_sale > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(*) AS "Total transaction" FROM RETAIL_SALES 
GROUP BY category, gender ORDER BY 1;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
		sale_year,
		sale_month,
		avg_monthly_sale
FROM
(
SELECT
    EXTRACT(YEAR FROM sale_date) AS sale_year,
    EXTRACT(MONTH FROM sale_date) AS sale_month,
    AVG(total_sale) AS avg_monthly_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) AS RANK 
FROM RETAIL_SALES

GROUP BY 1, 2
) AS t1
	WHERE RANK = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT  
	customer_id, 
	SUM(total_sale) AS "Total_Sales" 
FROM RETAIL_SALES
	GROUP BY 1
	ORDER BY 2 DESC LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT COUNT(DISTINCT(customer_id)), category  
FROM RETAIL_SALES
GROUP BY category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
  CASE
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(transactions_id) AS number_of_orders
FROM RETAIL_SALES
GROUP BY shift;

SELECT * FROM RETAIL_SALES LIMIT 10;

-- End of Project --

