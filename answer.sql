-- ============================================================
-- Week 7 Assignment: Database Design and Normalization
-- ============================================================

-- ------------------------------------------------------------
-- Question 1: Achieving First Normal Form (1NF)
-- Problem: The Products column contains multiple comma-separated
--          values in a single cell, violating 1NF.
-- Solution: Create a table where each row holds only one 
--           atomic product per order, using (OrderID, Product)
--           as a composite primary key.
-- ------------------------------------------------------------

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100) NOT NULL,
    Product VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID, Product)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');


-- ------------------------------------------------------------
-- Question 2: Achieving Second Normal Form (2NF)
-- Problem: In OrderDetails, CustomerName depends only on 
--          OrderID (partial dependency) rather than the full 
--          composite key (OrderID, Product).
-- Solution: Split into two tables:
--           1. Orders (stores OrderID and CustomerName)
--           2. OrderItems (stores OrderID, Product, and Quantity)
-- ------------------------------------------------------------

-- Step 1: Create the Orders table (eliminates partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Step 2: Create the OrderItems table linked to Orders via Foreign Key
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert unique orders into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Step 4: Insert product quantities into the OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);
