SELECT 
    EXTRACT(MONTH FROM o.Operation_Date) AS Operation_Month, 
    COUNT(o.Operation_ID) AS Total_Operations, 
    SUM(o.Duration_Operation) AS Total_Duration
FROM Operation o
WHERE EXTRACT(YEAR FROM o.Operation_Date) = 2024
GROUP BY EXTRACT(MONTH FROM o.Operation_Date)
ORDER BY Operation_Month;
