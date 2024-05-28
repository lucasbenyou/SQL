
[General]
Version=1

[Preferences]
Username=
Password=2905
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=DOCTOR
Count=10..20

[Record]
Name=DOCTOR_NAME
Type=VARCHAR2
Size=30
Data=FirstName
Master=

[Record]
Name=SPECIALTY
Type=VARCHAR2
Size=50
Data=List('Cardiology', 'Neurology', 'Orthopedic')
Master=

[Record]
Name=DOCTOR_ID
Type=NUMBER
Size=
Data=Random(200, 300)
Master=

