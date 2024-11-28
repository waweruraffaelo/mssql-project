USE walmartSales;
GO

SELECT * FROM SalesData;


---- Feature engineering-----------------------------------------

---time of day

SELECT 
    [time],
    CASE 
        WHEN [time] BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN [time] BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM SalesData;


ALTER TABLE SalesData
ADD time_of_day VARCHAR(20);

SELECT * FROM SalesData;

UPDATE SalesData
SET time_of_day = CASE 
    WHEN [time] BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
    WHEN [time] BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
END;



---Add Day name


SELECT 
    [date],
    DATENAME(MONTH, [date]) AS day_name
FROM SalesData;


ALTER TABLE SalesData
ADD day_name VARCHAR(20);

UPDATE SalesData
Set day_name = DATENAME(WEEKDAY, [date]) 


ALTER TABLE SalesData
ADD month_name VARCHAR(20);

UPDATE SalesData
Set month_name = DATENAME(MONTH, [date])






----------------------------------------------

----------------------------------------------------
-- How many enique cities

SELECT DISTINCT City
FROM SalesData;




SELECT DISTINCT branch
FROM SalesData;


SELECT 
DISTINCT City,
branch
FROM SalesData;


-----Product--------------

SELECT DISTINCT Product_line
FROM SalesData;


------Payment method

SELECT  
payment,
COUNT(Payment) as payment_method
FROM SalesData
GROUP BY Payment
ORDER BY payment DESC


----Most selling product


SELECT  
    Product_line,
    COUNT(Product_line) as Product
FROM SalesData
GROUP BY Product_line
ORDER BY Product_line DESC


----Total revenue by month-----

SELECT
 month_name As Month,
 SUM(Total) AS total_revenue
FROM SalesData
GROUP By month_name
ORDER BY total_revenue DESC

---What month had the larges COGS

SELECT
 month_name As Month,
 SUM(cogs) AS cogs_total
FROM SalesData
GROUP By month_name
ORDER BY cogs_total DESC

----What product line has the largest revenue

SELECT
 Product_line ,
 ROUND(SUM(Total),2) AS Revenue
FROM SalesData
GROUP By Product_line
ORDER BY Revenue DESC


----What is the city with the largest revenue
SELECT
 City ,
 branch,
 ROUND(SUM(Total),2) AS Revenue
FROM SalesData
GROUP By City,Branch
ORDER BY Revenue DESC

----What product line had the largest VAT

SELECT
 Product_line ,
 ROUND(AVG(Tax_5),2) AS Avg_tax
FROM SalesData
GROUP By Product_line
ORDER BY Avg_tax DESC

-----Which branch sold more products than average product sold?

SELECT
Branch,
SUM(Quantity) AS gqy
FROM SalesData
GROUP By Branch
HAVING SUM(Quantity)>
(SELECT AVG(Quantity) FROM SalesData)


---Common product line by gender

SELECT
 Gender,
 Product_line,
 COUNT(Gender) AS Total_gender
FROM SalesData
GROUP By Gender,Product_line
ORDER BY Total_gender DESC


----What is average rating of each product line?

SELECT
    ROUND(AVG(Rating),3) AS Avg_Rating,
    Product_line    
FROM SalesData
GROUP BY Product_line
ORDER BY Avg_Rating DESC



-----SALES


--Number of sales made in each time of the day per  weekday

SELECT
time_of_day,
day_name,
count(*) OVER(PARTITION BY day_name,time_of_day) As Total_sales
FROM salesData
ORDER BY Total_sales DESC


SELECT * FROM SalesData
-----Which customer make most revenue

SELECT 
    Customer_type,
    SUM(Total) As Revenue
 FROM SalesData
 GROUP BY Customer_type
 ORDER BY Revenue DESC;

--  which city has the largest VAT

SELECT 
City,
AVG(Tax_5) AS VAT
 FROM SalesData
 GROUP BY City
 ORDER BY VAT DESC

 ----Customers with most VAT
 SELECT 
    Customer_type,
    AVG(Tax_5) AS VAT
 FROM SalesData
 GROUP BY Customer_type
 ORDER BY VAT DESC


 --------------------------------

