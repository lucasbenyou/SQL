DELETE FROM Operation 
WHERE Room_ID IN (
    SELECT Room_ID 
    FROM Operating_Room 
    WHERE Max_number_people < 5
) AND Duration_Operation > 240;
