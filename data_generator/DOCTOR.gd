
[General]
Version=1

[Preferences]
Username=
Password=2090
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ELIAOU_HAIM
Name=DOCTOR
Count=400..500

[Record]
Name=DOCTOR_NAME
Type=VARCHAR2
Size=30
Data=LastName +'  '+ FirstName
Master=

[Record]
Name=SPECIALTY
Type=VARCHAR2
Size=50
Data=List('Cardiothoracic Surgery', 'General Surgery', 'Vascular Surgery', 'Neurosurgery', 'Orthopedic Surgery', 'Plastic Surgery', 'Pediatric Surgery', 'Colorectal Surgery', 'Hepatobiliary Surgery', 'Transplant Surgery', 'Trauma Surgery', 'Endocrine Surgery', 'Surgical Oncology', 'Breast Surgery', 'Minimally Invasive Surgery', 'Gastrointestinal Surgery', 'Urologic Surgery', 'Gynecologic Surgery', 'Otolaryngology', 'Oral and Maxillofacial Surgery', 'Thoracic Surgery', 'Bariatric Surgery', 'Robotic Surgery', 'Dermatologic Surgery', 'Ophthalmic Surgery', 'Hand Surgery', 'Foot and Ankle Surgery', 'Spine Surgery', 'Joint Replacement Surgery', 'Hernia Surgery', 'Pediatric Cardiothoracic Surgery', 'Pediatric Neurosurgery', 'Pediatric Orthopedic Surgery', 'Pediatric Otolaryngology', 'Pediatric Urology', 'Pediatric Gastrointestinal Surgery', 'Pediatric Plastic Surgery', 'Pediatric Transplant Surgery', 'Pediatric Trauma Surgery', 'Pediatric Endocrine Surgery', 'Pediatric Surgical Oncology', 'Trauma and Critical Care Surgery', 'Surgical Critical Care', 'Laparoscopic Surgery', 'Cardiac Surgery', 'Reconstructive Surgery', 'Head and Neck Surgery', 'Neurointerventional Surgery', 'Reproductive Surgery')
Master=

[Record]
Name=DOCTOR_ID
Type=NUMBER
Size=
Data=Sequence(2400, 1, 3600)
Master=

