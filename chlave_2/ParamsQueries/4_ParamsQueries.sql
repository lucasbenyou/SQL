SELECT 
    e.Equipement_ID, 
    e.Equipment_Name, 
    e.Equipment_Purchase_Date, 
    r.Room_ID, 
    r.Max_number_people
FROM 
    Equipement e
JOIN 
    Operating_Room r ON e.Room_ID = r.Room_ID
WHERE 
    e.Equipment_Purchase_Date < TO_DATE(&<name="Purchase Date" hint="Enter the purchase date in format YYYY-MM-DD" type="string">, 'YYYY-MM-DD')
    AND r.Max_number_people >= &<name="Room Capacity" hint="Enter the minimum room capacity" type="integer">
ORDER BY 
    e.Equipment_Purchase_Date DESC;
