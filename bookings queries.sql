-- notīra veco
DROP TABLE IF EXISTS Bookings;
DROP PROCEDURE IF EXISTS CheckBooking;
DROP PROCEDURE IF EXISTS AddValidBooking;

-- izveido tabulu (ar AUTO_INCREMENT!)
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    BookingDate DATE,
    TableNumber INT,
    CustomerID INT
);

-- ievieto datus
INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID)
VALUES 
(1, '2022-10-10', 5, 1),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1);

-- =========================
-- PROCEDURE 1: CheckBooking
-- =========================
DELIMITER //

CREATE PROCEDURE CheckBooking(
    IN booking_date DATE,
    IN table_number INT
)
BEGIN
    DECLARE booking_count INT;

    SELECT COUNT(*) INTO booking_count
    FROM Bookings
    WHERE BookingDate = booking_date
    AND TableNumber = table_number;

    IF booking_count > 0 THEN
        SELECT CONCAT('Table ', table_number, ' is already booked') AS Status;
    ELSE
        SELECT CONCAT('Table ', table_number, ' is available') AS Status;
    END IF;
END //

DELIMITER ;

-- tests
CALL CheckBooking('2022-11-12', 3);


-- =========================
-- PROCEDURE 2: AddValidBooking
-- =========================
DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN booking_date DATE,
    IN table_number INT
)
BEGIN
    DECLARE booking_count INT;

    START TRANSACTION;

    SELECT COUNT(*) INTO booking_count
    FROM Bookings
    WHERE BookingDate = booking_date
    AND TableNumber = table_number;

    IF booking_count > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', table_number, ' is already booked - booking cancelled') AS Status;
    ELSE
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID)
        VALUES (booking_date, table_number, 1);

        COMMIT;
        SELECT 'Booking successful' AS Status;
    END IF;
END //

DELIMITER ;

-- tests
CALL AddValidBooking('2022-11-12', 3); -- jābūt cancelled
CALL AddValidBooking('2022-12-01', 6); -- jābūt successful