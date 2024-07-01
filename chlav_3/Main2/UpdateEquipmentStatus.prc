CREATE OR REPLACE PROCEDURE UpdateEquipmentStatus(
    p_equipment_id IN INT,
    p_new_status IN VARCHAR
) IS
BEGIN
    UPDATE Equipement
    SET Equipment_Status = p_new_status
    WHERE Equipement_ID = p_equipment_id;

    DBMS_OUTPUT.PUT_LINE('Equipment ' || p_equipment_id || ' status updated to ' || p_new_status);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END UpdateEquipmentStatus;
/
