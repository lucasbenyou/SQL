CREATE OR REPLACE FUNCTION UpdateMaintenanceStatus(
    RoomIDs IN SYS.ODCINUMBERLIST,
    EquipIDs IN SYS.ODCINUMBERLIST
) RETURN BOOLEAN IS
BEGIN
    -- Update rooms to maintenance status
    FOR i IN 1 .. RoomIDs.COUNT LOOP
        UPDATE Operating_Room
        SET Availability = 'Maintenance'
        WHERE Room_ID = RoomIDs(i);
        
        -- Display the updated room ID
        DBMS_OUTPUT.PUT_LINE('Room ID ' || RoomIDs(i) || ' set to Maintenance');
    END LOOP;

    -- Update equipment to maintenance status
    FOR i IN 1 .. EquipIDs.COUNT LOOP
        UPDATE Equipement
        SET Equipment_Status = 'Maintenance'
        WHERE Equipement_ID = EquipIDs(i);

        -- Display the updated equipment ID
        DBMS_OUTPUT.PUT_LINE('Equipment ID ' || EquipIDs(i) || ' set to Maintenance');
    END LOOP;

    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Failed to update Update Maintenance Status: ' || SQLERRM);
        RETURN FALSE;
END UpdateMaintenanceStatus;
/
