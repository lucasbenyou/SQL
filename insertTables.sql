-- Insert data into Operating_Room
INSERT INTO Operating_Room (Room_ID, Availability, Max_number_people) VALUES
(1, 'Available', 5),
(2, 'Occupied', 6),
(3, 'Available', 4),
(4, 'Occupied', 7),
(5, 'Available', 3),
(6, 'Available', 6),
(7, 'Occupied', 5),
(8, 'Available', 8),
(9, 'Occupied', 4),
(10, 'Available', 2);


-- Insert data into Patient
INSERT INTO Patient (Patient_ID, Patient_Name, Sexe, Illness) VALUES
(101, 'John Doe', 'Male', 'Flu'),
(102, 'Jane Smith', 'Female', 'Appendicitis'),
(103, 'Alice Johnson', 'Female', 'Migraine'),
(104, 'Bob Brown', 'Male', 'Fracture'),
(105, 'Carol White', 'Female', 'Pneumonia'),
(106, 'David Green', 'Male', 'Diabetes'),
(107, 'Eve Black', 'Female', 'Hypertension'),
(108, 'Frank Blue', 'Male', 'Asthma'),
(109, 'Grace Pink', 'Female', 'Anemia'),
(110, 'Hank Gray', 'Male', 'Cancer');

-- Insert data into Doctor
INSERT INTO Doctor (Doctor_ID, Doctor_Name, Specialty) VALUES
(201, 'Dr. House', 'Diagnostics'),
(202, 'Dr. Watson', 'Surgery'),
(203, 'Dr. Strange', 'Neurology'),
(204, 'Dr. Brown', 'Pediatrics'),
(205, 'Dr. Green', 'Cardiology'),
(206, 'Dr. White', 'Orthopedics'),
(207, 'Dr. Black', 'Dermatology'),
(208, 'Dr. Blue', 'Gastroenterology'),
(209, 'Dr. Pink', 'Psychiatry'),
(210, 'Dr. Gray', 'Endocrinology');

-- Insert data into Nurse
INSERT INTO Nurse (Nurse_ID, Nurse_Name, Telephone_number) VALUES
(301, 'Nancy Adams', 1234567890),
(302, 'Olivia Brown', 2345678901),
(303, 'Pamela Clark', 3456789012),
(304, 'Quinn Davis', 4567890123),
(305, 'Rachel Evans', 5678901234),
(306, 'Susan Foster', 6789012345),
(307, 'Tracy Green', 7890123456),
(308, 'Uma Harris', 8901234567),
(309, 'Vera Jackson', 9012345678),
(310, 'Wendy King', 1123456789);

-- Insert data into Equipement with randomized dates
INSERT INTO Equipement (Equipement_ID, Equipment_Purchase_Date, Equipment_Name, Equipment_Status, Room_ID) VALUES
(401, TO_DATE('03/01/2016', 'DD/MM/YYYY'), 'Scalpel', 'New', 1),
(402, TO_DATE('23/05/2017', 'DD/MM/YYYY'), 'Stethoscope', 'Used', 2),
(403, TO_DATE('15/08/2018', 'DD/MM/YYYY'), 'Ultrasound Machine', 'New', 3),
(404, TO_DATE('29/11/2014', 'DD/MM/YYYY'), 'X-ray Machine', 'Used', 4),
(405, TO_DATE('06/07/2013', 'DD/MM/YYYY'), 'MRI Scanner', 'Old', 5),
(406, TO_DATE('18/09/2019', 'DD/MM/YYYY'), 'EKG Machine', 'New', 6),
(407, TO_DATE('07/02/2016', 'DD/MM/YYYY'), 'Defibrillator', 'Used', 7),
(408, TO_DATE('22/10/2015', 'DD/MM/YYYY'), 'Surgical Lights', 'Old', 8),
(409, TO_DATE('14/03/2020', 'DD/MM/YYYY'), 'Ventilator', 'New', 9),
(410, TO_DATE('09/04/2018', 'DD/MM/YYYY'), 'Anesthesia Machine', 'Used', 10);

-- Insert data into Operation with randomized dates
INSERT INTO Operation (Operation_ID, Operation_Date, Duration_Operation, Patient_ID, Room_ID) VALUES
(501, TO_DATE('12/02/2017', 'DD/MM/YYYY'), 120, 101, 1),
(502, TO_DATE('05/04/2018', 'DD/MM/YYYY'), 180, 102, 2),
(503, TO_DATE('19/06/2019', 'DD/MM/YYYY'), 90, 103, 3),
(504, TO_DATE('30/01/2016', 'DD/MM/YYYY'), 60, 104, 4),
(505, TO_DATE('25/07/2020', 'DD/MM/YYYY'), 150, 105, 5),
(506, TO_DATE('13/08/2017', 'DD/MM/YYYY'), 200, 106, 6),
(507, TO_DATE('22/09/2019', 'DD/MM/YYYY'), 110, 107, 7),
(508, TO_DATE('17/05/2018', 'DD/MM/YYYY'), 130, 108, 8),
(509, TO_DATE('28/03/2020', 'DD/MM/YYYY'), 70, 109, 9),
(510, TO_DATE('14/11/2016', 'DD/MM/YYYY'), 160, 110, 10);

-- Insert data into Operate_by
INSERT INTO Operate_by (Doctor_ID, Operation_ID, Salary) VALUES
(201, 501, 5000.0),
(202, 502, 5500.0),
(203, 503, 6000.0),
(204, 504, 4500.0),
(205, 505, 7000.0),
(206, 506, 5200.0),
(207, 507, 4800.0),
(208, 508, 5300.0),
(209, 509, 5900.0),
(210, 510, 6200.0);

-- Insert data into Assist_by
INSERT INTO Assist_by (Nurse_ID, Operation_ID, Salary) VALUES
(301, 501, 3000.0),
(302, 502, 3200.0),
(303, 503, 3400.0),
(304, 504, 3100.0),
(305, 505, 3300.0),
(306, 506, 3500.0),
(307, 507, 3600.0),
(308, 508, 3700.0),
(309, 509, 3800.0),
(310, 510, 3900.0);
