PL/SQL Developer Test script 3.0
10
BEGIN
    BEGIN
        -- ID of the doctor to remove and reassign patients
        ReassignPatientsAndRemoveDoctor(2400);
        DBMS_OUTPUT.PUT_LINE('Test completed.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred.');
    END;
END;
0
0
