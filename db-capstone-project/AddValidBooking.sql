DELIMITER //

CREATE PROCEDURE AddValidBooking(booking_date DATE, table_number INT, staff_id INT)
BEGIN

START TRANSACTION;

SELECT 1 AS 'status' 
FROM bookings 
WHERE BookingDate = booking_date
AND TableNumber = table_number
LIMIT 1
INTO @booking_status;

IF @booking_status = 1 THEN

ROLLBACK;
SELECT CONCAT('Table ', table_number, ' is already booked - cancelled') AS 'Booking status';

ELSE

INSERT INTO bookings (BookingDate, TableNumber, StaffID) VALUES 
(booking_date, table_number, staff_id);
COMMIT;

SELECT CONCAT('Table ', table_number, ' has been booked successfully') AS 'Booking status';

END IF;
END //

DELIMITER ;
