
[General]
Version=1

[Preferences]
Username=
Password=2021
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ELIAOU_HAIM
Name=PATIENT
Count=400..500

[Record]
Name=PATIENT_ID
Type=NUMBER
Size=
Data=Sequence(100, 1, 1200)
Master=

[Record]
Name=PATIENT_NAME
Type=VARCHAR2
Size=30
Data=LastName +'  '+ FirstName
Master=

[Record]
Name=SEXE
Type=VARCHAR2
Size=30
Data=List('Man', 'Woman')
Master=

[Record]
Name=ILLNESS
Type=VARCHAR2
Size=100
Data=List('appendicitis', 'gallstones', 'hernia', 'colon cancer', 'gastric cancer', 'esophageal cancer', 'pancreatic cancer', 'liver cancer', 'lung cancer', 'breast cancer', 'prostate cancer', 'ovarian cancer', 'cervical cancer', 'endometrial cancer', 'bladder cancer', 'kidney cancer', 'testicular cancer', 'melanoma', 'thyroid cancer', 'brain tumor', 'aortic aneurysm', 'coronary artery disease', 'heart valve disease', 'congenital heart defects', 'peripheral artery disease', 'deep vein thrombosis', 'pulmonary embolism', 'biliary atresia', 'cleft lip and palate', 'intestinal atresia', 'pyloric stenosis', 'inguinal hernia', 'colectomy', 'gastrectomy', 'nephrectomy', 'prostatectomy', 'mastectomy', 'hysterectomy', 'thyroidectomy', 'lumpectomy', 'cholecystectomy', 'splenectomy', 'adrenalectomy', 'lobectomy', 'pneumonectomy', 'craniotomy', 'laminectomy', 'spinal fusion', 'hip replacement', 'knee replacement')
Master=

