DELIMITER //

CREATE PROCEDURE CheckBooking(booking_date DATE, table_number INT)
BEGIN

SELECT CONCAT('Table ', table_number, ' is already booked') AS 'Booking status'
FROM bookings
WHERE BookingDate = booking_date 
AND TableNumber = table_number;

END //

DELIMITER ;
