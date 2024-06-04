
[General]
Version=1

[Preferences]
Username=
Password=2087
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
Data=FirstName
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
Data=List('heart', 'lung', 'liver')
Master=

