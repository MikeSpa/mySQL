DELIMITER //

CREATE PROCEDURE AddBooking(booking_date DATE, table_number INT, staff_id INT)
BEGIN

INSERT INTO bookings (BookingDate,TableNumber, StaffID)
VALUES(booking_date, table_number, staff_id);

SELECT 'New booking added' AS 'Confirmation';

END //

DELIMITER ;
