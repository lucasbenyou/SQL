UPDATE Equipement 
SET Equipment_Status = 'maintenance'
WHERE Room_ID = 1415 
  AND Equipment_Purchase_Date < TO_DATE('2024-08-09', 'YYYY-MM-DD');
