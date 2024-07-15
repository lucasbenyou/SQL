CREATE OR REPLACE FUNCTION ReassignPatient(
    p_Operation_ID IN Operation.Operation_ID%TYPE,
    p_Specialty IN Doctor.Specialty%TYPE,
    p_Operation_Date IN Operation.Operation_Date%TYPE
) RETURN BOOLEAN IS
    New_Room_ID Operating_Room.Room_ID%TYPE;
    New_Doctor_ID Doctor.Doctor_ID%TYPE;
BEGIN
    -- Find a new available room
    SELECT Room_ID
    INTO New_Room_ID
    FROM Operating_Room
    WHERE Availability = 'Yes'
    AND ROWNUM = 1;

    -- Find a new available doctor with the same specialty and available on the operation date
    SELECT Doctor_ID
    INTO New_Doctor_ID
    FROM Doctor d
    WHERE d.Specialty = p_Specialty
    AND NOT EXISTS (
        SELECT 1
        FROM Operate_by ob
        JOIN Operation o ON ob.Operation_ID = o.Operation_ID
        WHERE ob.Doctor_ID = d.Doctor_ID
        AND o.Operation_Date = p_Operation_Date
    )
    AND ROWNUM = 1;

    -- Update the operation with the new room and doctor
    UPDATE Operation
    SET Room_ID = New_Room_ID
    WHERE Operation_ID = p_Operation_ID;

    UPDATE Operate_by
    SET Doctor_ID = New_Doctor_ID
    WHERE Operation_ID = p_Operation_ID;

    -- Update the status of the new room to 'No'
    UPDATE Operating_Room
    SET Availability = 'No'
    WHERE Room_ID = New_Room_ID;

    -- Display the updated patient and operation details
    DBMS_OUTPUT.PUT_LINE('Operation ID ' || p_Operation_ID || ' re-assigned to Doctor ID ' || New_Doctor_ID || ' and Room ID ' || New_Room_ID);

    RETURN TRUE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No available room or doctor found for Operation ID ' || p_Operation_ID);
        RETURN FALSE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ReassignPatient: ' || SQLERRM);
        RETURN FALSE;
END ReassignPatient;
/
