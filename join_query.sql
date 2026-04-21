SELECT Customers.customer_id, Customers.name,
       Orders.order_id, Orders.total_cost
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id;