
[General]
Version=1

[Preferences]
Username=
Password=2076
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=NURSE
Count=10..20

[Record]
Name=NURSE_NAME
Type=VARCHAR2
Size=30
Data=FirstName
Master=

[Record]
Name=TELEPHONE_NUMBER
Type=NUMBER
Size=
Data=Random(0000000000, 9999999999)
Master=

[Record]
Name=NURSE_ID
Type=NUMBER
Size=
Data=Random(300, 400)
Master=

