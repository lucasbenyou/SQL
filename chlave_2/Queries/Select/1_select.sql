SELECT 
    p.Patient_Name, 
    d.Doctor_Name, 
    o.Operation_Date, 
    o.Duration_Operation 
FROM Operation o
JOIN Patient p ON o.Patient_ID = p.Patient_ID
JOIN Operate_by ob ON o.Operation_ID = ob.Operation_ID
JOIN Doctor d ON ob.Doctor_ID = d.Doctor_ID
WHERE EXTRACT(YEAR FROM o.Operation_Date) = 2023
ORDER BY o.Operation_Date;
