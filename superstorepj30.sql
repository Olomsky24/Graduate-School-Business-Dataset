SELECT*
FROM superstorepj30;


/* Write a query to retrieve all orders shipped to the state of "California" that used "Second Class" shipping mode. 
Include `Order ID`, `Customer Name`, `Sales`, and `Profit`. */

SELECT Order_ID, Customer_Name, Country, City, Ship_Mode, Sales, Profit
FROM superstorepj30
WHERE Country = 'United States'
AND City = 'Chicago'
AND Ship_Mode = 'Second Class';

SELECT  DISTINCT City
FROM superstorepj30
ORDER BY City ASC;

/* Find all orders placed between "2013-01-01" and "2013-12-31" where the `Category` is "Furniture" and the `Profit` is greater than 100. 
Display the `Order ID`, `Order Date`, `Product Name`, and `Profit`. */

SELECT Order_ID, Order_Date, Product_Name, Category, Profit
FROM superstorepj30
WHERE Order_Date BETWEEN '01-01-2013' AND '31-12-2013'
AND Category = 'Furniture'
AND Profit > 100;


/*Write a query to list all unique `Ship Modes` and the number of orders shipped through each mode, 
sorted in descending order of order count.*/

SELECT DISTINCT Ship_Mode, COUNT(Order_ID) AS number_of_orders
FROM superstorepj30
GROUP BY Ship_Mode;



/* Calculate the total `Sales` and `Profit` for each `Category` and `Sub-Category`. 
Display the results in descending order of total `Sales`. */

SELECT Category, Sub_Category, SUM(Sales) AS total_Sales, SUM(Profit) AS Total_Profit
FROM superstorepj30
GROUP BY Category, Sub_Category
ORDER BY total_Sales DESC;


/* Find the top 3 customers in terms of total `Sales` in each `Region`. 
Display `Customer Name`, `Region`, and `Total Sales`. */

SELECT Customer_Name, Region, SUM(Sales) AS total_Sales
FROM superstorepj30
GROUP BY Customer_Name, Region
ORDER BY Region DESC
LIMIT 3;


/* Write a query to determine which `City` has the highest average `Profit` per order, 
and display the top 5 cities with the highest average. */

SELECT City, AVG(Profit) / AVG(Quantity) AS Avg_Profit_per_Order
FROM superstorepj30
GROUP BY City
ORDER BY Avg_Profit_per_Order DESC
LIMIT 5;


/* Write a query to find the `Product Name` and `Category` of the most frequently 
ordered product (the one with the highest total `Quantity`). */

SELECT Product_Name, Category
FROM superstorepj30
GROUP BY Product_Name, Category
ORDER BY SUM(Quantity) DESC
LIMIT 1;


/* Use a subquery to find all orders where the `Sales` amount is greater
 than the average `Sales` for that specific `Category`. */
 
 SELECT Row_ID, Order_ID, Category, Sub_Category, Sales, Quantity
FROM superstorepj30
WHERE Sales > (
        SELECT AVG(Sales)
        FROM superstorepj30 AS sub
        WHERE sub.Category = superstorepj30.Category);


/* Write a query to find customers who have placed orders in both the "Corporate" and "Consumer" segments. 
Display their `Customer ID` and `Customer Name`. */

SELECT DISTINCT Customer_ID, Customer_Name
FROM superstorepj30
WHERE Segment IN ('Corporate', 'Consumer')
GROUP BY Customer_ID, Customer_Name
HAVING COUNT(DISTINCT Segment) = 2;


-- Update the `Ship Mode` of all orders shipped in "Kentucky" with a `Discount` of 0 to "Standard Class". --

UPDATE superstorepj30
SET Ship_Mode = 'Standard Class'
WHERE State = 'Kentucky'
AND Discount = 0;


-- Write a query to adjust the `Discount` to 0.3 for all products in the "Office Supplies" category that have a `Profit` less than zero. --

UPDATE superstorepj30
SET Discount = 0.3
WHERE Category = 'Office Supplies'
AND Profit < 0;


-- Write a query to increase the `Quantity` by 1 for all orders that have `Sales` greater than 500 but have a `Quantity` of 2 or less. --

UPDATE superstorepj30
SET Quantity = Quantity + 1
WHERE Sales > 500
AND Quantity <= 2;


/* Find orders where the `Profit` is negative, but the `Sales` amount is above the average `Sales` of all orders. 
Display `Order_ID`, `Customer_Name`, `Sales`, and `Profit`. */

SELECT Order_ID, Customer_Name, Sales, Profit
FROM superstorepj30
WHERE Profit < 0 AND Sales > (
	SELECT AVG(Sales) 
    FROM superstorepj30);
    
    
    /* Write a query to calculate the `Profit` margin (as `Profit/Sales`) for each `Product ID` 
    and find the top 5 products with the highest profit margin. */
    
SELECT Product_ID, (Profit / Sales) AS Profit_Margin
FROM superstorepj30
ORDER BY Profit_Margin DESC
LIMIT 5;


/* Write a query to find all `Order_ID` where the `Ship_Date` is more than 5 days after the `Order_Date`. 
Display `Order_ID`, `Order_Date`, `Ship_Date`, and the `days_difference`. */

SELECT Order_ID, Order_Date, Ship_Date, DATEDIFF(Ship_Date , Order_Date) AS days_difference
FROM superstorepj30
WHERE DATEDIFF(Ship_Date, Order_Date) > 5;


/* Write a query to find the total `Sales` and `Profit` contribution for each `Segment` by year. 
Display the results with `Year`, `Segment`, `Total Sales`, and `Total Profit`. */

SELECT YEAR(Order_Date) AS Year, Segment, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM superstorepj30
GROUP BY YEAR(Order_Date), Segment
ORDER BY YEAR(Order_Date), Segment;


/* Identify the `Sub_Category` with the most orders where `Discount` was applied. Display the `Sub_Category`, 
the total number of such orders, and the average `Discount` given in those cases. */

SELECT Sub_Category, COUNT(Order_ID) AS Total_Orders, AVG(Discount) AS Average_Discount
FROM superstorepj30
WHERE Discount > 0
GROUP BY Sub_Category
ORDER BY Total_Orders DESC
LIMIT 1;