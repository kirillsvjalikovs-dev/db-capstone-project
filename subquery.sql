SELECT name
FROM Menu
WHERE menu_id IN (
    SELECT menu_id
    FROM Orders
    WHERE quantity > 2
);