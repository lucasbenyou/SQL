DELETE FROM Equipement 
WHERE Equipement_ID NOT IN (
    SELECT DISTINCT e.Equipement_ID
    FROM Equipement e
    JOIN Operating_Room r ON e.Room_ID = r.Room_ID
    JOIN Operation o ON r.Room_ID = o.Room_ID
) AND Equipment_Status = 'not available';
