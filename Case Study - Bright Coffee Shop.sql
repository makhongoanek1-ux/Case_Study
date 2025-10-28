--EXPLORATORY DATA ANALYSIS
--Show the full table

SELECT *
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP;

--------------------------------------------------------------
--Show the number of stores

SELECT DISTINCT Store_location
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP;

--------------------------------------------------------------
--Show the product categories

SELECT DISTINCT Product_Category
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP; 

--------------------------------------------------------------
--Show the product types

SELECT DISTINCT Product_type
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP; 

--------------------------------------------------------------
--Show the opening hour

SELECT MIN(Transaction_time) AS Opening_hour
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP;

--------------------------------------------------------------
--Determine the closing hour

SELECT MAX(Transaction_time) AS Opening_hour
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP;

--------------------------------------------------------------

--Query for the main table

SELECT
Transaction_date,
    DAYNAME(Transaction_date) AS Day_name,
    CASE 
        WHEN DAYNAME(Transaction_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS Day_classification,
    MONTHNAME(Transaction_date) AS Month_name,
    CASE 
        WHEN Transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN Transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
        WHEN Transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
        WHEN Transaction_time >= '20:00:00' THEN 'Night'
    END AS Time_bucket,
    HOUR(Transaction_time) AS Hour_of_day,
    Store_Location,
    Product_Category,
    Product_Detail,
    Product_Type,
    COUNT(DISTINCT Transaction_qty) AS Number_of_sales,
    SUM(Transaction_qty * Unit_Price) AS Revenue
FROM CASE_STUDY.BRIGHT.COFFEE_SHOP
GROUP BY 
    Transaction_date,
    DAYNAME(Transaction_date),
    CASE 
        WHEN DAYNAME(Transaction_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END,
    MONTHNAME(Transaction_date),
    CASE 
        WHEN Transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN Transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
        WHEN Transaction_time BETWEEN '17:00:00' AND '23:59:59' THEN 'Evening'
        ELSE 'Other'
    END,
    HOUR(Transaction_time),
    Store_Location,
    Product_Category,
    Product_Detail,
    Product_Type;
