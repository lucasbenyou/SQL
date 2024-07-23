------------------------- SQL script will add the necessary elements without modifying the existing configurations of the tables------------------------------------

ALTER TABLE Patient RENAME COLUMN Patient_ID TO PatientID;
ALTER TABLE Operating_Room RENAME COLUMN Room_ID TO RoomID;
ALTER TABLE Equipement RENAME COLUMN Room_ID TO RoomID;
ALTER TABLE Doctor RENAME COLUMN Doctor_ID TO DoctorID;
ALTER TABLE Operation RENAME COLUMN Patient_ID TO PatientID;
ALTER TABLE Operation RENAME COLUMN Room_ID TO RoomID;
ALTER TABLE Operate_by RENAME COLUMN Doctor_ID TO DoctorID;

-------------------------------------------------------------------------------
ALTER TABLE Patient
ADD DateOfBirth DATE,
ADD Phone INT,
ADD DepartmentID INT,
ADD RoomID INT;

ALTER TABLE Patient
ADD FOREIGN KEY (RoomID) REFERENCES Operating_Room(RoomID);

----------------Other Alter Table------------------------------

ALTER TABLE Operating_Room
ADD DepartmentID INT,
ADD Type VARCHAR(20);

-- Existing primary key and foreign key constraints do not need to be altered.

----------------Other Alter Table------------------------------

ALTER TABLE Doctor
ADD Phone INT,
ADD DepartmentID INT;

----------------Other Alter Table------------------------------

CREATE TABLE Medication
(
  MedicationID INT NOT NULL,
  Name VARCHAR(20) NOT NULL,
  Description VARCHAR(20) NOT NULL,
  ExpirationDate DATE NOT NULL,
  QuantityInStock INT NOT NULL,
  PRIMARY KEY (MedicationID)
);

----------------Other Alter Table------------------------------

CREATE TABLE Treatment
(
  TreatmentID INT NOT NULL,
  PatientID INT NOT NULL,
  DoctorID INT NOT NULL,
  MedicationID INT NOT NULL,
  TreatmentDate DATE NOT NULL,
  Description VARCHAR(20) NOT NULL,
  PRIMARY KEY (TreatmentID),
  FOREIGN KEY (PatientID) REFERENCES Patient(Patient_ID),
  FOREIGN KEY (DoctorID) REFERENCES Doctor(Doctor_ID),
  FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
);


----------------Other Alter Table------------------------------

CREATE TABLE TreatmentMedication
(
  MedicationID INT NOT NULL,
  TreatmentID INT NOT NULL,
  PRIMARY KEY (MedicationID, TreatmentID),
  FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID),
  FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID)
);


----------------Other Alter Table------------------------------

CREATE TABLE UnderThistreatment
(
  TreatmentID INT NOT NULL,
  PatientID INT NOT NULL,
  PRIMARY KEY (TreatmentID, PatientID),
  FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID),
  FOREIGN KEY (PatientID) REFERENCES Patient(Patient_ID)
);


----------------Other Alter Table------------------------------

CREATE TABLE Department
(
  DepartmentID INT NOT NULL,
  Name VARCHAR(20) NOT NULL,
  Location VARCHAR(20) NOT NULL,
  Phone INT NOT NULL,
  RoomID INT NOT NULL,
  DoctorID INT NOT NULL,
  PRIMARY KEY (DepartmentID),
  FOREIGN KEY (RoomID) REFERENCES Operating_Room(Room_ID),
  FOREIGN KEY (DoctorID) REFERENCES Doctor(Doctor_ID)
);


----------------Other Alter Table------------------------------

--ALTER TABLE Equipement RENAME TO Equipment;


-- Crée une table de travail pour stocker les patients à supprimer
CREATE TABLE patients_to_delete AS
SELECT p1.patientid AS id_to_delete, p2.patientid AS id_to_keep
FROM PATIENT p1
JOIN PATIENT p2 ON p1.patientid = p2.patientid
WHERE p1.phone IS NULL AND p2.phone IS NOT NULL;

-- Met à jour les valeurs de genre et illness pour les patients à garder
UPDATE PATIENT p
SET sexe = (
    SELECT p2.sexe
    FROM PATIENT p2
    WHERE p2.patientid = (
        SELECT id_to_delete
        FROM patients_to_delete
        WHERE id_to_keep = p.patientid
    )
),
illness = (
    SELECT p2.illness
    FROM PATIENT p2
    WHERE p2.patientid = (
        SELECT id_to_delete
        FROM patients_to_delete
        WHERE id_to_keep = p.patientid
    )
)
WHERE EXISTS (
    SELECT 1
    FROM patients_to_delete
    WHERE id_to_keep = p.patientid
);

-- Supprime les patients dont les valeurs ont été copiées
DELETE FROM PATIENT
WHERE patientid IN (
    SELECT id_to_delete
    FROM patients_to_delete
);

-- Supprime la table de travail
DROP TABLE patients_to_delete;


--- To update all roomid values ​​to 0 in a SQL table, you can use the following UPDATE command ---

UPDATE patient
SET roomid = 0;


--- Delete orphan records ---

DELETE FROM PATIENT
WHERE ROOMID IS NOT NULL
AND ROOMID NOT IN (SELECT ROOMID FROM operating_room);


