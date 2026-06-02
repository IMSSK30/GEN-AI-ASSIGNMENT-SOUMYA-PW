-- Copilot with SQL

-- Instruction : Use GitHub Copilot in SSMS to solve the following questions.


-- Question 1 : Use Github Copilot to create a table SalesData whose columns are
-- CustomerID, Name, Age, City, PurchaseAmount, PurchaseDate
-- and then ask to insert 10,000 rows of random data.

CREATE TABLE SalesData (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    City VARCHAR(100),
    PurchaseAmount DECIMAL(10,2),
    PurchaseDate DATE
);

-- Insert 10,000 random rows

DECLARE @Counter INT = 1;

WHILE @Counter <= 10000
BEGIN
    INSERT INTO SalesData (
        CustomerID,
        Name,
        Age,
        City,
        PurchaseAmount,
        PurchaseDate
    )
    VALUES (
        @Counter,
        'Customer' + CAST(@Counter AS VARCHAR),
        FLOOR(RAND() * 43) + 18,
        CHOOSE(
            FLOOR(RAND() * 5) + 1,
            'Delhi',
            'Mumbai',
            'Kolkata',
            'Chennai',
            'Bangalore'
        ),
        ROUND((RAND() * 5000) + 100, 2),
        DATEADD(DAY, -FLOOR(RAND() * 365), GETDATE())
    );

    SET @Counter = @Counter + 1;
END;


-- Question 2 : Use Copilot to:
-- Find total sales per city

SELECT
    City,
    SUM(PurchaseAmount) AS TotalSales
FROM SalesData
GROUP BY City;


-- Top 5 cities by revenue

SELECT TOP 5
    City,
    SUM(PurchaseAmount) AS TotalRevenue
FROM SalesData
GROUP BY City
ORDER BY TotalRevenue DESC;


-- Question 3 : Ask Copilot:
-- Find customers with purchases above average

SELECT
    CustomerID,
    Name,
    City,
    PurchaseAmount
FROM SalesData
WHERE PurchaseAmount >
(
    SELECT AVG(PurchaseAmount)
    FROM SalesData
);
