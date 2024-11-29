# WALMART SALES DATA ANALYSIS

**Sales Table** 

```SQL

CREATE DATABASE [walmartSales]
GO

CREATE TABLE [dbo].[SalesData](
	[Invoice_ID] [nvarchar](50) NOT NULL,
	[Branch] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[Customer_type] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[Product_line] [nvarchar](50) NOT NULL,
	[Unit_price] [float] NOT NULL,
	[Quantity] [tinyint] NOT NULL,
	[Tax_5] [float] NOT NULL,
	[Total] [float] NOT NULL,
	[Date] [date] NOT NULL,
	[Time] [time](7) NOT NULL,
	[Payment] [nvarchar](50) NOT NULL,
	[cogs] [float] NOT NULL,
	[gross_margin_percentage] [float] NOT NULL,
	[gross_income] [float] NOT NULL,
	[Rating] [float] NOT NULL,
	[time_of_day] [varchar](20) NULL,
	[day_name] [varchar](20) NULL,
	[month_name] [varchar](20) NULL,
 CONSTRAINT [PK_SalesData] PRIMARY KEY CLUSTERED 
) 
```

---
## ABOUT
This project aim at exporing Walmart sales to get insights on branch,cities,customer and products effects on sales performance.The aim is to learn 
how sales can be affected by different players in the market.The data was downloaded from [kaggle](https://github.com/waweruraffaelo/mssql-project/blob/main/WalmartSalesData.csv)
and imported to MSSQL server.

## Analysis checklist
1. Product.
1. Sales.
1. Customer.

## Approach used
1. **Data cleaning**. This is the firststep to check for any redudancy and detecting NULLs and empty data.
	1. Create database and import csv file.
	1. Select columns and partition by each row to check for duplicated.There are no duplicates and NULL values in the data.

### 1. Product Analysis.
1. How many unique product lines does the data have?
1. What is the most common payment method?
1. What is the most selling product line?
1. What is the total revenue by month?
1. What month had the largest COGS?
1. What product line had the largest revenue?
1. What is the city with the largest revenue?
1. What product line had the largest VAT?
1. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
1. Which branch sold more products than average product sold?
1. What is the most common product line by gender?
1. What is the average rating of each product line?

## 2. Sales Analysis

1. Number of sales made in each time of the day per weekday
1. Which of the customer types brings the most revenue?
1. Which city has the largest tax percent/ VAT (Value Added Tax)?
1. Which customer type pays the most in VAT?

## 3. Customer Analysis
1. How many unique customer types does the data have?
1. How many unique payment methods does the data have?
1. What is the most common customer type?
1. Which customer type buys the most?
1. What is the gender of most of the customers?
1. What is the gender distribution per branch?
1. Which time of the day do customers give most ratings?
1. Which time of the day do customers give most ratings per branch?
1. Which day fo the week has the best avg ratings?
1. Which day of the week has the best average ratings per branch

## CODE 
[SQL_FILE](https://github.com/waweruraffaelo/mssql-project/blob/main/sales.sql)