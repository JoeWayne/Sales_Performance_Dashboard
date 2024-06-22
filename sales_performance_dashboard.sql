
-- Creating Customers table with additional columns for a more unique structure
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(50),
    Country VARCHAR(50),
    RegistrationDate DATE DEFAULT CURRENT_DATE
);

-- Creating Products table with an added Supplier column
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Supplier VARCHAR(100),
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT DEFAULT 0
);

-- Creating SalesReps table with added HireDate column
CREATE TABLE SalesReps (
    SalesRepID INT PRIMARY KEY AUTO_INCREMENT,
    SalesRepName VARCHAR(100) NOT NULL,
    Region VARCHAR(50),
    HireDate DATE DEFAULT CURRENT_DATE
);

-- Creating Sales table with a more detailed structure
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    SaleDate DATE DEFAULT CURRENT_DATE,
    CustomerID INT,
    ProductID INT,
    SalesRepID INT,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Discount DECIMAL(5, 2) DEFAULT 0.00,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SalesRepID) REFERENCES SalesReps(SalesRepID)
);

-- Inserting sample data with more diversity
INSERT INTO Customers (CustomerName, ContactNumber, Email, Address, City, Country)
VALUES
('John Doe', '123-456-7890', 'john.doe@example.com', '123 Maple St', 'New York', 'USA'),
('Jane Smith', '234-567-8901', 'jane.smith@example.com', '456 Oak St', 'Los Angeles', 'USA');

INSERT INTO Products (ProductName, Category, Supplier, Price, StockQuantity)
VALUES
('Laptop', 'Electronics', 'Tech Corp', 999.99, 50),
('Smartphone', 'Electronics', 'Mobile Inc', 499.99, 100);

INSERT INTO SalesReps (SalesRepName, Region)
VALUES
('Alice Johnson', 'North America'),
('Bob Brown', 'Europe');

INSERT INTO Sales (CustomerID, ProductID, SalesRepID, Quantity, Discount, TotalAmount)
VALUES
(1, 1, 1, 1, 0, 999.99),
(2, 2, 2, 2, 10, 899.98);

-- Query to get total sales by product with added stock information
SELECT ProductName, Category, Supplier, SUM(Quantity) AS TotalQuantitySold, SUM(TotalAmount) AS TotalSalesAmount, StockQuantity
FROM Sales
JOIN Products ON Sales.ProductID = Products.ProductID
GROUP BY ProductName, Category, Supplier, StockQuantity;

-- Query to get sales performance by sales representative with added hire date
SELECT SalesRepName, Region, HireDate, SUM(TotalAmount) AS TotalSalesAmount
FROM Sales
JOIN SalesReps ON Sales.SalesRepID = SalesReps.SalesRepID
GROUP BY SalesRepName, Region, HireDate;

-- Query to get monthly sales trends with more detailed breakdown
SELECT DATE_FORMAT(SaleDate, '%Y-%m') AS Month, COUNT(SaleID) AS NumberOfSales, SUM(TotalAmount) AS TotalSalesAmount
FROM Sales
GROUP BY Month
ORDER BY Month;

-- Create view for total sales by product with additional information
CREATE VIEW TotalSalesByProduct AS
SELECT ProductName, Category, Supplier, SUM(Quantity) AS TotalQuantitySold, SUM(TotalAmount) AS TotalSalesAmount, StockQuantity
FROM Sales
JOIN Products ON Sales.ProductID = Products.ProductID
GROUP BY ProductName, Category, Supplier, StockQuantity;

-- Stored procedure to get sales performance by a specific sales representative with additional details
CREATE PROCEDURE GetSalesPerformanceByRep(IN salesRepID INT)
BEGIN
    SELECT SalesRepName, Region, HireDate, SUM(TotalAmount) AS TotalSalesAmount
    FROM Sales
    JOIN SalesReps ON Sales.SalesRepID = SalesReps.SalesRepID
    WHERE Sales.SalesRepID = salesRepID
    GROUP BY SalesRepName, Region, HireDate;
END;
