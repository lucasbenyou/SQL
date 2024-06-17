UPDATE Operating_Room 
SET Availability = 'available'
WHERE Room_ID NOT IN (
    SELECT Room_ID 
    FROM Operation 
    WHERE Operation_Date > ADD_MONTHS(SYSDATE, -6)
);
