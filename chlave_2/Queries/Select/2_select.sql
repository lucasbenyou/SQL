SELECT 
    d.Doctor_Name, 
    d.Specialty, 
    AVG(o.Duration_Operation) AS Average_Operation_Duration
FROM Doctor d
JOIN Operate_by ob ON d.Doctor_ID = ob.Doctor_ID
JOIN Operation o ON ob.Operation_ID = o.Operation_ID
WHERE EXTRACT(YEAR FROM o.Operation_Date) = 2023 
  AND EXTRACT(MONTH FROM o.Operation_Date) = 6
GROUP BY d.Doctor_Name, d.Specialty;
