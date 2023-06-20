DELIMITER //

CREATE PROCEDURE CancelBooking(booking_id INT)
BEGIN

DELETE FROM bookings WHERE BookingID = booking_id;

SELECT CONCAT('Booking ', booking_id, ' cancelled') AS 'Confirmation';

END //

DELIMITER ;