--- To add DEPARTMENTID to doctor starting with 1 --- 

MERGE INTO doctor p
USING (
    SELECT ROWID, ROW_NUMBER() OVER (ORDER BY DEPARTMENTID) + 0 AS new_patientid
    FROM doctor
) u
ON (p.ROWID = u.ROWID)
WHEN MATCHED THEN
UPDATE SET p.DEPARTMENTID = u.new_patientid;


--- update all NULL entries in the Illness column with a random value from the predefined list ---


DECLARE
    TYPE IllnessList IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
    illnesses IllnessList;
BEGIN
    -- Initialiser la liste des illnesses
    illnesses(1) := 'appendicitis';
    illnesses(2) := 'gallstones';
    illnesses(3) := 'hernia';
    illnesses(4) := 'colon cancer';
    illnesses(5) := 'gastric cancer';
    illnesses(6) := 'esophageal cancer';
    illnesses(7) := 'pancreatic cancer';
    illnesses(8) := 'liver cancer';
    illnesses(9) := 'lung cancer';
    illnesses(10) := 'breast cancer';
    illnesses(11) := 'prostate cancer';
    illnesses(12) := 'ovarian cancer';
    illnesses(13) := 'cervical cancer';
    illnesses(14) := 'endometrial cancer';
    illnesses(15) := 'bladder cancer';
    illnesses(16) := 'kidney cancer';
    illnesses(17) := 'testicular cancer';
    illnesses(18) := 'melanoma';
    illnesses(19) := 'thyroid cancer';
    illnesses(20) := 'brain tumor';
    illnesses(21) := 'aortic aneurysm';
    illnesses(22) := 'coronary artery disease';
    illnesses(23) := 'heart valve disease';
    illnesses(24) := 'congenital heart defects';
    illnesses(25) := 'peripheral artery disease';
    illnesses(26) := 'deep vein thrombosis';
    illnesses(27) := 'pulmonary embolism';
    illnesses(28) := 'biliary atresia';
    illnesses(29) := 'cleft lip and palate';
    illnesses(30) := 'intestinal atresia';
    illnesses(31) := 'pyloric stenosis';
    illnesses(32) := 'inguinal hernia';
    illnesses(33) := 'colectomy';
    illnesses(34) := 'gastrectomy';
    illnesses(35) := 'nephrectomy';
    illnesses(36) := 'prostatectomy';
    illnesses(37) := 'mastectomy';
    illnesses(38) := 'hysterectomy';
    illnesses(39) := 'thyroidectomy';
    illnesses(40) := 'lumpectomy';
    illnesses(41) := 'cholecystectomy';
    illnesses(42) := 'splenectomy';
    illnesses(43) := 'adrenalectomy';
    illnesses(44) := 'lobectomy';
    illnesses(45) := 'pneumonectomy';
    illnesses(46) := 'craniotomy';
    illnesses(47) := 'laminectomy';
    illnesses(48) := 'spinal fusion';
    illnesses(49) := 'hip replacement';
    illnesses(50) := 'knee replacement';
    
    FOR rec IN (SELECT rowid FROM patient WHERE Illness IS NULL) LOOP
        UPDATE patient
        SET Illness = illnesses(TRUNC(DBMS_RANDOM.VALUE(1, 51)))
        WHERE rowid = rec.rowid;
    END LOOP;
END;


--- update all NULL entries in the DATEOFBIRTH column with a random date between January 1, 1950 and December 31, 2000 ---


DECLARE
    v_random_date DATE;
    v_start_date DATE := DATE '1950-01-01'; -- Date de début pour la génération aléatoire
    v_end_date DATE := DATE '2000-12-31';   -- Date de fin pour la génération aléatoire
BEGIN
    FOR rec IN (SELECT rowid FROM patient WHERE DATEOFBIRTH IS NULL) LOOP
        v_random_date := v_start_date + TRUNC(DBMS_RANDOM.VALUE(0, v_end_date - v_start_date));

        UPDATE patient
        SET DATEOFBIRTH = v_random_date
        WHERE rowid = rec.rowid;
    END LOOP;
END;


--- update all NULL entries in the PHONE column with a random 10 digit phone number ---


DECLARE
    v_random_phone VARCHAR2(15);
BEGIN
    FOR rec IN (SELECT rowid FROM patient WHERE PHONE IS NULL) LOOP
        -- Générer un numéro de téléphone aléatoire de 10 chiffres
        v_random_phone := TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1000000000, 9999999999)));

        UPDATE patient
        SET PHONE = v_random_phone
        WHERE rowid = rec.rowid;
    END LOOP;
END;


----  To update TREATMENT DATE so that it is between 1 and 4 weeks after OPERATION_DATE  ----


UPDATE TREATMENT t
SET t.TREATMENTDATE = o.OPERATION_DATE + INTERVAL '7' DAY + FLOOR(DBMS_RANDOM.VALUE(0, 22)) * INTERVAL '1' DAY
FROM PATIENT p
JOIN OPERATION o ON p.PATIENTID = o.PATIENTID
WHERE p.PATIENTID = t.PATIENTID
  AND t.TREATMENTDATE <= o.OPERATION_DATE;
