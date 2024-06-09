
[General]
Version=1

[Preferences]
Username=
Password=2679
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ELIAOU_HAIM
Name=OPERATING_ROOM
Count=400..500

[Record]
Name=ROOM_ID
Type=NUMBER
Size=
Data=Sequence(1200, 1, 2400)
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