--------------CUSTOMER INFORMATION

---How many unique customer types

SELECT DISTINCT
    Customer_type,
    COUNT(Customer_type) AS Customers
FROM SalesData
GROUP BY Customer_type
ORDER BY Customers DESC
 
 -----Unique Payment Method

 SELECT DISTINCT
    Payment,
    COUNT(Payment) AS payment_method
FROM SalesData
GROUP BY Payment
ORDER BY payment_method DESC


-- Which customer types buys the most

SELECT DISTINCT
    Customer_type,
    COUNT(*) AS Customers
FROM SalesData
GROUP BY Customer_type
ORDER BY Customers DESC



-- what is the gender of the most customer

SELECT DISTINCT
    Customer_type,
    Gender,
    COUNT(*) AS Customers
FROM SalesData
GROUP BY Customer_type,Gender
ORDER BY Customers DESC

-- gender distribution of each branch

SELECT DISTINCT
    Branch,
    Gender,
    COUNT(*)   AS Customers
FROM SalesData
GROUP BY Branch,Gender
ORDER BY Customers DESC

-- which time of the day customer gives most rating

SELECT DISTINCT
    time_of_day,
    ROUND(AVG(Rating),2) Avg_Rating
FROM SalesData
GROUP BY time_of_day
ORDER BY Avg_Rating DESC

-- which time of the day customer gives most rating per branch

SELECT DISTINCT
    time_of_day,
    Branch,
    ROUND(AVG(Rating),2) Avg_Rating
FROM SalesData
GROUP BY time_of_day,Branch
ORDER BY 2,1 DESC

-- which day of the week has the best avarage rating
SELECT DISTINCT
    day_name,
    ROUND(AVG(Rating),2) Avg_Rating
FROM SalesData
GROUP BY day_name
ORDER BY Avg_Rating DESC

-- day of the week with the best avarage rating per branch

SELECT DISTINCT
    day_name,
    Branch,
    ROUND(AVG(Rating),2) Avg_Rating
FROM SalesData
GROUP BY day_name,Branch
ORDER BY 2,3 DESC

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
WITH CTE_Sales_Avg AS (
    SELECT 
        Product_line,
        ROUND(Total, 2) AS Total,
        ROUND(AVG(Total) OVER (PARTITION BY Product_line), 2) AS Avg_Sales
    FROM SalesData
)
SELECT 
    Product_line,
    Total,
    Avg_Sales,
    CASE 
        WHEN Total > Avg_Sales THEN 'GOOD'
        ELSE 'BAD'
    END AS Performance
FROM CTE_Sales_Avg
ORDER BY Product_line, Total ;

-- Revenue And Profit Calculations
-- $ COGS = unitsPrice * quantity $

-- $ VAT = 5% * COGS $
-- VAT
--  is added to the 
-- COGS
--  and this is what is billed to the customer.
-- $ total(gross_sales) = VAT + COGS $
-- $ grossProfit(grossIncome) = total(gross_sales) - COGS $
-- Gross Margin is gross profit expressed in percentage of the total(gross profit/revenue)
-- $ \text{Gross Margin} = \frac{\text{gross income}}{\text{total revenue}} $

SELECT * FROM SalesData



SELECT 
    Product_line,
    ROUND(SUM(cogs), 2) AS COG,
    ROUND(SUM(Quantity * unit_price), 2) AS Revenue,
    ROUND(SUM(0.05 * cogs), 2) AS VAT,
    ROUND(SUM(Tax_5), 2) AS VAT_TAX,
    ROUND(SUM((cogs + Tax_5) - cogs), 2) AS Profit,  -- This represents the VAT (gross profit)
    ROUND(SUM(cogs + Tax_5), 2) AS gross_sales,
    ROUND(SUM((cogs + Tax_5) - cogs), 2) AS grossProfit, -- Same as Profit, equal to VAT
    ROUND((SUM(cogs + Tax_5) - SUM(cogs)) / SUM(cogs + Tax_5) * 100, 2) AS gross_margin  -- Gross Margin Calculation
FROM salesData 
GROUP BY Product_line
ORDER BY Revenue DESC;

