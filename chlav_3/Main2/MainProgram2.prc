BEGIN
    -- ID of the doctor to remove and reassign patients
    ReassignPatientsAndRemoveDoctor(2400);

    DBMS_OUTPUT.PUT_LINE('Test completed.');
END;
/
