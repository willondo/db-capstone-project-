Use LittleLemonDB;
INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID, StaffID)
VALUES (1, '2022-10-10', 5, 1, 1), (2, '2022-11-12', 3, 3, 2), (3, '2022-10-11', 2, 2, 3), (4, '2022-10-13', 2, 1, 4);
CREATE PROCEDURE CheckBooking 
( 
  @BookingDate DATE, 
  @TableNumber INT
) 
AS 
BEGIN

  DECLARE @TableStatus VARCHAR(20);

  SELECT @TableStatus = CASE 
                         WHEN EXISTS(SELECT * FROM Bookings WHERE BookingDate = @BookingDate 
                                    AND TableNumber = @TableNumber) 
                           THEN 'Booked' 
                         ELSE 'Available' 
                       END;

  SELECT @TableStatus;

END;
CREATE PROCEDURE AddValidBooking 
( 
  @BookingDate DATE, 
  @TableNumber INT
) 
AS 
BEGIN

  DECLARE @TableStatus VARCHAR(20);

  START TRANSACTION

  SELECT @TableStatus = CASE 
                         WHEN EXISTS(SELECT * FROM Bookings WHERE BookingDate = @BookingDate 
                                    AND TableNumber = @TableNumber) 
                           THEN 'Booked' 
                         ELSE 'Available' 
                       END;

  IF (@TableStatus = 'Booked') 
  BEGIN
    ROLLBACK TRANSACTION
  END
  ELSE 
  BEGIN
    INSERT INTO Bookings (BookingDate, TableNumber) 
    VALUES (@BookingDate, @TableNumber);

    COMMIT TRANSACTION
  END

END;
CREATE PROCEDURE AddBooking 
( 
  @BookingID INT, 
  @CustomerID INT, 
  @BookingDate DATE, 
  @TableNumber INT 
) 
AS 
BEGIN

  INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber) 
  VALUES (@BookingID, @CustomerID, @BookingDate, @TableNumber);

END;
CREATE PROCEDURE UpdateBooking 
( 
  @BookingID INT, 
  @BookingDate DATE 
) 
AS 
BEGIN

  UPDATE Bookings 
  SET BookingDate = @BookingDate 
  WHERE BookingID = @BookingID;

END;

CREATE PROCEDURE CancelBooking 
( 
  @BookingID INT
) 
AS 
BEGIN

  DELETE FROM Bookings 
  WHERE BookingID = @BookingID;

END;