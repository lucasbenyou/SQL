
[General]
Version=1

[Preferences]
Username=
Password=2574
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=OPERATING_ROOM
Count=10..20

[Record]
Name=ROOM_ID
Type=NUMBER
Size=
Data=Random(0, 100)
Master=

[Record]
Name=AVAILABILITY
Type=VARCHAR2
Size=10
Data=List('Yes', 'No')
Master=

[Record]
Name=MAX_NUMBER_PEOPLE
Type=NUMBER
Size=
Data=Random(0, 20)
Master=

