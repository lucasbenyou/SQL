CREATE TABLE Patient
(
  Patient_ID INT NOT NULL,
  Patient_Name VARCHAR(30) NOT NULL,
  Sexe VARCHAR(30) NOT NULL,
  Illness VARCHAR(100) NOT NULL,
  PRIMARY KEY (Patient_ID)
);

CREATE TABLE Operating_Room
(
  Room_ID INT NOT NULL,
  Availability VARCHAR(10) NOT NULL,
  Max_number_people INT NOT NULL,
  PRIMARY KEY (Room_ID)
);

CREATE TABLE Equipement
(
  Equipement_ID INT NOT NULL,
  Equipment_Purchase_Date DATE NOT NULL,
  Equipment_Name VARCHAR(30) NOT NULL,
  Equipment_Status VARCHAR(30) NOT NULL,
  Room_ID INT,
  PRIMARY KEY (Equipement_ID),
  FOREIGN KEY (Room_ID) REFERENCES Operating_Room(Room_ID)
);

CREATE TABLE Doctor
(
  Doctor_Name VARCHAR(30) NOT NULL,
  Specialty VARCHAR(50) NOT NULL,
  Doctor_ID INT NOT NULL,
  PRIMARY KEY (Doctor_ID)
);

CREATE TABLE Nurse
(
  Nurse_Name VARCHAR(30) NOT NULL,
  Telephone_number INT NOT NULL,
  Nurse_ID INT NOT NULL,
  PRIMARY KEY (Nurse_ID)
);

CREATE TABLE Operation
(
  Operation_Date DATE NOT NULL,
  Duration_Operation INT NOT NULL,
  Operation_ID INT NOT NULL,
  Patient_ID INT NOT NULL,
  Room_ID INT NOT NULL,
  PRIMARY KEY (Operation_ID),
  FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
  FOREIGN KEY (Room_ID) REFERENCES Operating_Room(Room_ID)
);

CREATE TABLE Operate_by
(
  Salary FLOAT NOT NULL,
  Doctor_ID INT NOT NULL,
  Operation_ID INT NOT NULL,
  PRIMARY KEY (Doctor_ID, Operation_ID),
  FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
  FOREIGN KEY (Operation_ID) REFERENCES Operation(Operation_ID)
);

CREATE TABLE Assist_by
(
  Salary FLOAT NOT NULL,
  Nurse_ID INT NOT NULL,
  Operation_ID INT NOT NULL,
  PRIMARY KEY (Nurse_ID, Operation_ID),
  FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID),
  FOREIGN KEY (Operation_ID) REFERENCES Operation(Operation_ID)
);
