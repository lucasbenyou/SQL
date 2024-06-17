ALTER TABLE Operation
ADD CONSTRAINT chk_duration_operation CHECK (Duration_Operation > 0),
ADD CONSTRAINT chk_operation_id CHECK (Operation_ID > 0);

-- Insert statement to test the constraint
INSERT INTO Operation (Operation_ID, Operation_Date, Duration_Operation, Patient_ID, Room_ID)
VALUES (1, TO_DATE('2024-04-27', 'YYYY-MM-DD'), 0, 1, 101);  -- This will fail due to Duration_Operation check constraint

-- Insert a valid record
INSERT INTO Operation (Operation_ID, Operation_Date, Duration_Operation, Patient_ID, Room_ID)
VALUES (6002, TO_DATE('2024-04-27', 'YYYY-MM-DD'), 5, 434, 1203);

-- Select statement to verify the insert
SELECT Operation_ID, Duration_Operation
FROM Operation
WHERE Operation_ID = 6002;
