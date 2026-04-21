PREPARE GetOrderDetail FROM
'SELECT order_id, quantity, total_cost
 FROM Orders
 WHERE customer_id = ?';

SET @id = 1;

EXECUTE GetOrderDetail USING @id;