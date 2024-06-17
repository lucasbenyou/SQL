SELECT 
    p.Patient_Name, 
    p.Illness, 
    o.Operation_ID, 
    o.Operation_Date, 
    r.Max_number_people
FROM Patient p
JOIN Operation o ON p.Patient_ID = o.Patient_ID
JOIN Operating_Room r ON o.Room_ID = r.Room_ID
WHERE r.Max_number_people > 10;
