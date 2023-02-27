CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost
FROM Orders
WHERE Quantity > 2;
SELECT Customers.CustomerID, Customers.FullName, Orders.OrderID, Orders.Cost, Menus.MenuName, MenusItems.CourseName, MenusItems.StarterName 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN Menus ON Orders.OrderID = Menus.OrderID
INNER JOIN MenusItems ON Menus.MenuID = MenusItems.MenuID
WHERE Orders.Cost > 150
ORDER BY Orders.Cost;
SELECT MenuName 
FROM Menus 
WHERE MenuID IN (SELECT MenuID 
                  FROM Orders 
                  WHERE Quantity > 2 
                  GROUP BY MenuID 
                  HAVING ANY (Quantity > 2));
CREATE PROCEDURE max_order_quantity 
AS
BEGIN 
    SELECT MAX(Quantity)
    FROM Orders;
END;
CALL GetMaxQuantity();
SET @id = 1;
PREPARE GetOrderDetail FROM 
    SELECT OrderID, Quantity, Cost 
    FROM Orders 
    WHERE CustomerID = @id;

EXECUTE GetOrderDetail;
SET @id = 1;
EXECUTE GetOrderDetail USING @id;
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    DELETE FROM Orders WHERE OrderID = order_id;
END;