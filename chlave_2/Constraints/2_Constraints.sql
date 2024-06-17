ALTER TABLE Doctor
ADD CONSTRAINT uniq_doctor_name UNIQUE (Doctor_Name);

-- Insert statement to test the constraint
INSERT INTO Doctor (Doctor_ID, Doctor_Name, Specialty)
VALUES (2410, 'Hauer  Anna', 'Cardiology');

-- Attempt to insert a duplicate doctor name, which should fail
INSERT INTO Doctor (Doctor_ID, Doctor_Name, Specialty)
VALUES (2410, 'Hauer  Anna', 'Neurosurgery');  -- This will fail due to the UNIQUE constraint

-- Select statement to verify the unique constraint
SELECT Doctor_Name
FROM Doctor;
