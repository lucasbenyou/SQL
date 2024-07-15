CREATE OR REPLACE PROCEDURE RedirectOperationsAndStaff(
    RoomIDs IN SYS.ODCINUMBERLIST,
    EquipIDs IN SYS.ODCINUMBERLIST
) IS
    CURSOR PatientsInMaintenanceRooms IS
        SELECT Patient_ID, Room_ID
        FROM Operation
        WHERE Room_ID IN (SELECT COLUMN_VALUE FROM TABLE(RoomIDs));

    PatientID Operation.Patient_ID%TYPE;
    OldRoomID Operation.Room_ID%TYPE;
    NewRoomID Operation.Room_ID%TYPE;

    OldEquipRoomID Equipement.Room_ID%TYPE;
    NewEquipID Equipement.Equipement_ID%TYPE;
    EquipmentName Equipement.Equipment_Name%TYPE;
BEGIN
    -- Redirect patients
    OPEN PatientsInMaintenanceRooms;
    LOOP
        FETCH PatientsInMaintenanceRooms INTO PatientID, OldRoomID;
        EXIT WHEN PatientsInMaintenanceRooms%NOTFOUND;

        BEGIN
            -- Find a new available room
            SELECT Room_ID
            INTO NewRoomID
            FROM Operating_Room
            WHERE Availability = 'Yes'
            AND ROWNUM = 1;

            UPDATE Operation
            SET Room_ID = NewRoomID
            WHERE Patient_ID = PatientID AND Room_ID = OldRoomID;
            
            -- Update the status of the new room to 'No'
            UPDATE Operating_Room
            SET Availability = 'No'
            WHERE Room_ID = NewRoomID;

            -- Display the updated patient details
            DBMS_OUTPUT.PUT_LINE('Patient ID ' || PatientID || ' moved from Room ' || OldRoomID || ' to Room ' || NewRoomID);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No available room found for patient ' || PatientID);
        END;
    END LOOP;
    CLOSE PatientsInMaintenanceRooms;

    -- Redirect equipment
    FOR i IN 1 .. EquipIDs.COUNT LOOP
        SELECT Room_ID, Equipment_Name
        INTO OldEquipRoomID, EquipmentName
        FROM Equipement
        WHERE Equipement_ID = EquipIDs(i);

        BEGIN
            -- Find a new available equipment with the same name
            SELECT Equipement_ID
            INTO NewEquipID
            FROM Equipement
            WHERE Equipment_Name = EquipmentName
            AND Equipment_Status = 'available'
            AND ROWNUM = 1;

            UPDATE Equipement
            SET Equipment_Status = 'In Use', Room_ID = OldEquipRoomID
            WHERE Equipement_ID = NewEquipID;

            -- Display the updated equipment details
            DBMS_OUTPUT.PUT_LINE('Equipment ID ' || EquipIDs(i) || ' replaced by Equipment ID ' || NewEquipID || ' in Room ' || OldEquipRoomID);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No available replacement found for Equipment ID ' || EquipIDs(i));
        END;
    END LOOP;
END RedirectOperationsAndStaff;
/
