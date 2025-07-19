
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address TEXT
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10,2),
    Stock INT,
    Category VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    Method VARCHAR(20),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Customers (Name, Email, Phone, Address) VALUES
('John Doe', 'john@example.com', '9876543210', 'Delhi'),
('Jane Smith', 'jane@example.com', '8765432109', 'Mumbai');

INSERT INTO Products (ProductName, Description, Price, Stock, Category) VALUES
('Laptop', '15-inch screen laptop', 60000.00, 10, 'Electronics'),
('Phone', '5G smartphone', 30000.00, 25, 'Electronics');

SELECT o.OrderID, c.Name, o.OrderDate, o.Status
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

SELECT p.ProductName, SUM(od.Quantity) AS TotalSold
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC;

SELECT SUM(Amount) AS TotalRevenue FROM Payments;

SELECT ProductName, Stock FROM Products WHERE Stock < 5;

CREATE VIEW OrderSummary AS
SELECT o.OrderID, c.Name AS CustomerName, o.OrderDate, SUM(od.TotalPrice) AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, c.Name, o.OrderDate;

WITH OrderValues AS (
    SELECT OrderID, SUM(TotalPrice) AS OrderTotal
    FROM OrderDetails
    GROUP BY OrderID
)
SELECT AVG(OrderTotal) AS AverageOrderValue FROM OrderValues;
