CREATE OR REPLACE PROCEDURE ReassignPatientsAndRemoveDoctor(
    p_Doctor_ID IN Doctor.Doctor_ID%TYPE
) IS
    TYPE PatientRec IS RECORD (
        Patient_ID Patient.Patient_ID%TYPE,
        Operation_ID Operation.Operation_ID%TYPE,
        Operation_Date Operation.Operation_Date%TYPE,
        Old_Room_ID Operation.Room_ID%TYPE,
        Specialty Doctor.Specialty%TYPE
    );

    CURSOR PatientCursor IS
        SELECT o.Patient_ID, o.Operation_ID, o.Operation_Date, o.Room_ID, d.Specialty
        FROM Operation o
        JOIN Operate_by ob ON o.Operation_ID = ob.Operation_ID
        JOIN Doctor d ON ob.Doctor_ID = d.Doctor_ID
        WHERE ob.Doctor_ID = p_Doctor_ID;

    PatientRecord PatientRec;
    Success BOOLEAN;
BEGIN
    OPEN PatientCursor;
    LOOP
        FETCH PatientCursor INTO PatientRecord;
        EXIT WHEN PatientCursor%NOTFOUND;

        -- Call function to reassign patient
        Success := ReassignPatient(
            p_Operation_ID => PatientRecord.Operation_ID,
            p_Specialty => PatientRecord.Specialty,
            p_Operation_Date => PatientRecord.Operation_Date
        );

        IF Success THEN
            DBMS_OUTPUT.PUT_LINE('Patient ID ' || PatientRecord.Patient_ID || ' re-assigned successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Failed to re-assign Patient ID ' || PatientRecord.Patient_ID);
        END IF;
    END LOOP;
    CLOSE PatientCursor;

    -- Delete the doctor from the list of doctors
    DELETE FROM Doctor
    WHERE Doctor_ID = p_Doctor_ID;

    DBMS_OUTPUT.PUT_LINE('Doctor ID ' || p_Doctor_ID || ' has been removed from the list of doctors.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in ReassignPatientsAndRemoveDoctor: ' || SQLERRM);
END ReassignPatientsAndRemoveDoctor;
/
