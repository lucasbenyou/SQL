
[General]
Version=1

[Preferences]
Username=
Password=2639
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=ASSIST_BY
Count=10..20

[Record]
Name=SALARY
Type=FLOAT
Size=22
Data=Random(2000, 4000)
Master=

[Record]
Name=NURSE_ID
Type=NUMBER
Size=
Data=List(select NURSE_ID from Nurse)
Master=

[Record]
Name=OPERATION_ID
Type=NUMBER
Size=
Data=List(select OPERATION_ID from Operation)
Master=

