SELECT 
    d.Doctor_ID, 
    d.Doctor_Name, 
    d.Specialty, 
    COUNT(ob.Operation_ID) AS NumberOfOperations
FROM 
    Doctor d
JOIN 
    Operate_by ob ON d.Doctor_ID = ob.Doctor_ID
WHERE 
    d.Specialty = '&<name="Specialty" list="select DISTINCT Specialty from Doctor order by Specialty">'
GROUP BY 
    d.Doctor_ID, d.Doctor_Name, d.Specialty
HAVING 
    COUNT(ob.Operation_ID) > &<name="Minimum Operations" hint="Enter the minimum number of operations" type="integer">
ORDER BY 
    NumberOfOperations DESC;
