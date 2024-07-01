CREATE OR REPLACE PROCEDURE RegisterDoctorAndNurse(
    p_doctor_id IN INT,
    p_nurse_id IN INT,
    p_operation_id IN INT
) IS
BEGIN
    -- Use an exception to handle potential errors
    IF p_doctor_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'Doctor ID cannot be NULL.');
    END IF;

    -- Use DML to insert data into the Operate_by table
    INSERT INTO Operate_by(Doctor_ID, Operation_ID)
    VALUES (p_doctor_id, p_operation_id);

    -- Use DML to insert data into the Assist_by table
    INSERT INTO Assist_by(Nurse_ID, Operation_ID)
    VALUES (p_nurse_id, p_operation_id);

    -- Display success message
    DBMS_OUTPUT.PUT_LINE('Doctor ' || p_doctor_id || ' and Nurse ' || p_nurse_id || ' successfully registered for Operation ' || p_operation_id);
    
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any other errors and display error message
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END RegisterDoctorAndNurse;
/
