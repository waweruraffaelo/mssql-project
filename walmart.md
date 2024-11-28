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
This project aim at exporing 

