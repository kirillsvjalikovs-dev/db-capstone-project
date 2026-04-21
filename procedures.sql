DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(quantity) AS "Max Quantity in Order"
    FROM Orders;
END //

CREATE PROCEDURE CancelOrder(IN orderId INT)
BEGIN
    DELETE FROM Orders WHERE order_id = orderId;

    SELECT CONCAT('Order ', orderId, ' is cancelled') AS Confirmation;
END //

DELIMITER ;