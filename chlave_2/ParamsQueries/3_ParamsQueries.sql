SELECT 
    n.Nurse_ID, 
    n.Nurse_Name, 
    n.Telephone_number, 
    COUNT(ab.Operation_ID) AS NumberOfOperations
FROM 
    Nurse n
JOIN 
    Assist_by ab ON n.Nurse_ID = ab.Nurse_ID
JOIN 
    Operation o ON ab.Operation_ID = o.Operation_ID
WHERE 
    EXTRACT(YEAR FROM o.Operation_Date) = &<name="Year" hint="Enter the year" type="integer">
GROUP BY 
    n.Nurse_ID, n.Nurse_Name, n.Telephone_number
HAVING 
    COUNT(ab.Operation_ID) > &<name="Minimum Operations" hint="Enter the minimum number of operations" type="integer">
ORDER BY 
    NumberOfOperations DESC;
