CREATE OR REPLACE PROCEDURE MainProgram1(
    p_patient_id IN INT,
    p_operation_date IN DATE,
    p_room_id IN INT,
    p_doctor_id IN INT,
    p_nurse_id IN INT
) IS
    v_available BOOLEAN;
BEGIN
    v_available := CheckRoomAvailability(p_room_id);

    IF v_available THEN
        RegisterOperation(p_patient_id, p_operation_date, p_room_id, p_doctor_id, p_nurse_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Operation registration failed.');
    END IF;
END MainProgram1;
/
