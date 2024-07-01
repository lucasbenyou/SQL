CREATE OR REPLACE PROCEDURE RegisterOperation(
    p_patient_id IN INT,
    p_operation_date IN DATE,
    p_room_id IN INT,
    p_doctor_id IN INT,
    p_nurse_id IN INT
) IS
    v_operation_id INT := 6465; -- Initialize the OPERATION_ID starting point
    
BEGIN
    -- Find the next available OPERATION_ID
    SELECT MAX(Operation_ID) + 1 INTO v_operation_id FROM Operation;

    -- Use exception handling to manage missing data errors
    BEGIN
        -- Use DML to insert the operation
        INSERT INTO Operation(Operation_ID, Operation_Date, Duration_Operation, Patient_ID, Room_ID)
        VALUES (v_operation_id, p_operation_date, 3, p_patient_id, p_room_id);

        -- Use a procedure to register the doctor and nurse responsible
        RegisterDoctorAndNurse(p_doctor_id, p_nurse_id, v_operation_id);

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Operation successfully registered for Patient ' || p_patient_id || ' on ' || TO_CHAR(p_operation_date, 'YYYY-MM-DD HH24:MI:SS'));
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found error.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            ROLLBACK;
    END;
END RegisterOperation;
/
