---  This query allows you to display the equipment used in a department and in which room it is used. (for example we keep the departement “55”).   ---

CREATE OR REPLACE VIEW EquipmentInDepartment AS
SELECT e.EQUIPEMENT_ID, e.EQUIPMENT_NAME, oroom.DEPARTMENTID, oroom.ROOMID
FROM EQUIPEMENT e
JOIN OPERATING_ROOM oroom ON e.ROOMID = oroom.ROOMID
WHERE oroom.DEPARTMENTID = 55;

-- View equipment used in a specific department
SELECT EQUIPEMENT_ID, EQUIPMENT_NAME, DEPARTMENTID, ROOMID
FROM EquipmentInDepartment;


---  This query allows you to find all the patients for whom you have had an operation but not yet received treatment.   ---

CREATE OR REPLACE VIEW PatientsWithoutTreatment AS
SELECT o.OPERATION_ID, o.PATIENTID
FROM OPERATION o
LEFT JOIN TREATMENT t ON o.PATIENTID = t.PATIENTID
WHERE t.PATIENTID IS NULL;

-- Find all patients without treatment
SELECT OPERATION_ID, PATIENTID
FROM PatientsWithoutTreatment;

---  This query returns patients for whom the TREATMENTS DATE is before or equal to OPERATION_DATE.   ---

CREATE OR REPLACE VIEW TreatmentsBeforeOrEqualOperation AS
SELECT o.PATIENTID,
       o.OPERATION_DATE,
       t.TREATMENTDATE
FROM PATIENT p
JOIN OPERATION o ON p.PATIENTID = o.PATIENTID
JOIN TREATMENT t ON p.PATIENTID = t.PATIENTID
WHERE t.TREATMENTDATE <= o.OPERATION_DATE;

-- Return patients with a treatment date before or equal to the operation date
SELECT PATIENTID, OPERATION_DATE, TREATMENTDATE
FROM TreatmentsBeforeOrEqualOperation;

---  Returns the name, patientid, doctor.name and the description of all the patients who received treatment that was given by the doctor.Name which contains the word "Eli"   ---

CREATE OR REPLACE VIEW PatientsTreatedByDoctorEli AS
SELECT p.PATIENTID, p.NAME AS PATIENT_NAME, d.NAME AS DOCTOR_NAME, m.DESCRIPTION
FROM PATIENT p
JOIN TREATMENT t ON p.PATIENTID = t.PATIENTID
JOIN DOCTOR d ON t.DOCTORID = d.DOCTORID
JOIN MEDICATION_TREATMENT mt ON t.TREATMENTID = mt.TREATMENTID
JOIN MEDICATION m ON mt.MEDICATIONID = m.MEDICATIONID
WHERE d.NAME LIKE '%Eli%';

-- Return patients treated by a doctor whose name contains "Eli"
SELECT PATIENTID, PATIENT_NAME, DOCTOR_NAME, DESCRIPTION
FROM PatientsTreatedByDoctorEli;
