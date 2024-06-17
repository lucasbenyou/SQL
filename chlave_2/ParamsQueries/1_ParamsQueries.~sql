SELECT 
    o.Operation_ID, 
    o.Operation_Date, 
    o.Duration_Operation, 
    p.Patient_Name, 
    r.Room_ID
FROM 
    Operation o
JOIN 
    Patient p ON o.Patient_ID = p.Patient_ID
JOIN 
    Operating_Room r ON o.Room_ID = r.Room_ID
WHERE 
    o.Operation_Date BETWEEN TO_DATE(&<name="Start Date" hint="Enter the start date in format YYYY-MM-DD" type="string">, 'YYYY-MM-DD') 
    AND TO_DATE(&<name="End Date" hint="Enter the end date in format YYYY-MM-DD" type="string">, 'YYYY-MM-DD')
    AND o.Duration_Operation > &<name="Minimum Duration" hint="Enter the minimum duration in minutes" type="integer">
ORDER BY 
    o.Operation_Date DESC;
