
# Sales Performance Dashboard

This project aims to create a Sales Performance Dashboard using SQL. The dashboard provides insights into sales performance, customer trends, and product popularity, enabling data-driven decision-making. 

## Project Overview
The Sales Performance Dashboard project involves designing a database schema, writing SQL queries to extract relevant sales data, and using a visualization tool to create an interactive dashboard.

## Components

### 1. Database Design
Design a database schema to store sales data and populate it with sample data.

### 2. SQL Queries
Write SQL queries to extract key metrics and insights. Create views and stored procedures for reusable queries.

### 3. Data Visualization
Use a data visualization tool (e.g., Power BI, Tableau) to create an interactive dashboard.

## Database Schema

The database schema consists of four main tables: Customers, Products, SalesReps, and Sales.

### Customers Table
Stores customer information including name, contact details, and address.

### Products Table
Stores product information including name, category, supplier, price, and stock quantity.

### SalesReps Table
Stores sales representative information including name, region, and hire date.

### Sales Table
Stores sales transactions including date, customer ID, product ID, sales rep ID, quantity, discount, and total amount.

## SQL Queries

### Total Sales by Product
Query to get total sales by product with added stock information.

```sql
SELECT ProductName, Category, Supplier, SUM(Quantity) AS TotalQuantitySold, SUM(TotalAmount) AS TotalSalesAmount, StockQuantity
FROM Sales
JOIN Products ON Sales.ProductID = Products.ProductID
GROUP BY ProductName, Category, Supplier, StockQuantity;
```

### Sales Performance by Sales Representative
Query to get sales performance by sales representative with added hire date.

```sql
SELECT SalesRepName, Region, HireDate, SUM(TotalAmount) AS TotalSalesAmount
FROM Sales
JOIN SalesReps ON Sales.SalesRepID = SalesReps.SalesRepID
GROUP BY SalesRepName, Region, HireDate;
```

### Monthly Sales Trends
Query to get monthly sales trends with more detailed breakdown.

```sql
SELECT DATE_FORMAT(SaleDate, '%Y-%m') AS Month, COUNT(SaleID) AS NumberOfSales, SUM(TotalAmount) AS TotalSalesAmount
FROM Sales
GROUP BY Month
ORDER BY Month;
```

### Create View
Create view for total sales by product with additional information.

```sql
CREATE VIEW TotalSalesByProduct AS
SELECT ProductName, Category, Supplier, SUM(Quantity) AS TotalQuantitySold, SUM(TotalAmount) AS TotalSalesAmount, StockQuantity
FROM Sales
JOIN Products ON Sales.ProductID = Products.ProductID
GROUP BY ProductName, Category, Supplier, StockQuantity;
```

### Stored Procedure
Stored procedure to get sales performance by a specific sales representative with additional details.

```sql
CREATE PROCEDURE GetSalesPerformanceByRep(IN salesRepID INT)
BEGIN
    SELECT SalesRepName, Region, HireDate, SUM(TotalAmount) AS TotalSalesAmount
    FROM Sales
    JOIN SalesReps ON Sales.SalesRepID = SalesReps.SalesRepID
    WHERE Sales.SalesRepID = salesRepID
    GROUP BY SalesRepName, Region, HireDate;
END;
```

## How to Use

1. **Set up the database**: Run the SQL scripts to create the tables and insert sample data.
2. **Execute queries**: Use the provided SQL queries to extract data and gain insights.
3. **Create the dashboard**: Use a data visualization tool to create an interactive dashboard using the extracted data.

## Tools and Technologies

- **SQL**: For database design and queries.
- **Database Management System**: MySQL, PostgreSQL, or any other SQL database.
- **Data Visualization Tool**: Power BI, Tableau, or any other visualization tool.