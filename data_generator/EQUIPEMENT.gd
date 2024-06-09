
[General]
Version=1

[Preferences]
Username=
Password=2546
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##ELIAOU_HAIM
Name=EQUIPEMENT
Count=400..500

[Record]
Name=EQUIPEMENT_ID
Type=NUMBER
Size=
Data=Sequence(4800, 1, 6000)
Master=

[Record]
Name=EQUIPMENT_PURCHASE_DATE
Type=DATE
Size=
Data=List('01/01/2024', '14/01/2024', '28/01/2024', '05/02/2024', '19/02/2024', '03/03/2024', '17/03/2024', '31/03/2024', '07/04/2024', '21/04/2024', '05/05/2024', '19/05/2024', '02/06/2024', '16/06/2024', '30/06/2024', '14/07/2024', '28/07/2024', '11/08/2024', '25/08/2024', '08/09/2024', '22/09/2024', '06/10/2024', '20/10/2024', '03/11/2024', '17/11/2024', '01/12/2024', '15/12/2024', '29/12/2024', '13/01/2024', '27/01/2024', '10/02/2024', '24/02/2024', '09/03/2024', '23/03/2024', '06/04/2024', '20/04/2024', '04/05/2024', '18/05/2024', '01/06/2024', '15/06/2024', '29/06/2024', '13/07/2024', '27/07/2024', '10/08/2024', '24/08/2024', '07/09/2024', '21/09/2024', '05/10/2024', '19/10/2024')
Master=

[Record]
Name=EQUIPMENT_NAME
Type=VARCHAR2
Size=30
Data=List('Scalpel', 'Forceps', 'Hemostat', 'Surgical scissors', 'Needle holder', 'Retractor', 'Suction device', 'Surgical drapes', 'Surgical gloves', 'Surgical mask', 'Surgical gown', 'Sterile gauze', 'Surgical sponge', 'Electrocautery unit', 'Anesthesia machine', 'Operating table', 'Surgical lights', 'Suction canister', 'IV pole', 'Defibrillator', 'Patient monitor', 'Pulse oximeter', 'Syringe', 'Catheter', 'Endoscope', 'Laparoscope', 'Trocars', 'Cautery pencil', 'Surgical sutures', 'Bone saw', 'Surgical drill', 'Orthopedic implants', 'C-arm', 'Ultrasound machine', 'Sterilizer', 'Autoclave', 'Sterile container', 'Surgical tray', 'Surgical instrument table', 'Foot pedal', 'Infusion pump', 'Doppler', 'Microscope', 'Cryosurgery unit', 'Laser scalpel', 'Surgical stapler', 'Clip applier', 'Smoke evacuator', 'Surgical microscope')
Master=

[Record]
Name=EQUIPMENT_STATUS
Type=VARCHAR2
Size=30
Data=List('available', 'not available')
Master=

[Record]
Name=ROOM_ID
Type=NUMBER
Size=
Data=List(select ROOM_ID from Operating_Room)
Master=

