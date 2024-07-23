prompt PL/SQL Developer Export Tables for user SHMUELAMIR@XE
prompt Created by shmulik on Monday, July 1, 2024
set feedback off
set define off

prompt Creating DEPARTMENT...
create table DEPARTMENT
(
  departmentid NUMBER not null,
  name         VARCHAR2(100) not null,
  location     VARCHAR2(100) not null,
  phone        VARCHAR2(15) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DEPARTMENT
  add primary key (DEPARTMENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating DOCTOR...
create table DOCTOR
(
  doctorid     NUMBER not null,
  name         VARCHAR2(100) not null,
  specialty    VARCHAR2(100) not null,
  phone        VARCHAR2(15) not null,
  departmentid NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DOCTOR
  add primary key (DOCTORID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DOCTOR
  add constraint FK_DOCTOR_DEPARTMENT foreign key (DEPARTMENTID)
  references DEPARTMENT (DEPARTMENTID);
alter table DOCTOR
  add constraint CHK_DOCTOR_PHONE
  check (REGEXP_LIKE(Phone, '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'));

prompt Creating MEDICATION...
create table MEDICATION
(
  medicationid    NUMBER not null,
  name            VARCHAR2(100) not null,
  description     VARCHAR2(255),
  expirationdate  DATE not null,
  quantityinstock NUMBER default 0 not null,
  strength        VARCHAR2(50)
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MEDICATION
  add primary key (MEDICATIONID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating ROOM...
create table ROOM
(
  roomid       NUMBER not null,
  type         VARCHAR2(50) not null,
  departmentid NUMBER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ROOM
  add primary key (ROOMID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ROOM
  add constraint FK_ROOM_DEPARTMENT foreign key (DEPARTMENTID)
  references DEPARTMENT (DEPARTMENTID);

prompt Creating PATIENT...
create table PATIENT
(
  patientid   NUMBER not null,
  name        VARCHAR2(100) not null,
  dateofbirth DATE,
  phone       VARCHAR2(15),
  roomid      NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PATIENT
  add primary key (PATIENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PATIENT
  add constraint FK_PATIENT_ROOM foreign key (ROOMID)
  references ROOM (ROOMID);

prompt Creating TREATMENT...
create table TREATMENT
(
  treatmentid   NUMBER not null,
  description   VARCHAR2(255),
  patientid     NUMBER not null,
  doctorid      NUMBER not null,
  treatmentdate DATE not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TREATMENT
  add primary key (TREATMENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TREATMENT
  add constraint FK_TREATMENT_DOCTOR foreign key (DOCTORID)
  references DOCTOR (DOCTORID) on delete cascade;
alter table TREATMENT
  add constraint FK_TREATMENT_PATIENT foreign key (PATIENTID)
  references PATIENT (PATIENTID);

prompt Creating MEDICATION_TREATMENT...
create table MEDICATION_TREATMENT
(
  medicationid INTEGER not null,
  treatmentid  INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MEDICATION_TREATMENT
  add primary key (MEDICATIONID, TREATMENTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MEDICATION_TREATMENT
  add constraint FK_MEDICATION_TREATMENT_TREATMENT foreign key (TREATMENTID)
  references TREATMENT (TREATMENTID) on delete cascade;
alter table MEDICATION_TREATMENT
  add foreign key (MEDICATIONID)
  references MEDICATION (MEDICATIONID);

prompt Disabling triggers for DEPARTMENT...
alter table DEPARTMENT disable all triggers;
prompt Disabling triggers for DOCTOR...
alter table DOCTOR disable all triggers;
prompt Disabling triggers for MEDICATION...
alter table MEDICATION disable all triggers;
prompt Disabling triggers for ROOM...
alter table ROOM disable all triggers;
prompt Disabling triggers for PATIENT...
alter table PATIENT disable all triggers;
prompt Disabling triggers for TREATMENT...
alter table TREATMENT disable all triggers;
prompt Disabling triggers for MEDICATION_TREATMENT...
alter table MEDICATION_TREATMENT disable all triggers;
prompt Disabling foreign key constraints for DOCTOR...
alter table DOCTOR disable constraint FK_DOCTOR_DEPARTMENT;
prompt Disabling foreign key constraints for ROOM...
alter table ROOM disable constraint FK_ROOM_DEPARTMENT;
prompt Disabling foreign key constraints for PATIENT...
alter table PATIENT disable constraint FK_PATIENT_ROOM;
prompt Disabling foreign key constraints for TREATMENT...
alter table TREATMENT disable constraint FK_TREATMENT_DOCTOR;
alter table TREATMENT disable constraint FK_TREATMENT_PATIENT;
prompt Disabling foreign key constraints for MEDICATION_TREATMENT...
alter table MEDICATION_TREATMENT disable constraint FK_MEDICATION_TREATMENT_TREATMENT;
alter table MEDICATION_TREATMENT disable constraint SYS_C008415;
prompt Deleting MEDICATION_TREATMENT...
delete from MEDICATION_TREATMENT;
commit;
prompt Deleting TREATMENT...
delete from TREATMENT;
commit;
prompt Deleting PATIENT...
delete from PATIENT;
commit;
prompt Deleting ROOM...
delete from ROOM;
commit;
prompt Deleting MEDICATION...
delete from MEDICATION;
commit;
prompt Deleting DOCTOR...
delete from DOCTOR;
commit;
prompt Deleting DEPARTMENT...
delete from DEPARTMENT;
commit;
prompt Loading DEPARTMENT...
insert into DEPARTMENT (departmentid, name, location, phone)
values (1, 'Laboratory', 'Q-1', '025338670');
insert into DEPARTMENT (departmentid, name, location, phone)
values (2, 'Obstetrics', 'D-7', '038448082');
insert into DEPARTMENT (departmentid, name, location, phone)
values (3, 'Pharmacy', 'A-4', '097542195');
insert into DEPARTMENT (departmentid, name, location, phone)
values (4, 'Orthopedics', 'F-8', '088006855');
insert into DEPARTMENT (departmentid, name, location, phone)
values (5, 'Therapy', 'D-5', '087788241');
insert into DEPARTMENT (departmentid, name, location, phone)
values (6, 'Pediatrics', 'H-8', '027588129');
insert into DEPARTMENT (departmentid, name, location, phone)
values (7, 'Care', 'I-5', '083228000');
insert into DEPARTMENT (departmentid, name, location, phone)
values (8, 'Radiology', 'K-7', '033749226');
insert into DEPARTMENT (departmentid, name, location, phone)
values (9, 'Care', 'N-1', '088241647');
insert into DEPARTMENT (departmentid, name, location, phone)
values (10, 'Cardiology', 'B-4', '084267663');
insert into DEPARTMENT (departmentid, name, location, phone)
values (11, 'Neurology', 'F-1', '098330767');
insert into DEPARTMENT (departmentid, name, location, phone)
values (12, 'Physical', 'D-2', '047267728');
insert into DEPARTMENT (departmentid, name, location, phone)
values (13, 'Psychiatry', 'A-2', '033717580');
insert into DEPARTMENT (departmentid, name, location, phone)
values (14, 'Unit', 'R-9', '074182580');
insert into DEPARTMENT (departmentid, name, location, phone)
values (15, 'Oncology', 'X-8', '071102019');
insert into DEPARTMENT (departmentid, name, location, phone)
values (16, 'Care', 'S-3', '071457521');
insert into DEPARTMENT (departmentid, name, location, phone)
values (17, 'Pharmacy', 'Y-4', '027575561');
insert into DEPARTMENT (departmentid, name, location, phone)
values (18, 'Neurology', 'C-7', '026936201');
insert into DEPARTMENT (departmentid, name, location, phone)
values (19, 'Intensive', 'V-9', '085605753');
insert into DEPARTMENT (departmentid, name, location, phone)
values (20, 'Nutrition', 'G-1', '096368601');
insert into DEPARTMENT (departmentid, name, location, phone)
values (21, 'Orthopedics', 'X-7', '096350099');
insert into DEPARTMENT (departmentid, name, location, phone)
values (22, 'Gynecology', 'D-4', '078750155');
insert into DEPARTMENT (departmentid, name, location, phone)
values (23, 'Laboratory', 'T-2', '025894890');
insert into DEPARTMENT (departmentid, name, location, phone)
values (24, 'Care', 'K-9', '028057788');
insert into DEPARTMENT (departmentid, name, location, phone)
values (25, 'Unit', 'V-7', '029406153');
insert into DEPARTMENT (departmentid, name, location, phone)
values (26, 'Nutrition', 'I-6', '041703572');
insert into DEPARTMENT (departmentid, name, location, phone)
values (27, 'Physical', 'W-4', '039188707');
insert into DEPARTMENT (departmentid, name, location, phone)
values (28, 'Radiology', 'L-3', '078492473');
insert into DEPARTMENT (departmentid, name, location, phone)
values (29, 'Emergency', 'P-2', '077337750');
insert into DEPARTMENT (departmentid, name, location, phone)
values (30, 'Therapy', 'D-2', '025359975');
insert into DEPARTMENT (departmentid, name, location, phone)
values (31, 'Neurology', 'E-5', '087598117');
insert into DEPARTMENT (departmentid, name, location, phone)
values (32, 'Intensive', 'C-9', '028490501');
insert into DEPARTMENT (departmentid, name, location, phone)
values (33, 'Unit', 'I-2', '038281647');
insert into DEPARTMENT (departmentid, name, location, phone)
values (34, 'Radiology', 'R-8', '046891245');
insert into DEPARTMENT (departmentid, name, location, phone)
values (35, 'Obstetrics', 'J-8', '024195678');
insert into DEPARTMENT (departmentid, name, location, phone)
values (36, 'Intensive', 'P-7', '097930555');
insert into DEPARTMENT (departmentid, name, location, phone)
values (37, 'Unit', 'F-5', '038567900');
insert into DEPARTMENT (departmentid, name, location, phone)
values (38, 'Intensive', 'D-5', '023058028');
insert into DEPARTMENT (departmentid, name, location, phone)
values (39, 'Care', 'A-7', '081477196');
insert into DEPARTMENT (departmentid, name, location, phone)
values (40, 'Obstetrics', 'S-4', '091717434');
insert into DEPARTMENT (departmentid, name, location, phone)
values (41, 'Neurology', 'R-1', '038379232');
insert into DEPARTMENT (departmentid, name, location, phone)
values (42, 'Radiology', 'G-6', '096655959');
insert into DEPARTMENT (departmentid, name, location, phone)
values (43, 'Oncology', 'P-2', '085511819');
insert into DEPARTMENT (departmentid, name, location, phone)
values (44, 'Gynecology', 'Z-1', '036236572');
insert into DEPARTMENT (departmentid, name, location, phone)
values (45, 'Obstetrics', 'H-2', '095341059');
insert into DEPARTMENT (departmentid, name, location, phone)
values (46, 'Laboratory', 'B-4', '028287091');
insert into DEPARTMENT (departmentid, name, location, phone)
values (47, 'Unit', 'Z-5', '072327465');
insert into DEPARTMENT (departmentid, name, location, phone)
values (48, 'Physical', 'B-4', '039282210');
insert into DEPARTMENT (departmentid, name, location, phone)
values (49, 'Care', 'Z-9', '039214053');
insert into DEPARTMENT (departmentid, name, location, phone)
values (50, 'Orthopedics', 'Y-2', '083565886');
insert into DEPARTMENT (departmentid, name, location, phone)
values (51, 'Orthopedics', 'C-1', '039328495');
insert into DEPARTMENT (departmentid, name, location, phone)
values (52, 'Oncology', 'L-1', '098693557');
insert into DEPARTMENT (departmentid, name, location, phone)
values (53, 'Obstetrics', 'U-7', '046111123');
insert into DEPARTMENT (departmentid, name, location, phone)
values (54, 'Unit', 'W-7', '089119154');
insert into DEPARTMENT (departmentid, name, location, phone)
values (55, 'Cardiology', 'X-3', '079792470');
insert into DEPARTMENT (departmentid, name, location, phone)
values (56, 'Obstetrics', 'K-4', '071183347');
insert into DEPARTMENT (departmentid, name, location, phone)
values (57, 'Pediatrics', 'F-7', '029910686');
insert into DEPARTMENT (departmentid, name, location, phone)
values (58, 'Physical', 'E-6', '021989312');
insert into DEPARTMENT (departmentid, name, location, phone)
values (59, 'Gynecology', 'L-8', '033742897');
insert into DEPARTMENT (departmentid, name, location, phone)
values (60, 'Cardiology', 'C-8', '031093149');
insert into DEPARTMENT (departmentid, name, location, phone)
values (61, 'Emergency', 'Q-4', '077788100');
insert into DEPARTMENT (departmentid, name, location, phone)
values (62, 'Psychiatry', 'D-3', '097300339');
insert into DEPARTMENT (departmentid, name, location, phone)
values (63, 'Oncology', 'S-3', '075744821');
insert into DEPARTMENT (departmentid, name, location, phone)
values (64, 'Unit', 'J-6', '099059805');
insert into DEPARTMENT (departmentid, name, location, phone)
values (65, 'Therapy', 'S-9', '035037132');
insert into DEPARTMENT (departmentid, name, location, phone)
values (66, 'Oncology', 'I-1', '023295801');
insert into DEPARTMENT (departmentid, name, location, phone)
values (67, 'Therapy', 'D-5', '082420145');
insert into DEPARTMENT (departmentid, name, location, phone)
values (68, 'Radiology', 'P-3', '075827390');
insert into DEPARTMENT (departmentid, name, location, phone)
values (69, 'Surgery', 'P-4', '097603350');
insert into DEPARTMENT (departmentid, name, location, phone)
values (70, 'Neurology', 'Z-4', '048108323');
insert into DEPARTMENT (departmentid, name, location, phone)
values (71, 'Intensive', 'F-9', '021729552');
insert into DEPARTMENT (departmentid, name, location, phone)
values (72, 'Psychiatry', 'O-1', '083689034');
insert into DEPARTMENT (departmentid, name, location, phone)
values (73, 'Emergency', 'Z-4', '078001293');
insert into DEPARTMENT (departmentid, name, location, phone)
values (74, 'Pharmacy', 'S-4', '033869874');
insert into DEPARTMENT (departmentid, name, location, phone)
values (75, 'Care', 'W-5', '082317902');
insert into DEPARTMENT (departmentid, name, location, phone)
values (76, 'Gynecology', 'Y-9', '031293022');
insert into DEPARTMENT (departmentid, name, location, phone)
values (77, 'Care', 'I-1', '046537316');
insert into DEPARTMENT (departmentid, name, location, phone)
values (78, 'Therapy', 'M-7', '044022261');
insert into DEPARTMENT (departmentid, name, location, phone)
values (79, 'Physical', 'X-7', '021469981');
insert into DEPARTMENT (departmentid, name, location, phone)
values (80, 'Laboratory', 'N-8', '024797516');
insert into DEPARTMENT (departmentid, name, location, phone)
values (81, 'Orthopedics', 'N-8', '073009963');
insert into DEPARTMENT (departmentid, name, location, phone)
values (82, 'Emergency', 'F-1', '084937176');
insert into DEPARTMENT (departmentid, name, location, phone)
values (83, 'Oncology', 'Z-4', '089473480');
insert into DEPARTMENT (departmentid, name, location, phone)
values (84, 'Unit', 'V-2', '031608284');
insert into DEPARTMENT (departmentid, name, location, phone)
values (85, 'Care', 'V-4', '024309762');
insert into DEPARTMENT (departmentid, name, location, phone)
values (86, 'Neurology', 'X-5', '076205206');
insert into DEPARTMENT (departmentid, name, location, phone)
values (87, 'Physical', 'G-5', '024436070');
insert into DEPARTMENT (departmentid, name, location, phone)
values (88, 'Pharmacy', 'O-6', '049183819');
insert into DEPARTMENT (departmentid, name, location, phone)
values (89, 'Oncology', 'H-4', '045590308');
insert into DEPARTMENT (departmentid, name, location, phone)
values (90, 'Intensive', 'G-8', '077203149');
insert into DEPARTMENT (departmentid, name, location, phone)
values (91, 'Unit', 'J-6', '046853455');
insert into DEPARTMENT (departmentid, name, location, phone)
values (92, 'Emergency', 'O-6', '088642208');
insert into DEPARTMENT (departmentid, name, location, phone)
values (93, 'Emergency', 'F-8', '083932504');
insert into DEPARTMENT (departmentid, name, location, phone)
values (94, 'Gynecology', 'H-9', '096799034');
insert into DEPARTMENT (departmentid, name, location, phone)
values (95, 'Intensive', 'Y-8', '035475281');
insert into DEPARTMENT (departmentid, name, location, phone)
values (96, 'Unit', 'V-6', '047154139');
insert into DEPARTMENT (departmentid, name, location, phone)
values (97, 'Care', 'J-2', '036673852');
insert into DEPARTMENT (departmentid, name, location, phone)
values (98, 'Neurology', 'Q-1', '038304205');
insert into DEPARTMENT (departmentid, name, location, phone)
values (99, 'Orthopedics', 'Q-9', '038265768');
insert into DEPARTMENT (departmentid, name, location, phone)
values (100, 'Care', 'U-6', '027356416');
commit;
prompt 100 records committed...
insert into DEPARTMENT (departmentid, name, location, phone)
values (101, 'Intensive', 'T-4', '037824645');
insert into DEPARTMENT (departmentid, name, location, phone)
values (102, 'Laboratory', 'Q-4', '037031860');
insert into DEPARTMENT (departmentid, name, location, phone)
values (103, 'Laboratory', 'C-7', '088505941');
insert into DEPARTMENT (departmentid, name, location, phone)
values (104, 'Pharmacy', 'F-6', '046270349');
insert into DEPARTMENT (departmentid, name, location, phone)
values (105, 'Nutrition', 'U-5', '047242961');
insert into DEPARTMENT (departmentid, name, location, phone)
values (106, 'Oncology', 'R-6', '083071397');
insert into DEPARTMENT (departmentid, name, location, phone)
values (107, 'Gynecology', 'S-9', '079334343');
insert into DEPARTMENT (departmentid, name, location, phone)
values (108, 'Emergency', 'E-3', '084459416');
insert into DEPARTMENT (departmentid, name, location, phone)
values (109, 'Pharmacy', 'G-4', '085490311');
insert into DEPARTMENT (departmentid, name, location, phone)
values (110, 'Laboratory', 'Q-6', '083137966');
insert into DEPARTMENT (departmentid, name, location, phone)
values (111, 'Neurology', 'C-4', '039273097');
insert into DEPARTMENT (departmentid, name, location, phone)
values (112, 'Care', 'R-8', '098410544');
insert into DEPARTMENT (departmentid, name, location, phone)
values (113, 'Emergency', 'B-3', '088539830');
insert into DEPARTMENT (departmentid, name, location, phone)
values (114, 'Nutrition', 'A-6', '094606590');
insert into DEPARTMENT (departmentid, name, location, phone)
values (115, 'Unit', 'I-2', '046536191');
insert into DEPARTMENT (departmentid, name, location, phone)
values (116, 'Therapy', 'M-6', '092373404');
insert into DEPARTMENT (departmentid, name, location, phone)
values (117, 'Neurology', 'S-2', '036758883');
insert into DEPARTMENT (departmentid, name, location, phone)
values (118, 'Therapy', 'E-3', '042090221');
insert into DEPARTMENT (departmentid, name, location, phone)
values (119, 'Therapy', 'H-4', '071166874');
insert into DEPARTMENT (departmentid, name, location, phone)
values (120, 'Pharmacy', 'C-2', '073142090');
insert into DEPARTMENT (departmentid, name, location, phone)
values (121, 'Therapy', 'O-7', '072837961');
insert into DEPARTMENT (departmentid, name, location, phone)
values (122, 'Cardiology', 'B-3', '025171134');
insert into DEPARTMENT (departmentid, name, location, phone)
values (123, 'Intensive', 'N-2', '023301019');
insert into DEPARTMENT (departmentid, name, location, phone)
values (124, 'Surgery', 'I-3', '097513553');
insert into DEPARTMENT (departmentid, name, location, phone)
values (125, 'Psychiatry', 'K-9', '093587735');
insert into DEPARTMENT (departmentid, name, location, phone)
values (126, 'Intensive', 'B-7', '044145001');
insert into DEPARTMENT (departmentid, name, location, phone)
values (127, 'Obstetrics', 'K-7', '024103341');
insert into DEPARTMENT (departmentid, name, location, phone)
values (128, 'Obstetrics', 'S-7', '084407169');
insert into DEPARTMENT (departmentid, name, location, phone)
values (129, 'Intensive', 'M-1', '029776156');
insert into DEPARTMENT (departmentid, name, location, phone)
values (130, 'Gynecology', 'V-6', '042887039');
insert into DEPARTMENT (departmentid, name, location, phone)
values (131, 'Radiology', 'T-4', '093173343');
insert into DEPARTMENT (departmentid, name, location, phone)
values (132, 'Cardiology', 'I-2', '039879816');
insert into DEPARTMENT (departmentid, name, location, phone)
values (133, 'Oncology', 'C-5', '074427464');
insert into DEPARTMENT (departmentid, name, location, phone)
values (134, 'Gynecology', 'N-7', '046199611');
insert into DEPARTMENT (departmentid, name, location, phone)
values (135, 'Obstetrics', 'B-9', '048467863');
insert into DEPARTMENT (departmentid, name, location, phone)
values (136, 'Radiology', 'L-2', '094520828');
insert into DEPARTMENT (departmentid, name, location, phone)
values (137, 'Orthopedics', 'C-6', '025254993');
insert into DEPARTMENT (departmentid, name, location, phone)
values (138, 'Obstetrics', 'L-8', '084250638');
insert into DEPARTMENT (departmentid, name, location, phone)
values (139, 'Care', 'U-3', '028037096');
insert into DEPARTMENT (departmentid, name, location, phone)
values (140, 'Surgery', 'A-6', '025961219');
insert into DEPARTMENT (departmentid, name, location, phone)
values (141, 'Therapy', 'R-9', '096149628');
insert into DEPARTMENT (departmentid, name, location, phone)
values (142, 'Care', 'H-3', '027962211');
insert into DEPARTMENT (departmentid, name, location, phone)
values (143, 'Nutrition', 'U-4', '045120967');
insert into DEPARTMENT (departmentid, name, location, phone)
values (144, 'Pediatrics', 'A-4', '087481524');
insert into DEPARTMENT (departmentid, name, location, phone)
values (145, 'Emergency', 'F-3', '073895816');
insert into DEPARTMENT (departmentid, name, location, phone)
values (146, 'Neurology', 'G-5', '042458770');
insert into DEPARTMENT (departmentid, name, location, phone)
values (147, 'Intensive', 'P-3', '073402735');
insert into DEPARTMENT (departmentid, name, location, phone)
values (148, 'Emergency', 'G-5', '021952662');
insert into DEPARTMENT (departmentid, name, location, phone)
values (149, 'Orthopedics', 'D-9', '072536977');
insert into DEPARTMENT (departmentid, name, location, phone)
values (150, 'Physical', 'C-7', '042934233');
insert into DEPARTMENT (departmentid, name, location, phone)
values (151, 'Unit', 'X-2', '042466695');
insert into DEPARTMENT (departmentid, name, location, phone)
values (152, 'Cardiology', 'Q-7', '096594171');
insert into DEPARTMENT (departmentid, name, location, phone)
values (153, 'Intensive', 'C-2', '047062216');
insert into DEPARTMENT (departmentid, name, location, phone)
values (154, 'Psychiatry', 'J-2', '083547442');
insert into DEPARTMENT (departmentid, name, location, phone)
values (155, 'Neurology', 'Z-5', '032756854');
insert into DEPARTMENT (departmentid, name, location, phone)
values (156, 'Cardiology', 'A-5', '096284210');
insert into DEPARTMENT (departmentid, name, location, phone)
values (157, 'Therapy', 'W-4', '022336191');
insert into DEPARTMENT (departmentid, name, location, phone)
values (158, 'Pharmacy', 'X-5', '028205305');
insert into DEPARTMENT (departmentid, name, location, phone)
values (159, 'Unit', 'O-8', '073583467');
insert into DEPARTMENT (departmentid, name, location, phone)
values (160, 'Pediatrics', 'G-2', '025405688');
insert into DEPARTMENT (departmentid, name, location, phone)
values (161, 'Cardiology', 'Q-8', '095444021');
insert into DEPARTMENT (departmentid, name, location, phone)
values (162, 'Cardiology', 'Y-2', '081343008');
insert into DEPARTMENT (departmentid, name, location, phone)
values (163, 'Neurology', 'Y-2', '096974290');
insert into DEPARTMENT (departmentid, name, location, phone)
values (164, 'Radiology', 'A-4', '072462898');
insert into DEPARTMENT (departmentid, name, location, phone)
values (165, 'Orthopedics', 'A-4', '032873112');
insert into DEPARTMENT (departmentid, name, location, phone)
values (166, 'Physical', 'P-5', '047060673');
insert into DEPARTMENT (departmentid, name, location, phone)
values (167, 'Obstetrics', 'Y-6', '046417442');
insert into DEPARTMENT (departmentid, name, location, phone)
values (168, 'Neurology', 'G-2', '049953045');
insert into DEPARTMENT (departmentid, name, location, phone)
values (169, 'Therapy', 'P-9', '079203770');
insert into DEPARTMENT (departmentid, name, location, phone)
values (170, 'Physical', 'S-5', '079225837');
insert into DEPARTMENT (departmentid, name, location, phone)
values (171, 'Physical', 'X-1', '024792736');
insert into DEPARTMENT (departmentid, name, location, phone)
values (172, 'Intensive', 'X-7', '081227019');
insert into DEPARTMENT (departmentid, name, location, phone)
values (173, 'Psychiatry', 'Q-1', '099230478');
insert into DEPARTMENT (departmentid, name, location, phone)
values (174, 'Obstetrics', 'D-6', '072401123');
insert into DEPARTMENT (departmentid, name, location, phone)
values (175, 'Nutrition', 'Y-8', '079038373');
insert into DEPARTMENT (departmentid, name, location, phone)
values (176, 'Surgery', 'Y-6', '031323810');
insert into DEPARTMENT (departmentid, name, location, phone)
values (177, 'Unit', 'U-9', '086685709');
insert into DEPARTMENT (departmentid, name, location, phone)
values (178, 'Emergency', 'P-6', '074706486');
insert into DEPARTMENT (departmentid, name, location, phone)
values (179, 'Oncology', 'U-8', '035349847');
insert into DEPARTMENT (departmentid, name, location, phone)
values (180, 'Gynecology', 'M-1', '041012926');
insert into DEPARTMENT (departmentid, name, location, phone)
values (181, 'Psychiatry', 'R-8', '038988160');
insert into DEPARTMENT (departmentid, name, location, phone)
values (182, 'Cardiology', 'O-7', '039975401');
insert into DEPARTMENT (departmentid, name, location, phone)
values (183, 'Intensive', 'H-6', '091957968');
insert into DEPARTMENT (departmentid, name, location, phone)
values (184, 'Neurology', 'G-8', '095529197');
insert into DEPARTMENT (departmentid, name, location, phone)
values (185, 'Cardiology', 'T-9', '044687268');
insert into DEPARTMENT (departmentid, name, location, phone)
values (186, 'Intensive', 'G-9', '072814372');
insert into DEPARTMENT (departmentid, name, location, phone)
values (187, 'Pharmacy', 'V-8', '083782850');
insert into DEPARTMENT (departmentid, name, location, phone)
values (188, 'Intensive', 'J-4', '039734331');
insert into DEPARTMENT (departmentid, name, location, phone)
values (189, 'Pharmacy', 'N-2', '091525894');
insert into DEPARTMENT (departmentid, name, location, phone)
values (190, 'Therapy', 'I-9', '029425137');
insert into DEPARTMENT (departmentid, name, location, phone)
values (191, 'Radiology', 'N-9', '081510753');
insert into DEPARTMENT (departmentid, name, location, phone)
values (192, 'Surgery', 'N-8', '088689611');
insert into DEPARTMENT (departmentid, name, location, phone)
values (193, 'Obstetrics', 'L-1', '076293046');
insert into DEPARTMENT (departmentid, name, location, phone)
values (194, 'Radiology', 'T-1', '026298944');
insert into DEPARTMENT (departmentid, name, location, phone)
values (195, 'Emergency', 'H-3', '045890656');
insert into DEPARTMENT (departmentid, name, location, phone)
values (196, 'Oncology', 'L-2', '021874094');
insert into DEPARTMENT (departmentid, name, location, phone)
values (197, 'Physical', 'W-7', '099888515');
insert into DEPARTMENT (departmentid, name, location, phone)
values (198, 'Oncology', 'F-2', '036142267');
insert into DEPARTMENT (departmentid, name, location, phone)
values (199, 'Intensive', 'T-9', '027297426');
insert into DEPARTMENT (departmentid, name, location, phone)
values (200, 'Care', 'F-7', '075532696');
commit;
prompt 200 records committed...
insert into DEPARTMENT (departmentid, name, location, phone)
values (201, 'Intensive', 'U-7', '087271300');
insert into DEPARTMENT (departmentid, name, location, phone)
values (202, 'Gynecology', 'L-7', '093643354');
insert into DEPARTMENT (departmentid, name, location, phone)
values (203, 'Oncology', 'Z-8', '043858467');
insert into DEPARTMENT (departmentid, name, location, phone)
values (204, 'Nutrition', 'J-8', '098888529');
insert into DEPARTMENT (departmentid, name, location, phone)
values (205, 'Psychiatry', 'S-1', '093213695');
insert into DEPARTMENT (departmentid, name, location, phone)
values (206, 'Nutrition', 'X-7', '075938954');
insert into DEPARTMENT (departmentid, name, location, phone)
values (207, 'Pharmacy', 'N-1', '029690719');
insert into DEPARTMENT (departmentid, name, location, phone)
values (208, 'Emergency', 'S-2', '021203881');
insert into DEPARTMENT (departmentid, name, location, phone)
values (209, 'Therapy', 'W-4', '042032923');
insert into DEPARTMENT (departmentid, name, location, phone)
values (210, 'Obstetrics', 'L-2', '075890630');
insert into DEPARTMENT (departmentid, name, location, phone)
values (211, 'Pediatrics', 'L-4', '092044884');
insert into DEPARTMENT (departmentid, name, location, phone)
values (212, 'Intensive', 'F-2', '029924194');
insert into DEPARTMENT (departmentid, name, location, phone)
values (213, 'Intensive', 'X-4', '088722173');
insert into DEPARTMENT (departmentid, name, location, phone)
values (214, 'Gynecology', 'B-9', '091530008');
insert into DEPARTMENT (departmentid, name, location, phone)
values (215, 'Gynecology', 'Z-2', '022403756');
insert into DEPARTMENT (departmentid, name, location, phone)
values (216, 'Pediatrics', 'J-9', '032389429');
insert into DEPARTMENT (departmentid, name, location, phone)
values (217, 'Physical', 'B-4', '088152934');
insert into DEPARTMENT (departmentid, name, location, phone)
values (218, 'Care', 'Z-7', '075282348');
insert into DEPARTMENT (departmentid, name, location, phone)
values (219, 'Psychiatry', 'E-1', '092831522');
insert into DEPARTMENT (departmentid, name, location, phone)
values (220, 'Orthopedics', 'H-6', '029847191');
insert into DEPARTMENT (departmentid, name, location, phone)
values (221, 'Obstetrics', 'Y-6', '028270491');
insert into DEPARTMENT (departmentid, name, location, phone)
values (222, 'Care', 'W-2', '096827812');
insert into DEPARTMENT (departmentid, name, location, phone)
values (223, 'Emergency', 'J-2', '029120917');
insert into DEPARTMENT (departmentid, name, location, phone)
values (224, 'Surgery', 'M-7', '076751982');
insert into DEPARTMENT (departmentid, name, location, phone)
values (225, 'Nutrition', 'W-9', '071454458');
insert into DEPARTMENT (departmentid, name, location, phone)
values (226, 'Care', 'W-5', '028709802');
insert into DEPARTMENT (departmentid, name, location, phone)
values (227, 'Emergency', 'K-8', '076535111');
insert into DEPARTMENT (departmentid, name, location, phone)
values (228, 'Surgery', 'Q-4', '037584963');
insert into DEPARTMENT (departmentid, name, location, phone)
values (229, 'Unit', 'W-7', '076466229');
insert into DEPARTMENT (departmentid, name, location, phone)
values (230, 'Cardiology', 'L-1', '034049741');
insert into DEPARTMENT (departmentid, name, location, phone)
values (231, 'Oncology', 'A-9', '097191190');
insert into DEPARTMENT (departmentid, name, location, phone)
values (232, 'Pharmacy', 'C-4', '088678606');
insert into DEPARTMENT (departmentid, name, location, phone)
values (233, 'Laboratory', 'U-5', '044655214');
insert into DEPARTMENT (departmentid, name, location, phone)
values (234, 'Gynecology', 'T-7', '041977677');
insert into DEPARTMENT (departmentid, name, location, phone)
values (235, 'Intensive', 'Y-1', '047382114');
insert into DEPARTMENT (departmentid, name, location, phone)
values (236, 'Gynecology', 'D-7', '037780590');
insert into DEPARTMENT (departmentid, name, location, phone)
values (237, 'Emergency', 'T-6', '099345740');
insert into DEPARTMENT (departmentid, name, location, phone)
values (238, 'Radiology', 'L-1', '031638083');
insert into DEPARTMENT (departmentid, name, location, phone)
values (239, 'Obstetrics', 'D-4', '039384036');
insert into DEPARTMENT (departmentid, name, location, phone)
values (240, 'Physical', 'L-4', '093341343');
insert into DEPARTMENT (departmentid, name, location, phone)
values (241, 'Laboratory', 'R-7', '035576496');
insert into DEPARTMENT (departmentid, name, location, phone)
values (242, 'Pediatrics', 'A-8', '046880223');
insert into DEPARTMENT (departmentid, name, location, phone)
values (243, 'Obstetrics', 'U-9', '033545831');
insert into DEPARTMENT (departmentid, name, location, phone)
values (244, 'Obstetrics', 'F-6', '093759585');
insert into DEPARTMENT (departmentid, name, location, phone)
values (245, 'Intensive', 'I-9', '073614382');
insert into DEPARTMENT (departmentid, name, location, phone)
values (246, 'Oncology', 'M-6', '034992465');
insert into DEPARTMENT (departmentid, name, location, phone)
values (247, 'Surgery', 'T-1', '076707746');
insert into DEPARTMENT (departmentid, name, location, phone)
values (248, 'Pediatrics', 'U-6', '097070254');
insert into DEPARTMENT (departmentid, name, location, phone)
values (249, 'Oncology', 'G-6', '021914660');
insert into DEPARTMENT (departmentid, name, location, phone)
values (250, 'Laboratory', 'E-5', '026089922');
insert into DEPARTMENT (departmentid, name, location, phone)
values (251, 'Nutrition', 'H-1', '033246009');
insert into DEPARTMENT (departmentid, name, location, phone)
values (252, 'Pediatrics', 'U-9', '023809193');
insert into DEPARTMENT (departmentid, name, location, phone)
values (253, 'Gynecology', 'B-3', '088449255');
insert into DEPARTMENT (departmentid, name, location, phone)
values (254, 'Unit', 'Z-2', '048014771');
insert into DEPARTMENT (departmentid, name, location, phone)
values (255, 'Radiology', 'Z-8', '096290301');
insert into DEPARTMENT (departmentid, name, location, phone)
values (256, 'Care', 'Y-6', '074038966');
insert into DEPARTMENT (departmentid, name, location, phone)
values (257, 'Gynecology', 'Z-9', '091575107');
insert into DEPARTMENT (departmentid, name, location, phone)
values (258, 'Pharmacy', 'O-6', '075858664');
insert into DEPARTMENT (departmentid, name, location, phone)
values (259, 'Care', 'L-6', '048910952');
insert into DEPARTMENT (departmentid, name, location, phone)
values (260, 'Nutrition', 'K-3', '091770187');
insert into DEPARTMENT (departmentid, name, location, phone)
values (261, 'Care', 'I-5', '081864432');
insert into DEPARTMENT (departmentid, name, location, phone)
values (262, 'Orthopedics', 'Q-6', '095466565');
insert into DEPARTMENT (departmentid, name, location, phone)
values (263, 'Unit', 'K-5', '072322732');
insert into DEPARTMENT (departmentid, name, location, phone)
values (264, 'Care', 'G-9', '048262722');
insert into DEPARTMENT (departmentid, name, location, phone)
values (265, 'Pharmacy', 'L-3', '035568769');
insert into DEPARTMENT (departmentid, name, location, phone)
values (266, 'Surgery', 'D-3', '092531419');
insert into DEPARTMENT (departmentid, name, location, phone)
values (267, 'Radiology', 'W-9', '026402132');
insert into DEPARTMENT (departmentid, name, location, phone)
values (268, 'Orthopedics', 'C-3', '098941164');
insert into DEPARTMENT (departmentid, name, location, phone)
values (269, 'Unit', 'G-5', '099638698');
insert into DEPARTMENT (departmentid, name, location, phone)
values (270, 'Physical', 'M-7', '098139013');
insert into DEPARTMENT (departmentid, name, location, phone)
values (271, 'Gynecology', 'K-3', '036064979');
insert into DEPARTMENT (departmentid, name, location, phone)
values (272, 'Pharmacy', 'F-7', '076908924');
insert into DEPARTMENT (departmentid, name, location, phone)
values (273, 'Gynecology', 'S-1', '049471090');
insert into DEPARTMENT (departmentid, name, location, phone)
values (274, 'Nutrition', 'H-5', '035872406');
insert into DEPARTMENT (departmentid, name, location, phone)
values (275, 'Orthopedics', 'O-8', '074301295');
insert into DEPARTMENT (departmentid, name, location, phone)
values (276, 'Pediatrics', 'T-3', '093295343');
insert into DEPARTMENT (departmentid, name, location, phone)
values (277, 'Oncology', 'K-9', '095805780');
insert into DEPARTMENT (departmentid, name, location, phone)
values (278, 'Surgery', 'J-3', '086835306');
insert into DEPARTMENT (departmentid, name, location, phone)
values (279, 'Nutrition', 'W-8', '078914247');
insert into DEPARTMENT (departmentid, name, location, phone)
values (280, 'Neurology', 'S-2', '099920181');
insert into DEPARTMENT (departmentid, name, location, phone)
values (281, 'Intensive', 'G-3', '085443515');
insert into DEPARTMENT (departmentid, name, location, phone)
values (282, 'Nutrition', 'P-9', '042203767');
insert into DEPARTMENT (departmentid, name, location, phone)
values (283, 'Laboratory', 'N-5', '086260075');
insert into DEPARTMENT (departmentid, name, location, phone)
values (284, 'Therapy', 'C-6', '073009862');
insert into DEPARTMENT (departmentid, name, location, phone)
values (285, 'Obstetrics', 'E-9', '032707083');
insert into DEPARTMENT (departmentid, name, location, phone)
values (286, 'Psychiatry', 'H-8', '092165579');
insert into DEPARTMENT (departmentid, name, location, phone)
values (287, 'Care', 'A-1', '074535873');
insert into DEPARTMENT (departmentid, name, location, phone)
values (288, 'Surgery', 'Q-5', '037949857');
insert into DEPARTMENT (departmentid, name, location, phone)
values (289, 'Unit', 'B-3', '022817469');
insert into DEPARTMENT (departmentid, name, location, phone)
values (290, 'Cardiology', 'Y-9', '071356736');
insert into DEPARTMENT (departmentid, name, location, phone)
values (291, 'Intensive', 'G-4', '026412098');
insert into DEPARTMENT (departmentid, name, location, phone)
values (292, 'Intensive', 'C-1', '083307572');
insert into DEPARTMENT (departmentid, name, location, phone)
values (293, 'Nutrition', 'K-7', '026606928');
insert into DEPARTMENT (departmentid, name, location, phone)
values (294, 'Laboratory', 'W-4', '041154337');
insert into DEPARTMENT (departmentid, name, location, phone)
values (295, 'Radiology', 'C-6', '037056677');
insert into DEPARTMENT (departmentid, name, location, phone)
values (296, 'Therapy', 'G-8', '079610119');
insert into DEPARTMENT (departmentid, name, location, phone)
values (297, 'Neurology', 'G-7', '094240847');
insert into DEPARTMENT (departmentid, name, location, phone)
values (298, 'Radiology', 'H-3', '035435317');
insert into DEPARTMENT (departmentid, name, location, phone)
values (299, 'Physical', 'V-7', '087847595');
insert into DEPARTMENT (departmentid, name, location, phone)
values (300, 'Unit', 'F-7', '071611340');
commit;
prompt 300 records committed...
insert into DEPARTMENT (departmentid, name, location, phone)
values (301, 'Pediatrics', 'A-2', '099870278');
insert into DEPARTMENT (departmentid, name, location, phone)
values (302, 'Nutrition', 'V-1', '037660372');
insert into DEPARTMENT (departmentid, name, location, phone)
values (303, 'Cardiology', 'Q-4', '072320828');
insert into DEPARTMENT (departmentid, name, location, phone)
values (304, 'Neurology', 'Y-3', '025032479');
insert into DEPARTMENT (departmentid, name, location, phone)
values (305, 'Cardiology', 'O-6', '039386995');
insert into DEPARTMENT (departmentid, name, location, phone)
values (306, 'Neurology', 'Y-3', '037392449');
insert into DEPARTMENT (departmentid, name, location, phone)
values (307, 'Neurology', 'A-6', '081150510');
insert into DEPARTMENT (departmentid, name, location, phone)
values (308, 'Therapy', 'U-4', '023010839');
insert into DEPARTMENT (departmentid, name, location, phone)
values (309, 'Neurology', 'N-1', '091702981');
insert into DEPARTMENT (departmentid, name, location, phone)
values (310, 'Oncology', 'R-5', '096609189');
insert into DEPARTMENT (departmentid, name, location, phone)
values (311, 'Unit', 'T-1', '033208198');
insert into DEPARTMENT (departmentid, name, location, phone)
values (312, 'Pediatrics', 'T-9', '078740846');
insert into DEPARTMENT (departmentid, name, location, phone)
values (313, 'Unit', 'S-4', '041226193');
insert into DEPARTMENT (departmentid, name, location, phone)
values (314, 'Orthopedics', 'K-9', '021418683');
insert into DEPARTMENT (departmentid, name, location, phone)
values (315, 'Emergency', 'H-2', '031998111');
insert into DEPARTMENT (departmentid, name, location, phone)
values (316, 'Therapy', 'M-4', '096041849');
insert into DEPARTMENT (departmentid, name, location, phone)
values (317, 'Neurology', 'F-8', '036454499');
insert into DEPARTMENT (departmentid, name, location, phone)
values (318, 'Pharmacy', 'H-5', '025037927');
insert into DEPARTMENT (departmentid, name, location, phone)
values (319, 'Neurology', 'A-5', '072015226');
insert into DEPARTMENT (departmentid, name, location, phone)
values (320, 'Intensive', 'G-9', '091837071');
insert into DEPARTMENT (departmentid, name, location, phone)
values (321, 'Oncology', 'R-6', '044859644');
insert into DEPARTMENT (departmentid, name, location, phone)
values (322, 'Neurology', 'X-4', '035143349');
insert into DEPARTMENT (departmentid, name, location, phone)
values (323, 'Pediatrics', 'E-9', '043823097');
insert into DEPARTMENT (departmentid, name, location, phone)
values (324, 'Pharmacy', 'U-5', '044778053');
insert into DEPARTMENT (departmentid, name, location, phone)
values (325, 'Laboratory', 'F-2', '075483144');
insert into DEPARTMENT (departmentid, name, location, phone)
values (326, 'Intensive', 'O-1', '033952778');
insert into DEPARTMENT (departmentid, name, location, phone)
values (327, 'Intensive', 'L-6', '088898274');
insert into DEPARTMENT (departmentid, name, location, phone)
values (328, 'Neurology', 'F-9', '027498993');
insert into DEPARTMENT (departmentid, name, location, phone)
values (329, 'Intensive', 'M-8', '092915955');
insert into DEPARTMENT (departmentid, name, location, phone)
values (330, 'Pharmacy', 'F-9', '083648233');
insert into DEPARTMENT (departmentid, name, location, phone)
values (331, 'Radiology', 'A-5', '027538207');
insert into DEPARTMENT (departmentid, name, location, phone)
values (332, 'Laboratory', 'Q-2', '047235333');
insert into DEPARTMENT (departmentid, name, location, phone)
values (333, 'Nutrition', 'K-8', '093583815');
insert into DEPARTMENT (departmentid, name, location, phone)
values (334, 'Pharmacy', 'H-6', '038998912');
insert into DEPARTMENT (departmentid, name, location, phone)
values (335, 'Neurology', 'B-6', '075379489');
insert into DEPARTMENT (departmentid, name, location, phone)
values (336, 'Cardiology', 'M-6', '022790987');
insert into DEPARTMENT (departmentid, name, location, phone)
values (337, 'Surgery', 'D-4', '074510122');
insert into DEPARTMENT (departmentid, name, location, phone)
values (338, 'Cardiology', 'M-1', '034293746');
insert into DEPARTMENT (departmentid, name, location, phone)
values (339, 'Obstetrics', 'D-7', '092323335');
insert into DEPARTMENT (departmentid, name, location, phone)
values (340, 'Emergency', 'Y-6', '047088569');
insert into DEPARTMENT (departmentid, name, location, phone)
values (341, 'Nutrition', 'C-2', '075978227');
insert into DEPARTMENT (departmentid, name, location, phone)
values (342, 'Physical', 'Y-1', '037942899');
insert into DEPARTMENT (departmentid, name, location, phone)
values (343, 'Neurology', 'H-7', '031915160');
insert into DEPARTMENT (departmentid, name, location, phone)
values (344, 'Radiology', 'X-4', '088787010');
insert into DEPARTMENT (departmentid, name, location, phone)
values (345, 'Neurology', 'Z-5', '086765014');
insert into DEPARTMENT (departmentid, name, location, phone)
values (346, 'Gynecology', 'Y-8', '024357595');
insert into DEPARTMENT (departmentid, name, location, phone)
values (347, 'Gynecology', 'A-4', '075475131');
insert into DEPARTMENT (departmentid, name, location, phone)
values (348, 'Pharmacy', 'K-2', '077700932');
insert into DEPARTMENT (departmentid, name, location, phone)
values (349, 'Emergency', 'L-1', '034867648');
insert into DEPARTMENT (departmentid, name, location, phone)
values (350, 'Orthopedics', 'O-4', '024967629');
insert into DEPARTMENT (departmentid, name, location, phone)
values (351, 'Oncology', 'I-7', '081526578');
insert into DEPARTMENT (departmentid, name, location, phone)
values (352, 'Radiology', 'I-9', '048006150');
insert into DEPARTMENT (departmentid, name, location, phone)
values (353, 'Pediatrics', 'N-2', '041895358');
insert into DEPARTMENT (departmentid, name, location, phone)
values (354, 'Intensive', 'Z-3', '096485959');
insert into DEPARTMENT (departmentid, name, location, phone)
values (355, 'Psychiatry', 'D-7', '048319118');
insert into DEPARTMENT (departmentid, name, location, phone)
values (356, 'Radiology', 'E-3', '098465687');
insert into DEPARTMENT (departmentid, name, location, phone)
values (357, 'Psychiatry', 'W-9', '082548136');
insert into DEPARTMENT (departmentid, name, location, phone)
values (358, 'Pediatrics', 'U-1', '033779734');
insert into DEPARTMENT (departmentid, name, location, phone)
values (359, 'Orthopedics', 'F-7', '074493397');
insert into DEPARTMENT (departmentid, name, location, phone)
values (360, 'Neurology', 'N-5', '044160669');
insert into DEPARTMENT (departmentid, name, location, phone)
values (361, 'Therapy', 'C-3', '092854225');
insert into DEPARTMENT (departmentid, name, location, phone)
values (362, 'Cardiology', 'E-9', '049957155');
insert into DEPARTMENT (departmentid, name, location, phone)
values (363, 'Surgery', 'S-3', '048184295');
insert into DEPARTMENT (departmentid, name, location, phone)
values (364, 'Orthopedics', 'Q-3', '037460482');
insert into DEPARTMENT (departmentid, name, location, phone)
values (365, 'Obstetrics', 'F-5', '098088270');
insert into DEPARTMENT (departmentid, name, location, phone)
values (366, 'Laboratory', 'S-8', '072529512');
insert into DEPARTMENT (departmentid, name, location, phone)
values (367, 'Obstetrics', 'Q-9', '049109492');
insert into DEPARTMENT (departmentid, name, location, phone)
values (368, 'Intensive', 'N-6', '048216553');
insert into DEPARTMENT (departmentid, name, location, phone)
values (369, 'Psychiatry', 'L-8', '096542010');
insert into DEPARTMENT (departmentid, name, location, phone)
values (370, 'Obstetrics', 'D-3', '044757814');
insert into DEPARTMENT (departmentid, name, location, phone)
values (371, 'Nutrition', 'J-3', '089440252');
insert into DEPARTMENT (departmentid, name, location, phone)
values (372, 'Oncology', 'N-3', '022414152');
insert into DEPARTMENT (departmentid, name, location, phone)
values (373, 'Nutrition', 'K-7', '087569384');
insert into DEPARTMENT (departmentid, name, location, phone)
values (374, 'Care', 'E-4', '099543346');
insert into DEPARTMENT (departmentid, name, location, phone)
values (375, 'Nutrition', 'P-4', '028501318');
insert into DEPARTMENT (departmentid, name, location, phone)
values (376, 'Radiology', 'N-6', '044766560');
insert into DEPARTMENT (departmentid, name, location, phone)
values (377, 'Obstetrics', 'D-9', '042577922');
insert into DEPARTMENT (departmentid, name, location, phone)
values (378, 'Oncology', 'V-8', '094471554');
insert into DEPARTMENT (departmentid, name, location, phone)
values (379, 'Therapy', 'H-7', '032596775');
insert into DEPARTMENT (departmentid, name, location, phone)
values (380, 'Laboratory', 'N-2', '037986012');
insert into DEPARTMENT (departmentid, name, location, phone)
values (381, 'Laboratory', 'P-4', '036888304');
insert into DEPARTMENT (departmentid, name, location, phone)
values (382, 'Nutrition', 'S-7', '037868627');
insert into DEPARTMENT (departmentid, name, location, phone)
values (383, 'Gynecology', 'D-4', '091508771');
insert into DEPARTMENT (departmentid, name, location, phone)
values (384, 'Intensive', 'E-8', '096715761');
insert into DEPARTMENT (departmentid, name, location, phone)
values (385, 'Nutrition', 'L-5', '089633962');
insert into DEPARTMENT (departmentid, name, location, phone)
values (386, 'Emergency', 'Q-1', '089980146');
insert into DEPARTMENT (departmentid, name, location, phone)
values (387, 'Gynecology', 'Q-3', '092465958');
insert into DEPARTMENT (departmentid, name, location, phone)
values (388, 'Care', 'N-4', '098357655');
insert into DEPARTMENT (departmentid, name, location, phone)
values (389, 'Physical', 'L-4', '023122582');
insert into DEPARTMENT (departmentid, name, location, phone)
values (390, 'Obstetrics', 'B-6', '073631179');
insert into DEPARTMENT (departmentid, name, location, phone)
values (391, 'Pediatrics', 'M-5', '048628544');
insert into DEPARTMENT (departmentid, name, location, phone)
values (392, 'Surgery', 'B-2', '099279595');
insert into DEPARTMENT (departmentid, name, location, phone)
values (393, 'Unit', 'T-2', '084331413');
insert into DEPARTMENT (departmentid, name, location, phone)
values (394, 'Laboratory', 'R-4', '022977194');
insert into DEPARTMENT (departmentid, name, location, phone)
values (395, 'Pharmacy', 'G-7', '041386811');
insert into DEPARTMENT (departmentid, name, location, phone)
values (396, 'Nutrition', 'R-7', '037137249');
insert into DEPARTMENT (departmentid, name, location, phone)
values (397, 'Therapy', 'O-8', '021458227');
insert into DEPARTMENT (departmentid, name, location, phone)
values (398, 'Gynecology', 'X-5', '035205174');
insert into DEPARTMENT (departmentid, name, location, phone)
values (399, 'Laboratory', 'F-3', '023019992');
insert into DEPARTMENT (departmentid, name, location, phone)
values (400, 'Nutrition', 'S-7', '075294407');
commit;
prompt 400 records committed...
insert into DEPARTMENT (departmentid, name, location, phone)
values (401, 'Oncology', 'V-8', '073699823');
insert into DEPARTMENT (departmentid, name, location, phone)
values (402, 'Therapy', 'Y-6', '025294298');
insert into DEPARTMENT (departmentid, name, location, phone)
values (403, 'Emergency', 'S-5', '048512371');
insert into DEPARTMENT (departmentid, name, location, phone)
values (404, 'Radiology', 'I-4', '023576333');
insert into DEPARTMENT (departmentid, name, location, phone)
values (405, 'Orthopedics', 'S-8', '095679944');
insert into DEPARTMENT (departmentid, name, location, phone)
values (406, 'Surgery', 'W-7', '035195562');
insert into DEPARTMENT (departmentid, name, location, phone)
values (407, 'Obstetrics', 'E-5', '098573485');
insert into DEPARTMENT (departmentid, name, location, phone)
values (408, 'Psychiatry', 'J-9', '087840505');
insert into DEPARTMENT (departmentid, name, location, phone)
values (409, 'Nutrition', 'W-2', '034198486');
insert into DEPARTMENT (departmentid, name, location, phone)
values (410, 'Gynecology', 'A-2', '086039733');
insert into DEPARTMENT (departmentid, name, location, phone)
values (411, 'Psychiatry', 'T-5', '024159308');
insert into DEPARTMENT (departmentid, name, location, phone)
values (412, 'Surgery', 'M-5', '033099115');
insert into DEPARTMENT (departmentid, name, location, phone)
values (413, 'Therapy', 'X-6', '049223865');
insert into DEPARTMENT (departmentid, name, location, phone)
values (414, 'Psychiatry', 'J-9', '041232986');
insert into DEPARTMENT (departmentid, name, location, phone)
values (415, 'Pharmacy', 'L-6', '035041273');
insert into DEPARTMENT (departmentid, name, location, phone)
values (416, 'Nutrition', 'E-6', '088177696');
insert into DEPARTMENT (departmentid, name, location, phone)
values (417, 'Psychiatry', 'Q-1', '022300430');
insert into DEPARTMENT (departmentid, name, location, phone)
values (418, 'Physical', 'Z-8', '088549618');
insert into DEPARTMENT (departmentid, name, location, phone)
values (419, 'Oncology', 'U-9', '087220038');
insert into DEPARTMENT (departmentid, name, location, phone)
values (420, 'Gynecology', 'W-1', '028144267');
insert into DEPARTMENT (departmentid, name, location, phone)
values (421, 'Radiology', 'X-3', '084792785');
insert into DEPARTMENT (departmentid, name, location, phone)
values (422, 'Radiology', 'J-1', '021581207');
insert into DEPARTMENT (departmentid, name, location, phone)
values (423, 'Radiology', 'Q-6', '089230840');
insert into DEPARTMENT (departmentid, name, location, phone)
values (424, 'Intensive', 'Y-4', '073993343');
insert into DEPARTMENT (departmentid, name, location, phone)
values (425, 'Cardiology', 'T-2', '036638902');
insert into DEPARTMENT (departmentid, name, location, phone)
values (426, 'Psychiatry', 'M-4', '088151588');
insert into DEPARTMENT (departmentid, name, location, phone)
values (427, 'Neurology', 'C-9', '043637332');
insert into DEPARTMENT (departmentid, name, location, phone)
values (428, 'Care', 'G-6', '037319225');
insert into DEPARTMENT (departmentid, name, location, phone)
values (429, 'Emergency', 'F-4', '033533897');
insert into DEPARTMENT (departmentid, name, location, phone)
values (430, 'Intensive', 'U-1', '036557027');
insert into DEPARTMENT (departmentid, name, location, phone)
values (431, 'Pediatrics', 'M-9', '088260770');
insert into DEPARTMENT (departmentid, name, location, phone)
values (432, 'Radiology', 'N-8', '037962903');
insert into DEPARTMENT (departmentid, name, location, phone)
values (433, 'Cardiology', 'R-8', '025716347');
insert into DEPARTMENT (departmentid, name, location, phone)
values (434, 'Surgery', 'S-2', '048740965');
insert into DEPARTMENT (departmentid, name, location, phone)
values (435, 'Nutrition', 'W-5', '045941424');
insert into DEPARTMENT (departmentid, name, location, phone)
values (436, 'Radiology', 'Z-9', '037866983');
insert into DEPARTMENT (departmentid, name, location, phone)
values (437, 'Nutrition', 'I-7', '079779023');
insert into DEPARTMENT (departmentid, name, location, phone)
values (438, 'Emergency', 'D-5', '021762708');
insert into DEPARTMENT (departmentid, name, location, phone)
values (439, 'Nutrition', 'W-9', '085879098');
insert into DEPARTMENT (departmentid, name, location, phone)
values (440, 'Pediatrics', 'Q-4', '039622981');
insert into DEPARTMENT (departmentid, name, location, phone)
values (441, 'Obstetrics', 'S-4', '048175900');
insert into DEPARTMENT (departmentid, name, location, phone)
values (442, 'Radiology', 'P-8', '076169433');
insert into DEPARTMENT (departmentid, name, location, phone)
values (443, 'Gynecology', 'C-8', '079849618');
insert into DEPARTMENT (departmentid, name, location, phone)
values (444, 'Surgery', 'G-1', '023445391');
insert into DEPARTMENT (departmentid, name, location, phone)
values (445, 'Pediatrics', 'Z-9', '045347352');
insert into DEPARTMENT (departmentid, name, location, phone)
values (446, 'Obstetrics', 'C-6', '098130896');
insert into DEPARTMENT (departmentid, name, location, phone)
values (447, 'Intensive', 'C-3', '021844177');
insert into DEPARTMENT (departmentid, name, location, phone)
values (448, 'Therapy', 'N-7', '047556873');
insert into DEPARTMENT (departmentid, name, location, phone)
values (449, 'Therapy', 'J-3', '092635364');
insert into DEPARTMENT (departmentid, name, location, phone)
values (450, 'Therapy', 'Z-4', '031446205');
insert into DEPARTMENT (departmentid, name, location, phone)
values (451, 'Gynecology', 'G-8', '099928404');
insert into DEPARTMENT (departmentid, name, location, phone)
values (452, 'Laboratory', 'T-6', '073218954');
insert into DEPARTMENT (departmentid, name, location, phone)
values (453, 'Psychiatry', 'F-3', '026410675');
insert into DEPARTMENT (departmentid, name, location, phone)
values (454, 'Oncology', 'J-8', '048782041');
insert into DEPARTMENT (departmentid, name, location, phone)
values (455, 'Surgery', 'K-6', '083368034');
insert into DEPARTMENT (departmentid, name, location, phone)
values (456, 'Oncology', 'V-6', '073892613');
insert into DEPARTMENT (departmentid, name, location, phone)
values (457, 'Therapy', 'F-5', '078083697');
insert into DEPARTMENT (departmentid, name, location, phone)
values (458, 'Psychiatry', 'Q-5', '077751699');
insert into DEPARTMENT (departmentid, name, location, phone)
values (459, 'Gynecology', 'S-2', '042318061');
insert into DEPARTMENT (departmentid, name, location, phone)
values (460, 'Neurology', 'C-6', '035263122');
insert into DEPARTMENT (departmentid, name, location, phone)
values (461, 'Neurology', 'H-5', '033921113');
insert into DEPARTMENT (departmentid, name, location, phone)
values (462, 'Unit', 'F-4', '044694323');
insert into DEPARTMENT (departmentid, name, location, phone)
values (463, 'Emergency', 'X-3', '085622230');
insert into DEPARTMENT (departmentid, name, location, phone)
values (464, 'Pediatrics', 'I-3', '086113521');
insert into DEPARTMENT (departmentid, name, location, phone)
values (465, 'Therapy', 'S-1', '087839997');
insert into DEPARTMENT (departmentid, name, location, phone)
values (466, 'Psychiatry', 'Z-3', '096263710');
insert into DEPARTMENT (departmentid, name, location, phone)
values (467, 'Psychiatry', 'A-1', '081519770');
insert into DEPARTMENT (departmentid, name, location, phone)
values (468, 'Gynecology', 'P-2', '024281096');
insert into DEPARTMENT (departmentid, name, location, phone)
values (469, 'Oncology', 'J-1', '023601361');
insert into DEPARTMENT (departmentid, name, location, phone)
values (470, 'Laboratory', 'N-1', '081186067');
insert into DEPARTMENT (departmentid, name, location, phone)
values (471, 'Physical', 'U-3', '084306217');
insert into DEPARTMENT (departmentid, name, location, phone)
values (472, 'Physical', 'V-3', '079181250');
insert into DEPARTMENT (departmentid, name, location, phone)
values (473, 'Physical', 'T-3', '041074985');
insert into DEPARTMENT (departmentid, name, location, phone)
values (474, 'Therapy', 'B-3', '083796078');
insert into DEPARTMENT (departmentid, name, location, phone)
values (475, 'Nutrition', 'E-8', '078245221');
insert into DEPARTMENT (departmentid, name, location, phone)
values (476, 'Laboratory', 'U-2', '036633119');
insert into DEPARTMENT (departmentid, name, location, phone)
values (477, 'Intensive', 'Y-7', '093497414');
insert into DEPARTMENT (departmentid, name, location, phone)
values (478, 'Radiology', 'O-2', '036210672');
insert into DEPARTMENT (departmentid, name, location, phone)
values (479, 'Intensive', 'S-6', '024278201');
insert into DEPARTMENT (departmentid, name, location, phone)
values (480, 'Obstetrics', 'H-7', '022971332');
insert into DEPARTMENT (departmentid, name, location, phone)
values (481, 'Emergency', 'F-6', '039894990');
insert into DEPARTMENT (departmentid, name, location, phone)
values (482, 'Orthopedics', 'G-7', '033249863');
insert into DEPARTMENT (departmentid, name, location, phone)
values (483, 'Neurology', 'I-2', '099328726');
insert into DEPARTMENT (departmentid, name, location, phone)
values (484, 'Pharmacy', 'L-6', '027678273');
insert into DEPARTMENT (departmentid, name, location, phone)
values (485, 'Radiology', 'G-7', '078093804');
insert into DEPARTMENT (departmentid, name, location, phone)
values (486, 'Cardiology', 'C-5', '044464028');
insert into DEPARTMENT (departmentid, name, location, phone)
values (487, 'Physical', 'W-6', '076248500');
insert into DEPARTMENT (departmentid, name, location, phone)
values (488, 'Neurology', 'T-9', '045021227');
insert into DEPARTMENT (departmentid, name, location, phone)
values (489, 'Unit', 'W-7', '045988432');
insert into DEPARTMENT (departmentid, name, location, phone)
values (490, 'Intensive', 'M-9', '023877016');
insert into DEPARTMENT (departmentid, name, location, phone)
values (491, 'Gynecology', 'R-3', '039701823');
insert into DEPARTMENT (departmentid, name, location, phone)
values (492, 'Pediatrics', 'B-6', '043428780');
insert into DEPARTMENT (departmentid, name, location, phone)
values (493, 'Psychiatry', 'J-1', '076991337');
insert into DEPARTMENT (departmentid, name, location, phone)
values (494, 'Surgery', 'B-4', '096304440');
insert into DEPARTMENT (departmentid, name, location, phone)
values (495, 'Intensive', 'W-8', '097535403');
insert into DEPARTMENT (departmentid, name, location, phone)
values (496, 'Oncology', 'L-8', '091590864');
insert into DEPARTMENT (departmentid, name, location, phone)
values (497, 'Surgery', 'U-6', '048834811');
insert into DEPARTMENT (departmentid, name, location, phone)
values (498, 'Unit', 'B-8', '074356551');
insert into DEPARTMENT (departmentid, name, location, phone)
values (499, 'Therapy', 'Y-2', '096430392');
insert into DEPARTMENT (departmentid, name, location, phone)
values (500, 'Obstetrics', 'Z-6', '039516793');
commit;
prompt 500 records loaded
prompt Loading DOCTOR...
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (148, 'Drucie Rothchild', 'Unit', '736-939-7525', 465);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (205, 'Stevana Trenoweth', 'Emergency', '585-212-2121', 122);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (158, 'Chrystel Bilham', 'Psychiatry', '738-575-9717', 127);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (333, 'Karee Cossey', 'Nutrition', '251-535-4132', 449);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (402, 'Sandi Peasee', 'Obstetrics', '251-325-8398', 372);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (83, 'Ricki Glendinning', 'Psychiatry', '463-226-5840', 447);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (12, 'Jordanna Sharer', 'Cardiology', '354-728-6821', 369);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (105, 'Elane Vitler', 'Care', '675-615-8450', 482);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (75, 'Madelyn Grattage', 'Orthopedics', '922-402-3081', 68);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (35, 'Rafaello Coupman', 'Physical', '737-591-0373', 403);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (18, 'Deloris Turnbull', 'Radiology', '438-918-7788', 129);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (256, 'Albertina Clue', 'Oncology', '507-864-3720', 406);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (403, 'Chastity Itskovitz', 'Nutrition', '518-207-7922', 231);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (308, 'Estrella Dallosso', 'Radiology', '417-755-6957', 483);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (122, 'Gillian Viles', 'Orthopedics', '596-957-8535', 201);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (409, 'Dolly Twiggins', 'Obstetrics', '374-430-9376', 265);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (331, 'Edgar Ornillos', 'Psychiatry', '217-182-5035', 362);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (490, 'Margalo Clampe', 'Orthopedics', '642-671-8762', 463);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (350, 'Grier McCrae', 'Cardiology', '656-915-2853', 129);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (154, 'Arnaldo Gutteridge', 'Radiology', '289-680-6745', 218);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (25, 'Valene Binnes', 'Obstetrics', '385-494-5267', 463);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (226, 'Faber Waycott', 'Radiology', '589-699-2831', 66);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (191, 'Kleon Roddy', 'Physical', '304-168-5735', 198);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (290, 'Marcelo Kirimaa', 'Psychiatry', '721-849-1336', 117);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (247, 'Melesa Winchurch', 'Nutrition', '573-386-1598', 319);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (86, 'Elita Gerding', 'Obstetrics', '401-365-2146', 229);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (326, 'Marlo Haselgrove', 'Neurology', '832-433-1325', 485);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (246, 'Bobbye Sussems', 'Unit', '478-711-1816', 404);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (471, 'Heddi Bath', 'Oncology', '951-351-1995', 478);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (113, 'Fidela Ladbrooke', 'Nutrition', '455-332-0189', 15);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (276, 'Blake Mayhou', 'Care', '667-532-3834', 185);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (168, 'Katine Capineer', 'Physical', '956-984-7769', 435);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (149, 'Robenia Carrabott', 'Neurology', '902-146-0537', 40);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (461, 'Lutero Doubrava', 'Pharmacy', '843-172-9896', 83);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (445, 'Adriana Morales', 'Obstetrics', '918-278-0482', 234);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (54, 'Arin Castiglioni', 'Gynecology', '441-309-0110', 132);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (19, 'Clint MacDonough', 'Oncology', '368-591-0062', 365);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (84, 'Jasmina Baumaier', 'Obstetrics', '406-843-4198', 450);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (155, 'Mareah Moretto', 'Radiology', '807-574-2104', 147);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (136, 'Boycie Brownsill', 'Nutrition', '692-612-1018', 346);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (278, 'Evangelina Appleyard', 'Neurology', '379-405-2553', 381);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (80, 'Tiebold Eyres', 'Nutrition', '477-562-0616', 178);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (379, 'Tybalt Killich', 'Pediatrics', '433-159-2497', 397);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (325, 'Hermie Cisland', 'Pharmacy', '230-651-8872', 126);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (493, 'Warden Gutierrez', 'Cardiology', '986-447-9958', 396);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (485, 'Clayborne Shank', 'Obstetrics', '502-942-5381', 416);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (23, 'Audie Bassilashvili', 'Oncology', '282-943-1693', 182);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (481, 'Carolynn Rosenthaler', 'Therapy', '590-666-5213', 127);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (212, 'Bondie Knolles-Green', 'Obstetrics', '405-988-2057', 177);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (438, 'Northrop Klebes', 'Gynecology', '971-507-6153', 500);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (347, 'Peg Clohissy', 'Nutrition', '228-555-1172', 271);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (344, 'Wallie Auld', 'Emergency', '947-766-0909', 209);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (192, 'Van Ellicombe', 'Cardiology', '373-209-8175', 479);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (98, 'Bram Hogsden', 'Orthopedics', '694-559-5364', 480);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (219, 'Quincy Doddemeade', 'Psychiatry', '570-982-7094', 440);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (473, 'Loutitia Snartt', 'Nutrition', '254-295-7197', 372);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (40, 'Osgood Schneidau', 'Gynecology', '492-346-3818', 383);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (488, 'Anabel Jannex', 'Physical', '866-381-9588', 277);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (175, 'Zorana Goble', 'Psychiatry', '207-518-3476', 173);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (8, 'Bronny Norkutt', 'Oncology', '720-899-5467', 12);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (292, 'Siffre McCreery', 'Neurology', '132-346-0413', 144);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (240, 'Peyton Partrick', 'Pharmacy', '473-427-2896', 119);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (171, 'Ashli Assender', 'Therapy', '964-761-9469', 136);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (91, 'Selby Allbon', 'Gynecology', '435-305-4972', 94);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (451, 'Euell Gouthier', 'Physical', '177-294-6786', 70);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (322, 'Harmon Meneghelli', 'Oncology', '315-842-1784', 72);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (229, 'Sharon Penhale', 'Nutrition', '317-734-3895', 187);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (207, 'Charita Chadbourne', 'Orthopedics', '386-333-4004', 159);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (49, 'Luce Smogur', 'Cardiology', '615-844-6415', 366);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (221, 'Charlton Doyle', 'Orthopedics', '631-774-5792', 45);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (499, 'Averill Aldersea', 'Oncology', '904-643-5151', 402);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (74, 'Cherie Roomes', 'Intensive', '807-133-4236', 129);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (423, 'Patton MacCorkell', 'Orthopedics', '295-653-6082', 262);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (374, 'Goran Dabourne', 'Obstetrics', '879-503-5006', 17);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (317, 'Valma Wilder', 'Cardiology', '529-865-2791', 85);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (220, 'Lenci Toupe', 'Neurology', '264-738-7984', 449);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (412, 'Carney Haney', 'Pharmacy', '523-798-5357', 394);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (31, 'Celene Traite', 'Physical', '456-333-9654', 149);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (430, 'Sam Nudde', 'Neurology', '762-290-9906', 493);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (291, 'Nial Chastanet', 'Gynecology', '786-961-1043', 128);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (336, 'Jessa Matteini', 'Therapy', '491-818-4097', 16);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (245, 'Ebony Teresia', 'Emergency', '235-708-4666', 88);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (106, 'Shirleen Birckmann', 'Orthopedics', '718-243-1682', 127);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (236, 'Roze Pattingson', 'Emergency', '608-154-2801', 288);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (476, 'Westbrook Coney', 'Neurology', '963-620-6981', 137);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (324, 'Darryl Pelman', 'Nutrition', '920-971-7325', 301);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (495, 'Silvester Klas', 'Laboratory', '665-492-1237', 212);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (392, 'Zitella Nassey', 'Radiology', '512-462-5693', 328);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (211, 'Meridel Stooders', 'Orthopedics', '101-416-6255', 107);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (456, 'Georgine Tumasian', 'Emergency', '798-316-0473', 4);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (179, 'Waring Pedroli', 'Care', '227-440-9305', 423);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (464, 'Reeba Hatherill', 'Pharmacy', '541-816-8782', 180);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (339, 'Saidee Kruszelnicki', 'Pediatrics', '741-308-7096', 80);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (223, 'Jana Eger', 'Orthopedics', '270-651-8947', 4);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (58, 'Ellynn Hadingham', 'Psychiatry', '342-831-1775', 156);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (73, 'Ardis Breckell', 'Therapy', '802-222-5473', 246);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (367, 'Shelli Giorgio', 'Oncology', '859-616-2600', 377);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (107, 'Mellisa Dongall', 'Pediatrics', '303-903-5491', 222);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (163, 'Malissia Hinrichsen', 'Laboratory', '813-925-1178', 492);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (399, 'Claudine Gilham', 'Nutrition', '526-549-5270', 473);
commit;
prompt 100 records committed...
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (448, 'Maren Ponton', 'Orthopedics', '701-796-3844', 156);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (382, 'Tillie Greeno', 'Pediatrics', '268-969-7062', 237);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (472, 'Mortie Million', 'Nutrition', '326-663-6004', 343);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (413, 'Even Beartup', 'Pediatrics', '234-238-0045', 403);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (289, 'Ariel Carratt', 'Therapy', '401-133-5884', 251);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (88, 'Mischa Grzegorek', 'Laboratory', '418-378-8504', 138);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (201, 'Glenine Rickards', 'Nutrition', '712-493-6232', 361);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (100, 'Brit Osler', 'Psychiatry', '669-369-6118', 395);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (6, 'Janeva Antognelli', 'Unit', '489-585-8792', 407);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (170, 'Silvester Marchand', 'Therapy', '476-664-8388', 133);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (241, 'Muire Binley', 'Psychiatry', '763-859-7032', 282);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (134, 'Letitia Kubik', 'Physical', '637-715-0263', 234);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (418, 'Sanson Bougourd', 'Obstetrics', '403-141-1248', 416);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (483, 'Olivia Killingworth', 'Obstetrics', '371-549-7722', 215);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (327, 'Franky Kunath', 'Physical', '968-446-3619', 208);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (424, 'Pepita Martland', 'Radiology', '874-287-8097', 264);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (103, 'Shirl Baldrick', 'Orthopedics', '131-718-7015', 116);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (259, 'Archaimbaud Bracco', 'Physical', '425-108-7841', 450);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (10, 'Humphrey Daburn', 'Emergency', '650-930-8431', 472);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (243, 'Candace Delahunt', 'Pharmacy', '586-992-3854', 355);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (404, 'Isabel Burbank', 'Unit', '715-519-2290', 425);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (44, 'Jodi Dornan', 'Care', '216-751-7313', 421);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (238, 'Lainey Edon', 'Pharmacy', '541-411-3792', 292);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (332, 'Zebedee Franklyn', 'Physical', '429-814-0462', 474);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (364, 'Esma McNeigh', 'Radiology', '616-780-8409', 388);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (365, 'Marisa Skullet', 'Gynecology', '707-670-8232', 437);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (164, 'Othello Spraberry', 'Therapy', '341-609-6996', 161);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (302, 'Kaitlyn Doggett', 'Gynecology', '266-947-5128', 315);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (161, 'Lonni Ruecastle', 'Nutrition', '493-374-0748', 421);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (426, 'Binni Quarterman', 'Laboratory', '105-582-8251', 44);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (446, 'Leslie Fallawe', 'Radiology', '727-291-5439', 80);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (1, 'Pernell Langthorn', 'Psychiatry', '539-175-1304', 439);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (153, 'Sherlocke Lagneaux', 'Nutrition', '397-483-3180', 414);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (363, 'Shawna Quidenham', 'Surgery', '243-635-5714', 417);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (368, 'Lanie Roe', 'Orthopedics', '516-792-9297', 329);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (459, 'Lori Andell', 'Physical', '953-308-1588', 387);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (111, 'Albina Sarjant', 'Intensive', '780-676-8407', 35);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (295, 'Becki Kembry', 'Pharmacy', '923-850-1506', 67);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (32, 'Fania Pogue', 'Orthopedics', '789-439-1509', 434);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (398, 'Wittie Winsor', 'Therapy', '265-945-8919', 105);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (150, 'Shaina Duckett', 'Unit', '437-576-2574', 7);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (3, 'Bald Danelutti', 'Physical', '726-262-3013', 387);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (267, 'Jelene Volker', 'Care', '749-939-8170', 32);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (65, 'Sherwood Divisek', 'Physical', '269-118-3826', 195);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (101, 'Suzann Benson', 'Laboratory', '692-898-0386', 212);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (457, 'Ilene Rennebach', 'Unit', '625-956-3072', 242);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (33, 'Barny Caile', 'Physical', '971-308-0171', 499);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (198, 'Archambault Schiersch', 'Nutrition', '425-713-9499', 362);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (356, 'Andra Erlam', 'Obstetrics', '380-757-4738', 257);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (330, 'Ilise Lowres', 'Oncology', '116-119-9107', 162);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (186, 'Murvyn Picopp', 'Pharmacy', '161-960-9905', 406);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (360, 'Vivian Spyvye', 'Therapy', '768-942-1565', 179);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (239, 'Darbee Luffman', 'Orthopedics', '434-859-1503', 474);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (372, 'Conrade Dreghorn', 'Obstetrics', '276-233-6290', 308);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (145, 'Ronna Reap', 'Intensive', '738-540-9396', 358);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (109, 'Chantalle Kelloch', 'Cardiology', '551-690-1229', 369);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (79, 'Garik Astbery', 'Psychiatry', '418-242-5523', 324);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (307, 'Darrin Basketfield', 'Intensive', '676-628-7031', 287);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (190, 'Hi McLauchlin', 'Neurology', '358-697-1626', 194);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (97, 'Niccolo Pobjoy', 'Orthopedics', '210-856-6345', 52);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (139, 'Isadora Oxtoby', 'Neurology', '986-288-6869', 63);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (321, 'Sibylla Domel', 'Cardiology', '954-672-1801', 241);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (349, 'Roby Lashmore', 'Cardiology', '336-515-3632', 189);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (183, 'Fina Gurnell', 'Orthopedics', '622-233-1960', 242);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (237, 'Harmon Purveys', 'Emergency', '962-631-8883', 364);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (411, 'Kale O''Toole', 'Neurology', '970-997-4200', 319);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (225, 'Milka Kee', 'Oncology', '783-403-9638', 452);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (114, 'Lauritz Strood', 'Gynecology', '443-110-0157', 43);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (196, 'Noam Busek', 'Nutrition', '954-942-4402', 32);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (449, 'Miguelita Ledgister', 'Radiology', '793-720-5987', 315);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (313, 'Colin Connal', 'Emergency', '229-809-7412', 279);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (137, 'Ade Coster', 'Emergency', '243-819-6016', 182);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (99, 'Rudyard Silverwood', 'Nutrition', '887-745-1228', 164);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (387, 'Reinhold Shepley', 'Pharmacy', '103-484-4167', 64);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (126, 'Stefano Hounihan', 'Emergency', '163-458-0774', 313);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (338, 'Luelle Christopherson', 'Care', '817-993-4951', 195);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (123, 'Lazar Sollars', 'Nutrition', '126-493-1859', 2);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (345, 'Deloris Derobert', 'Physical', '125-817-8494', 97);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (140, 'Emlen Abrey', 'Psychiatry', '522-139-5670', 237);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (62, 'Rafe Demkowicz', 'Cardiology', '686-230-7562', 296);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (354, 'Waylon Brooke', 'Pharmacy', '938-693-2605', 407);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (260, 'Allan Gronous', 'Intensive', '157-639-0241', 21);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (285, 'Mirna Stanistreet', 'Neurology', '992-141-0575', 386);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (43, 'Martina Freiburger', 'Orthopedics', '176-641-7554', 66);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (159, 'Christye Boerder', 'Physical', '278-571-3637', 389);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (174, 'Minnaminnie Pelosi', 'Obstetrics', '225-192-0698', 64);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (453, 'Garnet Gibbie', 'Unit', '293-425-7550', 234);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (125, 'Hussein Rowet', 'Psychiatry', '336-413-6107', 497);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (45, 'Lois Jeremaes', 'Gynecology', '533-858-1347', 214);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (165, 'Reamonn Tottie', 'Pediatrics', '104-599-3393', 446);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (217, 'Hadley Boate', 'Pharmacy', '266-701-8902', 492);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (130, 'Meggy Dami', 'Emergency', '182-787-5253', 28);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (362, 'Derron Abrey', 'Gynecology', '187-416-6009', 348);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (249, 'Clim Abrahamovitz', 'Radiology', '107-998-1540', 322);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (30, 'Shae Spuner', 'Pharmacy', '173-369-2828', 59);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (53, 'Jilli Eadmeades', 'Obstetrics', '593-827-1102', 453);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (92, 'Sayre Lavalde', 'Obstetrics', '749-342-7907', 11);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (252, 'Celestia Pinsent', 'Radiology', '834-477-5908', 271);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (469, 'Alejandra Chieco', 'Nutrition', '200-760-6162', 335);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (474, 'Costanza Dummett', 'Pediatrics', '477-545-1168', 430);
commit;
prompt 200 records committed...
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (396, 'Lindi Gamon', 'Neurology', '351-330-8846', 331);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (312, 'Glori Doody', 'Pharmacy', '410-479-1402', 255);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (417, 'Genni Dodworth', 'Pharmacy', '399-579-1800', 373);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (410, 'Carmelle Roll', 'Radiology', '685-880-4202', 274);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (162, 'Sandy Augustus', 'Cardiology', '925-781-9367', 403);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (194, 'Earl Shannon', 'Psychiatry', '617-275-6938', 80);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (353, 'Barnard Skeel', 'Care', '329-218-0317', 423);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (152, 'Joly Camplin', 'Pharmacy', '938-763-5716', 388);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (131, 'Dewain Sowle', 'Intensive', '397-411-4927', 75);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (17, 'Johannah Dowson', 'Unit', '925-699-7815', 307);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (261, 'Barrie Oldridge', 'Emergency', '993-568-8887', 179);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (300, 'Ambrosio Banck', 'Pediatrics', '265-362-5643', 300);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (104, 'Pieter Greenwood', 'Nutrition', '247-521-9094', 434);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (265, 'Marlon Mewrcik', 'Laboratory', '252-104-2795', 490);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (61, 'Katalin MacCallam', 'Laboratory', '732-773-8729', 124);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (208, 'Mattheus Gookey', 'Psychiatry', '900-273-3709', 202);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (178, 'Jeramey Featherstonhaugh', 'Laboratory', '725-744-0973', 105);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (206, 'Felic Elwin', 'Psychiatry', '218-991-2454', 9);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (468, 'Leese Cranstone', 'Neurology', '895-581-9649', 449);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (405, 'Clarine Haszard', 'Therapy', '990-975-5581', 30);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (215, 'Sandie Shakeshaft', 'Gynecology', '363-844-5213', 478);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (185, 'Cassandra Hickenbottom', 'Therapy', '809-189-6643', 110);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (407, 'Jennilee Guillot', 'Surgery', '473-667-0967', 82);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (425, 'Liane Ludye', 'Radiology', '729-653-9875', 24);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (420, 'Andrey Greetland', 'Laboratory', '438-325-8706', 173);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (320, 'Pasquale Kohn', 'Oncology', '840-171-5031', 431);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (93, 'Paddie Faiers', 'Gynecology', '471-393-8816', 76);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (266, 'Chelsy Tackett', 'Radiology', '610-148-6072', 303);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (15, 'Tonia Ratray', 'Intensive', '354-376-1210', 18);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (36, 'Lari Gjerde', 'Nutrition', '204-702-8232', 294);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (250, 'Nettle Seston', 'Orthopedics', '421-988-3669', 331);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (296, 'Estele Beadles', 'Physical', '130-171-0812', 337);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (115, 'Blinni Sizland', 'Nutrition', '816-983-0716', 232);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (293, 'Benoite Goodison', 'Pharmacy', '977-230-7620', 24);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (287, 'Paul Greetland', 'Intensive', '517-580-3331', 52);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (184, 'Durward Palay', 'Surgery', '971-144-8425', 420);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (369, 'Gaylord Acott', 'Neurology', '338-982-5739', 445);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (255, 'Nerti Gurys', 'Pharmacy', '847-953-9364', 140);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (37, 'Avrit Haslock(e)', 'Psychiatry', '665-710-5546', 194);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (491, 'Mariana Quenell', 'Oncology', '286-575-5928', 266);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (21, 'Regan Collacombe', 'Intensive', '464-670-0003', 125);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (124, 'Emilee Hourihan', 'Neurology', '423-253-4285', 218);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (482, 'Rebeca Bestwall', 'Unit', '239-606-3021', 351);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (182, 'Maureene Crewe', 'Obstetrics', '383-228-7294', 205);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (475, 'Meryl Maffin', 'Psychiatry', '900-921-3923', 470);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (64, 'Padgett Beecroft', 'Cardiology', '181-419-1055', 14);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (323, 'Derwin Fullun', 'Radiology', '836-132-0264', 177);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (231, 'Jakie Glaysher', 'Unit', '832-290-2271', 139);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (232, 'Marshal Doncaster', 'Radiology', '818-115-2462', 457);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (66, 'Cherlyn Cathersides', 'Laboratory', '924-339-3922', 323);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (342, 'Nickolas Simmonett', 'Psychiatry', '517-773-4375', 440);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (378, 'Melisa Sapson', 'Surgery', '321-909-6448', 77);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (132, 'Steffane Dummer', 'Cardiology', '477-813-4517', 76);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (358, 'Gibby Bauer', 'Care', '473-265-8190', 262);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (41, 'Mollee Coop', 'Surgery', '887-106-7927', 129);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (110, 'Terrill Bassom', 'Intensive', '340-733-9756', 367);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (128, 'Bear MacCaughen', 'Obstetrics', '754-317-4296', 215);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (95, 'Darcey Morcom', 'Cardiology', '144-671-1968', 410);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (7, 'Beatrisa Camblin', 'Laboratory', '532-104-1965', 413);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (26, 'Addy Labuschagne', 'Intensive', '596-233-0928', 293);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (277, 'Bird Gurden', 'Therapy', '767-168-1641', 26);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (286, 'Else Mitchall', 'Care', '289-725-0068', 369);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (14, 'Rich Bauduccio', 'Pediatrics', '670-281-0600', 280);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (455, 'Elwira Frazier', 'Emergency', '544-806-4747', 278);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (189, 'Rich Escalero', 'Obstetrics', '194-328-4677', 445);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (269, 'Aylmer Windous', 'Pharmacy', '629-733-1780', 420);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (251, 'Lodovico Comley', 'Oncology', '327-322-4420', 85);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (11, 'Mil Warlow', 'Nutrition', '193-147-9971', 131);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (383, 'Billye Clymer', 'Obstetrics', '204-313-0002', 233);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (258, 'Seline Warrillow', 'Therapy', '690-486-0668', 33);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (257, 'Kimberlee Boik', 'Physical', '128-526-5891', 340);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (465, 'Daisie Capron', 'Pharmacy', '446-157-9621', 388);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (480, 'Salaidh Benner', 'Oncology', '269-501-7488', 224);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (271, 'Nixie Veljes', 'Surgery', '751-150-5491', 307);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (81, 'Tomi Suttill', 'Intensive', '733-821-1369', 131);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (498, 'Grete Mardle', 'Neurology', '760-859-1710', 310);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (370, 'Randie Cockley', 'Care', '209-493-1767', 195);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (462, 'Querida Lownie', 'Care', '757-462-5124', 110);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (435, 'Slade Hylden', 'Pharmacy', '671-935-6385', 382);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (314, 'Frans Lillecrap', 'Nutrition', '568-420-7267', 471);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (415, 'Lorrie Petofi', 'Oncology', '900-395-8066', 251);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (371, 'Lin Rayment', 'Gynecology', '575-515-9755', 425);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (497, 'Constantine Andreoletti', 'Intensive', '704-162-0888', 498);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (439, 'Ethelbert Kubik', 'Radiology', '546-356-4137', 365);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (428, 'Jill Gareisr', 'Psychiatry', '440-665-7862', 35);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (463, 'Kim Crighton', 'Obstetrics', '461-333-3412', 120);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (422, 'Sissy Abercrombie', 'Therapy', '807-913-9288', 208);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (452, 'Kellby Bartolozzi', 'Care', '656-349-3738', 401);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (284, 'Mavra Sillett', 'Radiology', '663-514-3988', 204);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (197, 'Doy Patters', 'Nutrition', '876-448-8493', 219);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (384, 'Basile Milward', 'Pediatrics', '649-260-1044', 280);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (177, 'Thedrick Kellogg', 'Gynecology', '420-507-3051', 338);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (85, 'Rollin Antognazzi', 'Pharmacy', '770-336-5693', 73);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (242, 'Aimee Pagel', 'Pharmacy', '597-485-7316', 406);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (444, 'Gussie Vogl', 'Nutrition', '441-255-0625', 376);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (496, 'Rachael Pygott', 'Unit', '425-365-5908', 337);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (169, 'Austine Izhaky', 'Orthopedics', '827-105-2151', 104);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (492, 'Terry Ahern', 'Therapy', '847-482-9086', 81);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (303, 'Marthena Klimek', 'Laboratory', '563-408-5894', 472);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (301, 'Kipper Batt', 'Intensive', '165-855-6514', 366);
commit;
prompt 300 records committed...
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (366, 'Trevor Leitch', 'Radiology', '315-921-2950', 384);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (144, 'Gabriele Meachan', 'Obstetrics', '713-545-8723', 157);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (28, 'Saw Harrigan', 'Orthopedics', '939-105-4191', 57);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (20, 'Berti Prantl', 'Emergency', '253-578-4326', 84);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (436, 'Viviana Franckton', 'Physical', '695-545-6644', 224);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (343, 'Jefferey Kingham', 'Unit', '617-114-6530', 385);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (138, 'Jaimie Tritton', 'Laboratory', '546-700-6225', 217);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (441, 'Merill Siney', 'Radiology', '682-210-2377', 366);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (394, 'Val Bewlay', 'Unit', '926-184-2061', 335);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (142, 'Raquela Blanden', 'Cardiology', '793-675-8088', 58);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (427, 'Lilias Millbank', 'Pediatrics', '878-545-6770', 432);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (193, 'Lorrayne McArthur', 'Oncology', '111-641-9434', 292);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (200, 'Sonny Hammon', 'Nutrition', '352-180-3957', 377);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (466, 'Ophelie Cawcutt', 'Orthopedics', '523-142-2640', 448);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (437, 'Kurtis Trussell', 'Unit', '992-240-6303', 314);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (298, 'Ronnie Ivanov', 'Psychiatry', '839-338-8465', 134);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (393, 'Jeanie Attenborough', 'Unit', '279-959-3964', 433);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (204, 'Joseito Glasscott', 'Cardiology', '170-830-4698', 31);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (160, 'Elka Wimms', 'Pharmacy', '653-853-0726', 120);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (377, 'Silvie Capron', 'Psychiatry', '234-850-1453', 337);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (176, 'Chaim Lindenberg', 'Surgery', '956-427-2728', 27);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (431, 'Dougie Carmody', 'Unit', '378-543-6457', 148);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (341, 'Barrie Siddell', 'Pharmacy', '357-440-9304', 435);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (57, 'Aron Aizlewood', 'Care', '206-596-7042', 47);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (489, 'Sibby Kivell', 'Cardiology', '106-442-0768', 282);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (346, 'Langsdon MacBean', 'Unit', '676-328-9706', 450);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (133, 'Dru Laslett', 'Care', '965-158-2552', 238);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (294, 'Tucky Coase', 'Cardiology', '427-565-1060', 363);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (143, 'Natassia Christauffour', 'Cardiology', '139-402-4491', 284);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (50, 'Elberta Mansbridge', 'Obstetrics', '858-301-3549', 57);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (213, 'Geralda Shoebotham', 'Psychiatry', '258-845-6507', 285);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (120, 'Anatole Ledgister', 'Orthopedics', '101-807-9668', 422);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (22, 'Ida Almeida', 'Neurology', '523-680-6097', 186);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (395, 'Ramsay Louche', 'Care', '544-598-0819', 162);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (434, 'Gabriello Trewett', 'Obstetrics', '431-383-3717', 27);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (359, 'Ulick Gowler', 'Cardiology', '998-495-5143', 305);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (195, 'Tuck Matuszynski', 'Oncology', '304-881-2276', 268);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (16, 'Jordan Olijve', 'Nutrition', '934-703-8473', 2);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (440, 'Petronella Spittall', 'Pediatrics', '949-643-5262', 142);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (447, 'Guy Schutter', 'Physical', '123-215-7767', 169);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (68, 'Margaret Agass', 'Psychiatry', '597-685-0882', 198);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (310, 'Chrystal Daldry', 'Pediatrics', '760-204-5944', 431);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (470, 'Halsy MacKeeg', 'Psychiatry', '284-513-5481', 474);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (5, 'Marcello Mably', 'Psychiatry', '290-739-7545', 48);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (385, 'Bebe Schenkel', 'Laboratory', '264-891-4444', 301);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (288, 'Joli MacUchadair', 'Obstetrics', '720-146-2122', 471);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (218, 'Murdoch Wiggins', 'Care', '359-203-2520', 130);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (82, 'Velma McRobert', 'Care', '624-995-9404', 84);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (55, 'Lew Tearny', 'Physical', '486-551-2412', 480);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (458, 'Susi Tribe', 'Nutrition', '279-739-4090', 128);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (282, 'Ronnie Shoutt', 'Therapy', '921-778-2440', 233);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (416, 'Zaneta Elce', 'Pediatrics', '377-201-7340', 141);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (13, 'Alberta Hilldrup', 'Cardiology', '275-140-8104', 348);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (500, 'Jeana McGarry', 'Unit', '890-865-0466', 293);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (454, 'Josie Redwall', 'Psychiatry', '397-397-8134', 128);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (253, 'Beauregard Clyant', 'Therapy', '460-181-1552', 75);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (4, 'Ibby Galpen', 'Radiology', '264-229-8591', 427);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (270, 'Ernie Barff', 'Neurology', '446-141-9041', 96);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (59, 'Evanne Dawidowsky', 'Care', '781-485-6115', 262);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (340, 'Karen Arington', 'Laboratory', '172-505-3679', 54);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (173, 'Gale Tawse', 'Neurology', '904-360-0924', 236);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (335, 'Jana Daleman', 'Neurology', '975-888-4159', 459);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (373, 'Giff Tondeur', 'Therapy', '617-525-8378', 397);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (118, 'Townsend Deverale', 'Emergency', '454-116-1234', 289);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (352, 'Ashlan Tytterton', 'Pharmacy', '354-132-4425', 70);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (421, 'Kellen Hayhoe', 'Physical', '625-102-9103', 232);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (39, 'Rochette Semple', 'Neurology', '782-206-7802', 276);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (494, 'Kristine Etherington', 'Radiology', '254-867-4402', 193);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (222, 'Myer Paszek', 'Obstetrics', '691-535-6169', 288);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (117, 'Dusty Layzell', 'Emergency', '952-894-7308', 324);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (235, 'Marga Osgar', 'Pediatrics', '368-151-3319', 367);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (268, 'Bliss Draisey', 'Radiology', '188-127-1115', 346);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (391, 'Corri Wilton', 'Radiology', '222-435-4742', 92);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (244, 'Tristam Wollaston', 'Obstetrics', '671-844-3956', 257);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (375, 'Blake Baroux', 'Neurology', '722-647-0258', 448);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (78, 'Arlyne Tomik', 'Oncology', '735-743-5120', 390);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (27, 'Luci Franciotti', 'Cardiology', '747-158-5840', 57);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (228, 'Geoff Bellworthy', 'Therapy', '423-563-7996', 414);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (275, 'Temp Hayter', 'Cardiology', '263-892-8197', 349);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (52, 'Nickolaus Damsell', 'Oncology', '877-494-8412', 242);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (429, 'Astrix Witherop', 'Psychiatry', '992-870-0845', 311);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (319, 'Towney Oxer', 'Physical', '730-579-5206', 114);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (9, 'Lorrin Miquelet', 'Emergency', '675-246-0603', 321);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (29, 'Berty Rief', 'Unit', '474-941-4211', 303);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (102, 'Lucretia Bromehed', 'Radiology', '267-960-4015', 430);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (254, 'Wylma Ramshay', 'Cardiology', '997-401-5654', 421);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (390, 'Gunter Moyles', 'Gynecology', '889-132-8571', 29);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (406, 'Rayshell Keegan', 'Pharmacy', '278-325-2576', 367);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (274, 'Edik Caffin', 'Care', '168-673-3940', 57);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (156, 'Barbabra Linke', 'Physical', '241-978-5135', 428);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (72, 'Maurise Dunning', 'Neurology', '825-722-8285', 278);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (147, 'Dorita Newbegin', 'Orthopedics', '668-652-9624', 56);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (305, 'Phebe Gilffilland', 'Unit', '404-809-6350', 210);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (67, 'Madalyn Vaszoly', 'Orthopedics', '957-740-0597', 400);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (273, 'Thaine De Matteis', 'Cardiology', '117-646-8009', 366);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (467, 'Julie Robinet', 'Unit', '555-461-2390', 29);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (414, 'Trever Dagnan', 'Psychiatry', '986-466-1501', 471);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (248, 'Ailina Orto', 'Pediatrics', '328-301-6015', 299);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (381, 'Samara Busch', 'Therapy', '927-286-1058', 67);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (203, 'Domenic Unitt', 'Orthopedics', '461-221-4795', 58);
commit;
prompt 400 records committed...
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (351, 'Onida Canner', 'Pediatrics', '460-811-6541', 410);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (484, 'Johanna Runnacles', 'Gynecology', '279-475-9830', 89);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (60, 'Kasey Benettolo', 'Psychiatry', '589-388-9455', 235);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (127, 'Selestina Bwye', 'Psychiatry', '362-216-3006', 498);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (63, 'Skipp Faulder', 'Psychiatry', '989-658-4397', 410);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (304, 'Emlynne Rubinowitz', 'Obstetrics', '882-812-2998', 193);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (129, 'Elbertina Moodie', 'Psychiatry', '761-584-1786', 149);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (146, 'Jakie Beamson', 'Pediatrics', '126-850-0235', 449);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (262, 'Cordie Christopher', 'Orthopedics', '627-330-4698', 322);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (315, 'Davine Fice', 'Psychiatry', '450-198-6173', 477);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (348, 'Michal Fewkes', 'Surgery', '955-427-2604', 145);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (408, 'Charity Aldwinckle', 'Cardiology', '850-335-1436', 274);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (432, 'Hilton Afield', 'Surgery', '838-246-2171', 268);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (180, 'Debora Lorraway', 'Nutrition', '463-794-5167', 50);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (309, 'Mattie Leiden', 'Nutrition', '582-429-7647', 90);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (380, 'Walt Harbar', 'Orthopedics', '432-531-9477', 346);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (279, 'Eileen Snelman', 'Neurology', '886-899-4019', 317);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (334, 'Xever Dunkinson', 'Surgery', '733-913-1409', 255);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (87, 'Sebastian Tiller', 'Radiology', '171-594-3755', 468);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (389, 'Inness Delgado', 'Radiology', '229-482-7445', 17);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (299, 'Mallorie Tommasuzzi', 'Intensive', '854-580-5525', 14);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (121, 'Aurlie Plail', 'Radiology', '452-923-6848', 85);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (397, 'Regen Duckerin', 'Intensive', '366-112-0055', 254);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (419, 'Loella Denisovo', 'Obstetrics', '589-470-0854', 248);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (2, 'Cynthy McCloughlin', 'Intensive', '569-469-2552', 167);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (24, 'Eduardo MacKinnon', 'Radiology', '307-662-8265', 184);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (34, 'Mirna Brandsma', 'Obstetrics', '760-309-9313', 105);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (38, 'Alyosha Batman', 'Care', '718-803-6068', 478);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (42, 'Grethel Ughetti', 'Nutrition', '331-452-1886', 337);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (46, 'Mic Coyish', 'Surgery', '952-503-2534', 210);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (47, 'Lorin Hehnke', 'Surgery', '358-382-2172', 37);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (48, 'Hortense Melpuss', 'Gynecology', '648-310-8970', 259);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (51, 'Myriam Beaglehole', 'Oncology', '404-575-7651', 283);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (56, 'Giselbert Oguz', 'Therapy', '737-383-6552', 491);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (69, 'Alexina Trowsdall', 'Pharmacy', '651-565-6824', 154);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (70, 'Portie Egger', 'Obstetrics', '454-598-8080', 7);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (71, 'Krystle Tremolieres', 'Laboratory', '224-623-3497', 245);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (76, 'Betsey Mallia', 'Unit', '327-147-5242', 76);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (77, 'Cyndie Thamelt', 'Care', '282-396-4180', 433);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (89, 'Myer Mebes', 'Physical', '201-944-2456', 451);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (90, 'Felike Patten', 'Psychiatry', '173-464-2772', 194);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (94, 'Marten Elwood', 'Radiology', '361-578-7786', 483);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (96, 'Meris Follet', 'Surgery', '755-589-7662', 17);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (108, 'Christie Butter', 'Radiology', '679-494-8791', 427);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (112, 'Werner Benaine', 'Emergency', '254-125-3794', 167);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (116, 'Daveen Danilewicz', 'Cardiology', '695-901-1370', 204);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (119, 'Ade Devil', 'Cardiology', '780-255-4506', 103);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (135, 'Babb Wicher', 'Gynecology', '297-428-5756', 155);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (141, 'Henrie Keaveney', 'Neurology', '806-163-9798', 191);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (151, 'Joeann Sked', 'Physical', '114-330-2333', 56);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (157, 'Debora Aleshintsev', 'Care', '953-802-3536', 82);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (166, 'Darell Bass', 'Neurology', '409-232-5041', 63);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (167, 'Nerte Andriveau', 'Gynecology', '240-880-7779', 213);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (172, 'Dasha Dobing', 'Laboratory', '166-440-0564', 119);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (181, 'Roland Tizzard', 'Obstetrics', '252-945-6460', 476);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (187, 'Selina Callen', 'Therapy', '135-419-2081', 125);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (188, 'Tresa O''Lagene', 'Psychiatry', '786-275-9912', 497);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (199, 'Kristo Dinis', 'Unit', '625-290-8207', 490);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (202, 'Tatiania Dimitresco', 'Psychiatry', '435-784-7244', 420);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (209, 'Janith Haldon', 'Care', '664-370-8028', 176);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (210, 'Jacquenetta Eitter', 'Radiology', '177-108-6992', 82);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (214, 'Indira Howlings', 'Pediatrics', '688-223-3736', 250);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (216, 'Lorna Drewry', 'Nutrition', '837-204-7967', 77);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (224, 'Ari Pattemore', 'Laboratory', '563-516-6734', 409);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (227, 'Sidnee Andresser', 'Physical', '404-746-1187', 166);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (230, 'Tann Gallahue', 'Cardiology', '151-281-0456', 252);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (233, 'Sela Labin', 'Radiology', '966-169-3449', 192);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (234, 'Emilio Phin', 'Cardiology', '941-493-8219', 154);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (263, 'Lilias Goretti', 'Radiology', '559-288-2700', 331);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (264, 'Birdie Eyam', 'Psychiatry', '842-818-9438', 482);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (272, 'Donal Eble', 'Radiology', '702-239-9142', 101);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (280, 'Barri Earley', 'Emergency', '932-452-8687', 350);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (281, 'Maura Guirardin', 'Intensive', '568-798-4627', 373);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (283, 'Deborah Weatherburn', 'Unit', '192-666-1886', 131);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (297, 'Brad Cleworth', 'Emergency', '128-714-4334', 60);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (306, 'Ilaire Thamelt', 'Nutrition', '205-821-1738', 300);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (311, 'Denver Tarr', 'Nutrition', '902-818-1760', 365);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (316, 'Berkie Brookson', 'Cardiology', '301-700-3968', 446);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (318, 'Waverley Seymer', 'Oncology', '969-199-7154', 196);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (328, 'Farris Fourman', 'Obstetrics', '886-141-9384', 390);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (329, 'Ciel Leighfield', 'Pediatrics', '131-781-7217', 127);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (337, 'Warde Burthom', 'Pharmacy', '864-573-5304', 164);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (355, 'Brenn Crowder', 'Pediatrics', '411-724-9653', 361);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (357, 'Claudian Tantum', 'Emergency', '678-101-2979', 1);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (361, 'Berky Umbers', 'Laboratory', '525-474-6832', 221);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (376, 'Linn Annesley', 'Oncology', '306-131-7830', 15);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (386, 'Delia Leborgne', 'Obstetrics', '967-797-6831', 402);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (388, 'Annis Mereweather', 'Psychiatry', '158-464-9817', 425);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (400, 'Marci Dolder', 'Laboratory', '103-880-0680', 27);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (401, 'Rey Doughill', 'Care', '833-589-9531', 101);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (433, 'Kesley Curnnok', 'Laboratory', '986-560-0981', 116);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (442, 'Noell Doppler', 'Therapy', '799-165-9706', 426);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (443, 'Dasi Kleinhaus', 'Obstetrics', '202-914-9120', 93);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (450, 'Woodie Siggens', 'Nutrition', '352-377-6461', 118);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (460, 'Ardine Heikkinen', 'Laboratory', '804-984-1183', 309);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (477, 'Star Bancroft', 'Surgery', '456-102-9541', 225);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (478, 'Emmalee Eicheler', 'Pediatrics', '508-197-7911', 321);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (479, 'Monika Kilfedder', 'Psychiatry', '743-302-5936', 161);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (486, 'Yovonnda Bunclark', 'Orthopedics', '915-896-4533', 366);
insert into DOCTOR (doctorid, name, specialty, phone, departmentid)
values (487, 'Barry Spensley', 'Gynecology', '735-645-6705', 15);
commit;
prompt 500 records loaded
prompt Loading MEDICATION...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (1, 'Rhus toxicodendron', 'Drainage of Left Vertebral Artery, Percutaneous Approach', to_date('22-06-2023', 'dd-mm-yyyy'), 32, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (2, 'fluvoxamine maleate', 'Occlusion of Asc Colon with Extralum Dev, Perc Endo Approach', to_date('02-10-2024', 'dd-mm-yyyy'), 31, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (3, 'Platinum metallicum', 'Revision of Infusion Dev in Fem Perineum, Perc Endo Approach', to_date('20-02-2022', 'dd-mm-yyyy'), 41, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (4, 'norethindrone acetate/ethinyl estradiol', 'Supplement L Abd Bursa/Lig w Synth Sub, Perc Endo', to_date('11-03-2007', 'dd-mm-yyyy'), 35, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (5, 'SULFUR', 'Reposition Right Testis, Open Approach', to_date('04-01-2016', 'dd-mm-yyyy'), 15, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (6, 'Hamamelis Aesculus', 'Drain R Metacarpocarp Jt w Drain Dev, Perc Endo', to_date('14-05-2019', 'dd-mm-yyyy'), 35, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (7, 'acetaminophen', 'Dilate R Int Mamm Art, Bifurc, w 2 Drug-elut, Open', to_date('02-11-2014', 'dd-mm-yyyy'), 11, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (8, 'DIPHENHYDRAMINE HYDROCHLORIDE', 'Revision of Extraluminal Device in Low Art, Open Approach', to_date('13-05-2010', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (9, 'Phenylephrine Hydrochloride', 'Revise of Synth Sub in Sacrococcygeal Jt, Perc Endo Approach', to_date('28-05-2026', 'dd-mm-yyyy'), 14, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (10, 'Fexofenadine HCl', 'Bypass L Atrium to Pulm Vn Cnfl with Autol Vn, Open Approach', to_date('17-05-2022', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (11, 'Colchicum autumnale', 'Bypass L Hypogast Vein to Low Vein w Autol Art, Perc Endo', to_date('27-06-2016', 'dd-mm-yyyy'), 23, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (12, 'Amino acids', 'Bypass L Great Saphenous to Low Vein w Synth Sub, Open', to_date('01-03-2010', 'dd-mm-yyyy'), 13, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (13, 'Chlorpromazine Hydrochloride', 'Aural Rehabilitation Status Assessment using AV Equipment', to_date('10-06-2024', 'dd-mm-yyyy'), 27, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (14, 'Arnica Montana', 'Change Drainage Device in Liver, External Approach', to_date('17-01-2016', 'dd-mm-yyyy'), 13, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (15, 'Asparagus', 'Bypass R Innom Vein to Up Vein w Nonaut Sub, Perc Endo', to_date('19-04-2026', 'dd-mm-yyyy'), 31, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (16, 'LISINOPRIL', 'Extirpate matter from L Ankle Bursa/Lig, Perc Endo', to_date('21-10-2016', 'dd-mm-yyyy'), 16, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (17, 'Lidocaine Hydrochloride', 'Restrict Pancreat Duct w Intralum Dev, Perc Endo', to_date('21-05-2020', 'dd-mm-yyyy'), 30, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (18, 'octocrylene', 'Bypass L Com Iliac Art to R Femor A w Synth Sub, Open', to_date('06-12-2010', 'dd-mm-yyyy'), 39, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (19, 'Menthol', 'Excision of Upper Back, Percutaneous Approach', to_date('05-12-2020', 'dd-mm-yyyy'), 40, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (20, 'eomycin sulfate', 'Removal of Drainage Device from Low Back, Perc Endo Approach', to_date('02-11-2007', 'dd-mm-yyyy'), 11, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (21, 'GLYCERIN', 'Excision of Left External Iliac Artery, Perc Approach, Diagn', to_date('24-04-2013', 'dd-mm-yyyy'), 18, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (23, 'Arnica montana', 'Destruction of Left Inguinal Lymphatic, Perc Endo Approach', to_date('28-06-2009', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (24, 'ARSENIC TRIOXIDE - IPECAC - STRYCHNOS NUX-VOMICA SEED - VERATRUM ALBUM ROOT -', 'Removal of Infusion Device from L Hip Jt, Perc Endo Approach', to_date('27-07-2025', 'dd-mm-yyyy'), 41, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (26, 'Veratrum Album', 'Reposition Right Acetabulum, Perc Endo Approach', to_date('25-02-2021', 'dd-mm-yyyy'), 15, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (27, 'Lisinopril', 'Release Scalp Subcutaneous Tissue and Fascia, Perc Approach', to_date('24-11-2011', 'dd-mm-yyyy'), 32, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (29, 'Octinoxate ', 'Fluoroscopy of Right Pulmonary Artery using H Osm Contrast', to_date('26-06-2018', 'dd-mm-yyyy'), 20, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (30, 'Loratadine', 'Dilate R Ext Iliac Art w Drug-elut Intra, Perc Endo', to_date('15-05-2010', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (32, 'Neisseria Meningitidis Group Y Capsular Polysaccharide Antigen', 'Restriction of Right Hand Artery, Open Approach', to_date('26-12-2025', 'dd-mm-yyyy'), 43, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (33, 'Medi-First', 'Supplement R Int Carotid with Synth Sub, Perc Endo Approach', to_date('08-11-2023', 'dd-mm-yyyy'), 35, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (35, 'Ondansetron Hydrochloride', 'Insertion of Reservoir into Abd Subcu/Fascia, Perc Approach', to_date('26-11-2024', 'dd-mm-yyyy'), 31, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (36, 'verapamil hydrochloride', 'Drainage of Right Common Iliac Vein, Perc Approach, Diagn', to_date('13-04-2025', 'dd-mm-yyyy'), 45, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (38, 'Nux vomica', 'Excision of Anus, Via Natural or Artificial Opening, Diagn', to_date('08-02-2020', 'dd-mm-yyyy'), 29, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (40, 'Ceftriaxone Sodium', 'Bypass L Fem Art to Peron Art with Synth Sub, Open Approach', to_date('12-11-2010', 'dd-mm-yyyy'), 24, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (41, 'Pilocarpine Hydrochloride', 'CT Scan of Neck using L Osm Contrast, Unenh, Enhance', to_date('11-11-2026', 'dd-mm-yyyy'), 15, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (43, 'Platinum metallicum', 'Dilation of R Ext Iliac Art with 2 Drug-elut, Perc Approach', to_date('07-12-2014', 'dd-mm-yyyy'), 30, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (44, 'cromolyn sodium', 'Occlusion of Ascending Colon with Intralum Dev, Via Opening', to_date('01-07-2019', 'dd-mm-yyyy'), 28, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (45, 'Equisetum hyemale', 'Removal of Autol Sub from L Humeral Head, Open Approach', to_date('15-11-2023', 'dd-mm-yyyy'), 17, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (47, 'TITANIUM DIOXIDE', 'Excision of L Abd Bursa/Lig, Perc Endo Approach', to_date('23-06-2013', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (49, 'Simvastatin', 'Supplement L Ring Finger with Nonaut Sub, Perc Endo Approach', to_date('14-06-2026', 'dd-mm-yyyy'), 16, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (50, 'Pilocarpus', 'Drainage of Ileocecal Valve, Percutaneous Approach', to_date('22-01-2019', 'dd-mm-yyyy'), 22, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (52, 'SUS SCROFA UMBILICAL CORD', 'Excision of Left Toe Phalangeal Joint, Percutaneous Approach', to_date('01-08-2019', 'dd-mm-yyyy'), 36, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (53, 'OCTOCRYLENE', 'Supplement R Int Carotid with Synth Sub, Perc Endo Approach', to_date('26-04-2010', 'dd-mm-yyyy'), 39, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (55, 'Sulphuricum acidum', 'Insertion of Reservoir into Abd Subcu/Fascia, Perc Approach', to_date('10-03-2018', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (56, 'Imipenem', 'MRI of Bi Pelvic Vein using Oth Contrast, Unenh, Enhance', to_date('10-06-2014', 'dd-mm-yyyy'), 27, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (57, 'Pulsatilla', 'Supplement R Foot Art with Autol Sub, Perc Endo Approach', to_date('04-04-2020', 'dd-mm-yyyy'), 44, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (59, 'Carduus marianus', 'Excision of Right Innominate Vein, Percutaneous Approach', to_date('09-05-2008', 'dd-mm-yyyy'), 45, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (60, 'glyburide', 'Introduce Oth Therap Subst in Periph Nrv, Plexi, Perc', to_date('08-08-2020', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (62, 'ciprofloxacin', 'Removal of Radioactive Element from Lower Jaw, Perc Approach', to_date('19-12-2026', 'dd-mm-yyyy'), 41, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (63, 'Octinoxate ', 'Supplement Left Foot Vein with Synth Sub, Perc Endo Approach', to_date('11-11-2005', 'dd-mm-yyyy'), 46, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (65, 'zolpidem tartrate', 'Destruction of Chest Skin, External Approach', to_date('17-07-2011', 'dd-mm-yyyy'), 10, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (66, 'Octinoxate', 'Extirpation of Matter from L Foot Art, Bifurc, Open Approach', to_date('18-06-2022', 'dd-mm-yyyy'), 11, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (68, 'Alanine', 'Insertion of Stimulator Lead into Bladder, Via Opening', to_date('15-06-2008', 'dd-mm-yyyy'), 33, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (69, 'Gnaphalium polycephalum', 'Reposition Left Radius, Percutaneous Endoscopic Approach', to_date('06-01-2015', 'dd-mm-yyyy'), 35, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (71, 'Baclofen', 'Excision of Nasal Septum, Perc Endo Approach, Diagn', to_date('17-12-2012', 'dd-mm-yyyy'), 20, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (72, 'Lamotrigine', 'Restriction of Cystic Duct, Percutaneous Approach', to_date('18-04-2021', 'dd-mm-yyyy'), 12, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (74, 'Zinc. met.', 'Replacement of L Kidney Pelvis with Synth Sub, Open Approach', to_date('07-04-2017', 'dd-mm-yyyy'), 36, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (75, 'Simethicone', 'Fusion of Left Wrist Joint with Synth Sub, Perc Approach', to_date('18-03-2020', 'dd-mm-yyyy'), 47, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (77, 'PROLINE', 'Repair Left Hip Joint, Percutaneous Endoscopic Approach', to_date('09-01-2019', 'dd-mm-yyyy'), 26, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (78, 'ascorbic acid', 'Revision of Autologous Tissue Substitute in R Breast, Endo', to_date('15-02-2022', 'dd-mm-yyyy'), 10, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (79, 'OCTINOXATE', 'Fragmentation in Right Parotid Duct, External Approach', to_date('10-05-2010', 'dd-mm-yyyy'), 24, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (80, 'Phenylephrine hydrochloride', 'Bypass L Int Iliac Art to L Femor A w Nonaut Sub, Open', to_date('04-06-2026', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (81, 'Phosphorus', 'Revision of Extraluminal Device in Low Art, Open Approach', to_date('20-10-2013', 'dd-mm-yyyy'), 48, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (82, 'Carbamazepine', 'CT Scan of Neck using L Osm Contrast, Unenh, Enhance', to_date('21-11-2008', 'dd-mm-yyyy'), 32, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (83, 'Acetaminophen', 'Extirpate matter from Chordae Tendineae, Perc Endo', to_date('28-04-2022', 'dd-mm-yyyy'), 37, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (84, 'Mesquite', 'Supplement Buccal Mucosa with Autol Sub, Extern Approach', to_date('10-04-2014', 'dd-mm-yyyy'), 26, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (85, 'OCTINOXATE OCTISALATE OXYBENZONE', 'Bypass Abd Aorta to B Int Ilia w Autol Vn, Perc Endo', to_date('26-06-2022', 'dd-mm-yyyy'), 19, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (86, 'SODIUM FLUORIDE', 'Excision of Buccal Mucosa, Percutaneous Approach', to_date('24-05-2007', 'dd-mm-yyyy'), 46, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (87, 'Octisalate', 'Destruction of Esophagogastric Junction, Perc Approach', to_date('22-12-2018', 'dd-mm-yyyy'), 19, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (88, 'Lidocaine Hydrochloride', 'Resection of Left Superior Parathyroid Gland, Open Approach', to_date('26-12-2013', 'dd-mm-yyyy'), 20, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (89, 'Heal Grief', 'Revision of Synth Sub in L Sacroiliac Jt, Perc Approach', to_date('21-11-2018', 'dd-mm-yyyy'), 45, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (90, 'Phenylephrine HCl', 'Restriction of L Radial Art with Extralum Dev, Open Approach', to_date('24-04-2019', 'dd-mm-yyyy'), 42, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (91, 'Meradimate', 'Fusion of Right Finger Phalangeal Joint, Open Approach', to_date('27-09-2020', 'dd-mm-yyyy'), 17, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (92, 'Irbesartan', 'Drainage of Genitalia Skin, External Approach, Diagnostic', to_date('07-09-2015', 'dd-mm-yyyy'), 31, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (93, 'olmesartan medoxomil', 'Insertion of Other Device into Upper Jaw, Perc Approach', to_date('09-11-2010', 'dd-mm-yyyy'), 12, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (94, 'LAMOTRIGINE', 'Removal of Drainage Device from Left Eye, External Approach', to_date('14-11-2011', 'dd-mm-yyyy'), 41, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (95, 'Fluoxetine Hydrochloride', 'Supplement L Verteb Vein with Nonaut Sub, Open Approach', to_date('05-01-2021', 'dd-mm-yyyy'), 32, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (96, 'Paroxetine Hydrochloride', 'Revision of Extraluminal Device in Low Art, Open Approach', to_date('21-04-2008', 'dd-mm-yyyy'), 21, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (97, 'Mycobacterium phlei', 'Bypass L Atrium to Pulm Vn Cnfl with Autol Vn, Open Approach', to_date('17-06-2019', 'dd-mm-yyyy'), 13, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (98, 'Podofilox', 'Excision of Left External Iliac Artery, Perc Approach, Diagn', to_date('04-04-2014', 'dd-mm-yyyy'), 16, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (100, 'Homosalate', 'Insertion of Intralum Dev into L Renal Vein, Open Approach', to_date('15-05-2014', 'dd-mm-yyyy'), 45, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (101, 'Coumarinum', 'Repair Right Clavicle, Percutaneous Endoscopic Approach', to_date('03-03-2007', 'dd-mm-yyyy'), 32, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (103, 'levodopa', 'Bypass L Com Iliac Art to R Femor A w Synth Sub, Open', to_date('02-10-2005', 'dd-mm-yyyy'), 33, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (104, 'TITANIUM DIOXIDE', 'Transfer Lower Lip, External Approach', to_date('01-01-2023', 'dd-mm-yyyy'), 19, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (106, 'OCTINOXATE', 'Revision of Nonaut Sub in Cervcal Vertebra, Open Approach', to_date('23-07-2019', 'dd-mm-yyyy'), 26, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (107, 'Soft Cheat Brome', 'Drainage of Left Brachial Vein, Percutaneous Approach, Diagn', to_date('18-08-2013', 'dd-mm-yyyy'), 31, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (109, 'Naja', 'Replacement of L Temporal Bone with Autol Sub, Open Approach', to_date('22-06-2026', 'dd-mm-yyyy'), 42, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (111, 'Ondansetron Hydrochloride', 'Insertion of Other Device into R Knee, Perc Approach', to_date('15-03-2024', 'dd-mm-yyyy'), 40, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (112, 'Sugar Maple', 'Excision of Left Face Vein, Open Approach, Diagnostic', to_date('08-12-2026', 'dd-mm-yyyy'), 42, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (114, 'Divalproex sodium', 'Removal of Autol Sub from L Eye, Extern Approach', to_date('16-06-2025', 'dd-mm-yyyy'), 25, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (115, 'Hepar suis', 'Excision of Left Femoral Shaft, Percutaneous Approach', to_date('25-11-2014', 'dd-mm-yyyy'), 34, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (117, 'Lidocaine Hydrochloride', 'Drain of L Trunk Muscle with Drain Dev, Perc Endo Approach', to_date('12-10-2021', 'dd-mm-yyyy'), 20, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (118, 'Cocklebur', 'Supplement Right 1st Toe with Synth Sub, Perc Endo Approach', to_date('19-12-2019', 'dd-mm-yyyy'), 20, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (120, 'Equisetum hyemale', 'Excision of Left Toe Phalangeal Joint, Percutaneous Approach', to_date('15-05-2019', 'dd-mm-yyyy'), 26, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (121, 'SENNOSIDES', 'Excision of Anus, Via Natural or Artificial Opening, Diagn', to_date('13-12-2024', 'dd-mm-yyyy'), 34, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (123, 'Hamamelis Aesculus', 'Excision of Left Femoral Shaft, Percutaneous Approach', to_date('28-03-2017', 'dd-mm-yyyy'), 26, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (124, 'OCTINOXATE', 'Resection of Large Intestine, Endo', to_date('12-05-2009', 'dd-mm-yyyy'), 48, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (126, 'Pregnenolone', 'Dilate L Int Mamm Art, Bifurc, w Drug-elut Intra, Perc Endo', to_date('02-02-2016', 'dd-mm-yyyy'), 14, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (127, 'Phenylephrine Hydrochloride', 'Drainage of Right Sphenoid Bone, Perc Endo Approach, Diagn', to_date('17-09-2026', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (129, 'DIMETHICONE', 'Supplement L Up Arm Muscle with Nonaut Sub, Open Approach', to_date('11-12-2015', 'dd-mm-yyyy'), 43, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (131, 'SENNOSIDES', 'Replacement of Up Tooth, All, with Autol Sub, Open Approach', to_date('22-08-2010', 'dd-mm-yyyy'), 19, '3');
commit;
prompt 100 records committed...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (132, 'Oxygen', 'Bypass L Int Jugular Vein to Up Vein w Nonaut Sub, Perc Endo', to_date('23-04-2015', 'dd-mm-yyyy'), 48, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (134, 'Nicotine Polacrilex', 'Removal of Drain Dev from Cisterna Chyli, Perc Endo Approach', to_date('16-12-2009', 'dd-mm-yyyy'), 33, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (135, 'Sodium Monofluorophosphate Silicon Dioxide', 'Drainage of Right Thyroid Gland Lobe, Perc Endo Approach', to_date('14-04-2009', 'dd-mm-yyyy'), 25, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (137, 'rizatriptan benzoate', 'Supplement L Temporomandib Jt with Autol Sub, Open Approach', to_date('05-05-2022', 'dd-mm-yyyy'), 21, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (138, 'meloxicam', 'Dilate L Ext Carotid, Bifurc, w Drug-elut Intra, Perc', to_date('07-08-2014', 'dd-mm-yyyy'), 14, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (140, 'Zaleplon', 'Drainage of Bilateral Fallopian Tubes, Endo', to_date('03-10-2013', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (141, 'Thuja occidentalis', 'Inspection of Right Ankle Joint, Perc Endo Approach', to_date('21-09-2015', 'dd-mm-yyyy'), 21, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (143, 'Oak Mix', 'Revision of Int Fix in Lum Jt, Perc Approach', to_date('14-11-2021', 'dd-mm-yyyy'), 43, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (144, 'bacitracin zinc', 'Excision of Left Femoral Shaft, Percutaneous Approach', to_date('09-10-2005', 'dd-mm-yyyy'), 19, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (146, 'Natrum carbonicum', 'Replacement of Right Ureter with Nonaut Sub, Open Approach', to_date('27-02-2008', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (147, 'ALUMINUM HYDROXIDE', 'Revision of Int Fix in L Humeral Shaft, Extern Approach', to_date('13-05-2012', 'dd-mm-yyyy'), 46, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (149, 'Fluoxetine Hydrochloride', 'Revision of Drainage Device in R Carpal Jt, Extern Approach', to_date('22-12-2022', 'dd-mm-yyyy'), 47, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (150, 'Hydrogen Peroxide', 'Bypass R Vas Deferens to R Vas Def w Synth Sub,', to_date('05-11-2010', 'dd-mm-yyyy'), 43, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (152, 'sodium phosphate', 'Fragmentation in Common Bile Duct, Open Approach', to_date('16-11-2022', 'dd-mm-yyyy'), 24, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (153, 'LEUCINE', 'Restriction of R Neck Lymph with Extralum Dev, Perc Approach', to_date('09-03-2024', 'dd-mm-yyyy'), 32, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (155, 'Calcium carbonate', 'Excision of Rectum, Via Natural or Artificial Opening', to_date('26-07-2008', 'dd-mm-yyyy'), 11, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (157, 'Serine', 'Extirpate matter from L Shoulder Bursa/Lig, Perc Endo', to_date('01-04-2008', 'dd-mm-yyyy'), 19, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (158, 'avobenzone', 'Removal of Synthetic Substitute from Urethra, Via Opening', to_date('01-04-2016', 'dd-mm-yyyy'), 17, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (160, 'acebutolol hydrochloride', 'CT Scan of Cereb Vent using H Osm Contrast, Unenh, Enhance', to_date('19-05-2016', 'dd-mm-yyyy'), 36, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (161, 'Imipenem', 'Removal of Drain Dev from Cisterna Chyli, Perc Endo Approach', to_date('12-10-2018', 'dd-mm-yyyy'), 37, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (162, 'GLYCERIN', 'HDR Brachytherapy of Chest Wall using Palladium 103', to_date('01-11-2012', 'dd-mm-yyyy'), 44, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (163, 'Bellis perennis', 'Creation of Penis in Female Perineum, Open Approach', to_date('28-08-2023', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (164, 'Soft Cheat Brome', 'Supplement R Thorax Bursa/Lig with Autol Sub, Open Approach', to_date('20-03-2026', 'dd-mm-yyyy'), 16, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (165, 'Dextromethorphan HBr', 'Extirpation of Matter from R Sperm Cord, Perc Approach', to_date('19-07-2005', 'dd-mm-yyyy'), 29, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (166, 'SERINE', 'Dilate Sup Mesent Art, Bifurc, w Intralum Dev, Perc Endo', to_date('10-02-2006', 'dd-mm-yyyy'), 40, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (167, 'desvenlafaxine', 'Revision of Int Fix in R Femur Shaft, Perc Endo Approach', to_date('07-12-2016', 'dd-mm-yyyy'), 38, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (168, 'ENSULIZOLE', 'Drainage of Hyoid Bone, Percutaneous Endoscopic Approach', to_date('06-03-2025', 'dd-mm-yyyy'), 26, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (169, 'Zinc Oxide', 'Bypass R Axilla Art to R Extracran Art w Autol Art, Open', to_date('27-04-2011', 'dd-mm-yyyy'), 12, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (170, 'Guaifenesin', 'Replace of Pancreat Duct with Synth Sub, Perc Endo Approach', to_date('16-04-2025', 'dd-mm-yyyy'), 30, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (171, 'Serine', 'Beam Radiation of Urethra using Electrons', to_date('23-03-2020', 'dd-mm-yyyy'), 37, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (172, 'Oxymorphone hydrochloride', 'Revision of Monitor Dev in Cranial Nrv, Extern Approach', to_date('14-03-2011', 'dd-mm-yyyy'), 24, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (173, 'Hypericum perforatum', 'Dilate R Ext Iliac Art w Drug-elut Intra, Perc Endo', to_date('20-02-2010', 'dd-mm-yyyy'), 39, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (174, 'Arnica montana', 'Change Splint on Face', to_date('10-08-2005', 'dd-mm-yyyy'), 16, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (175, 'TITANIUM DIOXIDE', 'Release Right Toe Phalangeal Joint, Perc Endo Approach', to_date('21-04-2014', 'dd-mm-yyyy'), 48, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (176, 'morphine sulfate', 'Insertion of Other Device into L Wrist, Perc Approach', to_date('24-11-2012', 'dd-mm-yyyy'), 28, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (177, 'Sorbitol', 'Transfer Left Upper Leg Muscle, Open Approach', to_date('18-06-2025', 'dd-mm-yyyy'), 38, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (178, 'TITANIUM DIOXIDE', 'Removal of Drain Dev from R Finger Phalanx Jt, Open Approach', to_date('03-08-2006', 'dd-mm-yyyy'), 36, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (179, 'Isosorbide Dinitrate', 'Resection of Left Superior Parathyroid Gland, Open Approach', to_date('14-01-2010', 'dd-mm-yyyy'), 47, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (180, 'Pulsatilla', 'Dilate R Int Carotid, Bifurc, w 3 Drug-elut, Perc Endo', to_date('23-09-2018', 'dd-mm-yyyy'), 44, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (182, 'Olanzapine', 'Destruction of Right Palatine Bone, Percutaneous Approach', to_date('03-07-2005', 'dd-mm-yyyy'), 11, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (183, 'Cinnamic Acid', 'Insertion of Stimulator Lead into Bladder, Via Opening', to_date('25-08-2006', 'dd-mm-yyyy'), 39, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (184, 'Arnica Aurum 6 10', 'Division of Cervical Nerve, Open Approach', to_date('23-07-2016', 'dd-mm-yyyy'), 11, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (186, 'Phosphorus', 'Replacement of Right Eye with Synth Sub, Perc Approach', to_date('15-07-2016', 'dd-mm-yyyy'), 19, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (187, 'METHIONINE', 'Insertion of Infusion Device into Left Atrium, Open Approach', to_date('21-04-2018', 'dd-mm-yyyy'), 33, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (189, 'Ibuprofen', 'Removal of Extraluminal Device from Bladder, Open Approach', to_date('26-06-2018', 'dd-mm-yyyy'), 19, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (190, 'Mirtazapine', 'Extirpation of Matter from L Fem Art, Open Approach', to_date('12-08-2014', 'dd-mm-yyyy'), 21, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (192, 'guaifenesin', 'Excision of R Temporomandib Jt, Perc Endo Approach, Diagn', to_date('21-03-2022', 'dd-mm-yyyy'), 17, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (193, 'Octinoxate', 'Drainage of Left Vertebral Artery, Percutaneous Approach', to_date('17-08-2016', 'dd-mm-yyyy'), 25, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (195, 'Citalopram', 'Drain R Metacarpocarp Jt w Drain Dev, Perc Endo', to_date('28-07-2026', 'dd-mm-yyyy'), 40, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (196, 'neomycin sulfate', 'Supplement Cervical Nerve with Autol Sub, Perc Endo Approach', to_date('24-03-2014', 'dd-mm-yyyy'), 32, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (198, 'Colchicum autumnale', 'Supplement Sacrococcygeal Jt with Autol Sub, Open Approach', to_date('06-12-2008', 'dd-mm-yyyy'), 29, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (199, 'Menthol', 'Replacement of Sup Mesent Art with Autol Sub, Open Approach', to_date('16-05-2010', 'dd-mm-yyyy'), 30, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (201, 'Ammonium Bromatum', 'Excision of Cervical Vertebral Joint, Open Approach', to_date('14-01-2025', 'dd-mm-yyyy'), 33, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (202, 'Lycopodium Clavatum', 'Revision of Monitoring Device in Stomach, Via Opening', to_date('14-10-2013', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (204, 'Kali phosphoricum', 'Replacement of Right Eye with Synth Sub, Perc Approach', to_date('17-09-2021', 'dd-mm-yyyy'), 33, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (205, 'Phosphorus', 'Transfer Left Upper Leg Muscle, Open Approach', to_date('03-09-2013', 'dd-mm-yyyy'), 47, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (207, 'Sulphuricum acidum', 'Supplement L Temporomandib Jt with Autol Sub, Open Approach', to_date('08-02-2014', 'dd-mm-yyyy'), 14, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (208, 'Niacinamide', 'Replacement of Up Tooth, All, with Autol Sub, Open Approach', to_date('06-10-2020', 'dd-mm-yyyy'), 11, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (210, 'verapamil hydrochloride', 'Insertion of Other Device into L Wrist, Perc Approach', to_date('02-06-2021', 'dd-mm-yyyy'), 36, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (211, 'Riboflavinum', 'Beam Radiation of Radius/Ulna using Neutron Capture', to_date('11-07-2020', 'dd-mm-yyyy'), 32, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (213, 'Lamotrigine', 'Insertion of Other Device into L Wrist, Perc Approach', to_date('18-07-2026', 'dd-mm-yyyy'), 24, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (214, 'Mesquite', 'Supplement L Sacroiliac Jt w Nonaut Sub, Perc Endo', to_date('26-01-2015', 'dd-mm-yyyy'), 41, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (216, 'Apis mel.', 'Removal of Synth Sub from L Low Femur, Perc Approach', to_date('17-11-2014', 'dd-mm-yyyy'), 30, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (217, 'Acetaminophen', 'Destruction of Right Radius, Open Approach', to_date('25-06-2023', 'dd-mm-yyyy'), 12, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (219, 'ALCOHOL', 'Reposition L Up Femur with Monopln Ext Fix, Perc Approach', to_date('03-01-2024', 'dd-mm-yyyy'), 23, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (220, 'Plantago major', 'Revision of Neuro Lead in Cranial Nrv, Open Approach', to_date('10-07-2015', 'dd-mm-yyyy'), 41, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (222, 'Chlorpromazine Hydrochloride', 'Beam Radiation of Radius/Ulna using Neutron Capture', to_date('18-06-2016', 'dd-mm-yyyy'), 21, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (224, 'fentanyl transdermal system', 'Excision of Right Eustachian Tube, Open Approach, Diagnostic', to_date('08-05-2012', 'dd-mm-yyyy'), 13, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (225, 'Ammonium Bromatum', 'Occlusion of L Fem Art with Intralum Dev, Perc Endo Approach', to_date('23-06-2009', 'dd-mm-yyyy'), 38, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (227, 'fluocinolone acetonide', 'Change Drainage Device in Liver, External Approach', to_date('14-11-2018', 'dd-mm-yyyy'), 10, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (228, 'Veratrum album', 'Dilation of L Axilla Art with Drug-elut Intra, Open Approach', to_date('18-10-2015', 'dd-mm-yyyy'), 37, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (229, 'Natrum muriaticum', 'Introduction of Oth Therap Subst into Eye, Via Opening', to_date('21-05-2005', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (231, 'Atropa Belladonna', 'Supplement L Verteb Vein with Nonaut Sub, Open Approach', to_date('07-05-2006', 'dd-mm-yyyy'), 18, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (233, 'Germanium sesquioxide', 'Revision of Nonaut Sub in Penis, Open Approach', to_date('12-05-2013', 'dd-mm-yyyy'), 12, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (234, 'Carbo vegetabilis', 'Removal of Nonaut Sub from Mouth/Throat, Endo', to_date('01-03-2016', 'dd-mm-yyyy'), 30, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (236, 'Dog Hair Canis spp.', 'Introduce Oth Therap Subst in Male Reprod, Perc', to_date('04-10-2011', 'dd-mm-yyyy'), 44, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (237, 'Ferrum metallicum', 'Supplement L Ventricle with Zooplastic, Perc Endo Approach', to_date('17-09-2007', 'dd-mm-yyyy'), 18, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (239, 'Oxymorphone hydrochloride', 'Destruction of Right Greater Saphenous Vein, Perc Approach', to_date('07-10-2012', 'dd-mm-yyyy'), 33, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (240, 'Oak Mix', 'Extirpate matter from Uterine Support Struct, Perc Endo', to_date('26-11-2025', 'dd-mm-yyyy'), 40, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (241, 'HYDROMORPHONE HYDROCHLORIDE', 'Revise of Infusion Dev in R Metatarsotars Jt, Open Approach', to_date('27-01-2025', 'dd-mm-yyyy'), 47, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (242, 'Duloxetine', 'Release Optic Nerve, Percutaneous Endoscopic Approach', to_date('27-04-2022', 'dd-mm-yyyy'), 17, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (243, 'cow milk', 'Revise Synth Sub in Prostate/Seminal Ves, Perc Endo', to_date('23-02-2007', 'dd-mm-yyyy'), 24, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (244, 'Sodium Bicarbonate', 'Dilate L Ext Carotid, Bifurc, w Drug-elut Intra, Perc', to_date('08-07-2022', 'dd-mm-yyyy'), 29, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (245, 'Ranitidine', 'Replacement of Up Tooth, All, with Autol Sub, Open Approach', to_date('08-08-2020', 'dd-mm-yyyy'), 35, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (246, 'Ibuprofen', 'Excision of Cervical Vertebral Joint, Open Approach', to_date('26-12-2021', 'dd-mm-yyyy'), 36, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (247, 'Terebinthina', 'Removal of Synth Sub from Cranial Cav, Perc Endo Approach', to_date('09-05-2005', 'dd-mm-yyyy'), 25, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (248, 'ZINC OXIDE', 'Release Left Finger Phalanx, Open Approach', to_date('22-08-2014', 'dd-mm-yyyy'), 37, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (249, 'Bupropion Hydrochloride', 'Inspection of Left Foot, Percutaneous Endoscopic Approach', to_date('03-03-2014', 'dd-mm-yyyy'), 22, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (250, 'Neisseria Meningitidis Group Y Capsular Polysaccharide Antigen', 'Reposition L Humeral Head with Hybrid Ext Fix, Open Approach', to_date('22-12-2009', 'dd-mm-yyyy'), 43, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (251, 'Miconazole Nitrate', 'Revision of Other Device in Pericard Cav, Perc Endo Approach', to_date('11-05-2013', 'dd-mm-yyyy'), 10, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (252, 'Glipizide', 'Insertion of Other Device into Upper Jaw, Perc Approach', to_date('08-05-2009', 'dd-mm-yyyy'), 22, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (253, 'PIPERACILLIN', 'Supplement Hemiazygos Vein with Synth Sub, Perc Approach', to_date('22-06-2013', 'dd-mm-yyyy'), 29, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (254, 'Alprazolam', 'Removal of Drainage Device from Left Eye, External Approach', to_date('25-06-2010', 'dd-mm-yyyy'), 34, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (255, 'Argentum nitricum', 'Excision of Glomus Jugulare, Percutaneous Approach', to_date('17-04-2007', 'dd-mm-yyyy'), 42, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (256, 'Rhus toxicodendron', 'Drainage of Left Upper Arm Tendon, Open Approach, Diagnostic', to_date('13-07-2009', 'dd-mm-yyyy'), 33, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (257, 'Spleen (suis)', 'Revision of Infusion Dev in Fem Perineum, Perc Endo Approach', to_date('06-07-2025', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (258, 'Crotalus horridus', 'Fluoroscopy of L Temporomand Jt using Oth Contrast', to_date('02-10-2019', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (259, 'ZINC OXIDE', 'Bypass Colic Vein to Low Vein with Autol Art, Open Approach', to_date('03-02-2023', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (260, 'Ranitidine', 'Revise Tissue Expander in Up Extrem Subcu/Fascia, Open', to_date('15-04-2005', 'dd-mm-yyyy'), 24, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (262, 'Gabapentin', 'Detachment at Left 4th Toe, Low, Open Approach', to_date('22-01-2009', 'dd-mm-yyyy'), 26, '2');
commit;
prompt 200 records committed...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (263, 'SODIUM FLUORIDE', 'Introduce Electrol/Water Bal in Central Vein, Open', to_date('24-07-2017', 'dd-mm-yyyy'), 21, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (265, 'Natrum muriaticum', 'Destruction of Left Inguinal Lymphatic, Perc Endo Approach', to_date('25-01-2024', 'dd-mm-yyyy'), 39, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (266, 'OCTINOXATE', 'Dilation of R Post Tib Art with 3 Drug-elut, Open Approach', to_date('15-05-2008', 'dd-mm-yyyy'), 10, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (268, 'ARSENIC TRIOXIDE - IPECAC - STRYCHNOS NUX-VOMICA SEED - VERATRUM ALBUM ROOT -', 'Dilate L Com Carotid, Bifurc, w 4 Drug-elut, Perc', to_date('05-02-2025', 'dd-mm-yyyy'), 37, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (270, 'Glonoinum', 'Bypass R Radial Art to Low Arm Vein w Autol Art, Open', to_date('24-04-2013', 'dd-mm-yyyy'), 44, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (271, 'Octinoxate', 'Removal of Synth Sub from L Clavicle, Perc Endo Approach', to_date('05-12-2005', 'dd-mm-yyyy'), 11, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (272, 'avobenzone', 'Fusion of Right Finger Phalangeal Joint, Open Approach', to_date('20-04-2020', 'dd-mm-yyyy'), 33, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (274, 'Dyclonine Hydrochloride', 'Dilation of Portal Vein with Intralum Dev, Perc Approach', to_date('11-07-2018', 'dd-mm-yyyy'), 39, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (276, 'sodium monofluorophosphate', 'Replacement of Right Eye with Synth Sub, Perc Approach', to_date('05-07-2006', 'dd-mm-yyyy'), 23, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (277, 'vobenzone', 'Bypass L Int Iliac Art to L Femor A w Nonaut Sub, Open', to_date('13-07-2011', 'dd-mm-yyyy'), 13, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (279, 'Titanium Dioxide', 'Change Other Device in Up Intest Tract, Extern Approach', to_date('19-06-2021', 'dd-mm-yyyy'), 31, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (280, 'Carbamazepine', 'Introduce of Local Anesth into Mouth/Phar, Extern Approach', to_date('17-12-2006', 'dd-mm-yyyy'), 16, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (282, 'Doxepin Hydrochloride', 'Supplement L Axilla Art with Synth Sub, Perc Endo Approach', to_date('22-08-2009', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (283, 'Guaifenesin', 'Restrict Cystic Duct w Intralum Dev, Perc Endo', to_date('08-12-2019', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (285, 'PHENYLALANINE', 'Revision of Other Device in Cranial Cavity, Extern Approach', to_date('01-06-2006', 'dd-mm-yyyy'), 22, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (286, 'Pulsatilla', 'Replacement of L Temporal Bone with Autol Sub, Open Approach', to_date('19-04-2008', 'dd-mm-yyyy'), 48, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (288, 'Ceanothus americanus', 'Reposition Left Foot Muscle, Perc Endo Approach', to_date('12-04-2005', 'dd-mm-yyyy'), 23, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (289, 'ferrous gluconate', 'Replace of Papillary Muscle with Nonaut Sub, Open Approach', to_date('06-09-2006', 'dd-mm-yyyy'), 15, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (291, 'Phosphorus', 'LDR Brachytherapy of Pancreas using Californium 252', to_date('13-11-2015', 'dd-mm-yyyy'), 30, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (292, 'DEXTROSE MONOHYDRATE', 'Revision of Int Fix in Lum Jt, Perc Approach', to_date('22-08-2016', 'dd-mm-yyyy'), 35, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (294, 'Cuprum Aceticum 3', 'Hyperthermia of Hard Palate', to_date('28-09-2024', 'dd-mm-yyyy'), 28, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (295, 'TOXICODENDRON PUBESCENS LEAF', 'Removal of Autol Sub from Coccyx, Perc Endo Approach', to_date('12-09-2012', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (297, 'Dibasic', 'Reposition Left Radius, Percutaneous Endoscopic Approach', to_date('27-06-2019', 'dd-mm-yyyy'), 37, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (298, 'Titanium Dioxide', 'Replacement of L Atrium with Zooplastic, Perc Endo Approach', to_date('18-06-2025', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (300, 'temazepam', 'Alteration of R Axilla with Nonaut Sub, Perc Endo Approach', to_date('08-01-2016', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (301, 'Ethyl Alcohol', 'Dilate Celiac Art w Drug-elut Intra, Perc Endo', to_date('24-08-2017', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (303, 'Gerbil Epithelia', 'Monitoring of Gastrointestinal Pressure, Endo', to_date('16-06-2026', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (304, 'chlorine', 'Exercise Treatment of Circ Body using Assist Equipment', to_date('16-09-2018', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (306, 'Argentum Viscum', 'Fluoroscopy of Right Pulmonary Artery using H Osm Contrast', to_date('07-10-2013', 'dd-mm-yyyy'), 38, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (307, 'ATP (Adenosine Triphosphate Disodium)', 'Excision of Glomus Jugulare, Percutaneous Approach', to_date('10-12-2009', 'dd-mm-yyyy'), 37, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (309, 'Cantharis', 'Supplement L Ring Finger with Nonaut Sub, Perc Endo Approach', to_date('05-11-2015', 'dd-mm-yyyy'), 37, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (310, 'ONDANSETRON', 'Dilation of Pulmonary Valve, Open Approach', to_date('15-02-2011', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (312, 'urea', 'Reposition L Sphenoid Bone with Int Fix, Perc Endo Approach', to_date('28-01-2007', 'dd-mm-yyyy'), 28, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (313, 'Hydrocortisone', 'CT Scan L Pelvic Vein w H Osm Contrast, Unenh, Enhance', to_date('02-04-2020', 'dd-mm-yyyy'), 40, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (314, 'AVOBENZONE', 'Bypass Abd Aorta to B Int Ilia w Autol Vn, Perc Endo', to_date('17-02-2026', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (316, 'Sepia', 'Transfer Left Upper Leg Muscle, Open Approach', to_date('23-08-2016', 'dd-mm-yyyy'), 36, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (317, 'Deer Hair', 'Supplement Left Foot Vein with Synth Sub, Open Approach', to_date('13-04-2011', 'dd-mm-yyyy'), 31, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (319, 'Aspirin', 'Alteration of Left Axilla with Autol Sub, Perc Endo Approach', to_date('26-07-2018', 'dd-mm-yyyy'), 14, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (320, 'azithromycin', 'Replacement of Left Eye with Autol Sub, Perc Approach', to_date('06-05-2009', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (321, 'Ondansetron Hydrochloride', 'Supplement Cervical Nerve with Autol Sub, Perc Endo Approach', to_date('16-06-2017', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (322, 'Octisalate', 'Removal of Radioact Elem from Cranial Cav, Open Approach', to_date('04-07-2024', 'dd-mm-yyyy'), 48, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (323, 'Lithium benzoicum', 'Destruction of Right Fallopian Tube, Open Approach', to_date('21-05-2026', 'dd-mm-yyyy'), 34, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (324, 'OCTINOXATE', 'Supplement L Basilic Vein with Synth Sub, Perc Endo Approach', to_date('13-05-2005', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (325, 'Progesterone', 'Destruction of Right Fibula, Perc Endo Approach', to_date('26-11-2024', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (326, 'Berber. vulg.', 'Extirpation of Matter from L Shoulder Tendon, Perc Approach', to_date('23-09-2026', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (327, 'Irbesartan', 'Supplement R Vas Deferens with Autol Sub, Perc Endo Approach', to_date('04-05-2025', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (328, 'antihemophilic factor/von', 'Restriction of Stomach, Pylorus with Intralum Dev, Endo', to_date('11-04-2008', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (329, 'temazepam', 'Reposition Right Tibia with Monopln Ext Fix, Perc Approach', to_date('08-04-2014', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (330, 'Pulsatilla', 'Revision of Monitor Dev in Cranial Nrv, Extern Approach', to_date('18-07-2018', 'dd-mm-yyyy'), 24, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (331, 'fluvoxamine maleate', 'Resection of Left Superior Parathyroid Gland, Open Approach', to_date('28-03-2024', 'dd-mm-yyyy'), 11, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (332, 'quinapril', 'Occlusion of L Fem Art with Intralum Dev, Perc Endo Approach', to_date('11-08-2022', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (333, 'OCTINOXATE', 'Hyperthermia of Hard Palate', to_date('27-03-2019', 'dd-mm-yyyy'), 36, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (334, 'Cimicifuga racemosa', 'CT Scan L Pelvic Vein w H Osm Contrast, Unenh, Enhance', to_date('22-11-2011', 'dd-mm-yyyy'), 44, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (335, 'norethindrone acetate/ethinyl estradiol', 'Excision of Left Toe Phalangeal Joint, Percutaneous Approach', to_date('17-04-2024', 'dd-mm-yyyy'), 24, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (336, 'OCTINOXATE', 'Repair Left Temporal Bone, Percutaneous Approach', to_date('05-11-2012', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (337, 'CLADOSPORIUM SPHAEROSPERMUM', 'Removal of Ext Fix from R Femur Shaft, Extern Approach', to_date('18-06-2020', 'dd-mm-yyyy'), 42, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (338, 'Loratadine', 'Destruction of Right Fibula, Perc Endo Approach', to_date('23-04-2020', 'dd-mm-yyyy'), 30, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (339, 'Pareira', 'Fragmentation in Appendix, Percutaneous Endoscopic Approach', to_date('03-11-2007', 'dd-mm-yyyy'), 31, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (340, 'Malic Acid', 'Revision of Bone Stim in Up Bone, Extern Approach', to_date('02-03-2018', 'dd-mm-yyyy'), 46, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (342, 'GLYCERIN', 'Fragmentation in Common Bile Duct, Open Approach', to_date('10-01-2016', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (344, 'alcohol', 'Repair Left Foot, External Approach', to_date('13-06-2011', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (345, 'Rhus aromatica', 'Restrict R Com Iliac Vein w Intralum Dev, Perc Endo', to_date('25-11-2024', 'dd-mm-yyyy'), 23, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (347, 'Acetaminophen', 'Excision of Left Face Vein, Open Approach, Diagnostic', to_date('23-12-2024', 'dd-mm-yyyy'), 48, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (348, 'OCTINOXATE OCTISALATE OXYBENZONE', 'Extirpate matter from L Shoulder Bursa/Lig, Perc Endo', to_date('10-05-2008', 'dd-mm-yyyy'), 37, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (350, 'Serine', 'Reposition Accessory Nerve, Open Approach', to_date('08-09-2012', 'dd-mm-yyyy'), 27, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (351, 'Ruta Graveolens', 'Bypass Asc Colon to Trans Colon w Autol Sub, Perc Endo', to_date('28-09-2025', 'dd-mm-yyyy'), 38, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (353, 'CLADOSPORIUM SPHAEROSPERMUM', 'Restriction of Left Brachial Artery, Percutaneous Approach', to_date('07-02-2011', 'dd-mm-yyyy'), 13, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (354, 'PHENYLEPHRINE HYDROCHLORIDE', 'Fusion C-thor Jt w Autol Sub, Post Appr A Col, Perc', to_date('23-03-2024', 'dd-mm-yyyy'), 20, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (356, 'Apiolum', 'Excision of R Temporomandib Jt, Perc Endo Approach, Diagn', to_date('13-10-2013', 'dd-mm-yyyy'), 37, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (357, 'Acetaminophen', 'Extirpation of Matter from L Fem Art, Open Approach', to_date('11-08-2026', 'dd-mm-yyyy'), 43, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (359, 'Divalproex sodium', 'Excision of Left External Iliac Artery, Perc Approach, Diagn', to_date('16-04-2026', 'dd-mm-yyyy'), 18, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (360, 'ZINC OXIDE', 'Drainage of R Occipital Bone with Drain Dev, Perc Approach', to_date('10-11-2024', 'dd-mm-yyyy'), 35, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (362, 'Aralia quinquefolia', 'Replacement of Up Tooth, All, with Autol Sub, Open Approach', to_date('18-12-2020', 'dd-mm-yyyy'), 28, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (363, 'Asafoetida', 'Release Right Shoulder Joint, Open Approach', to_date('16-09-2012', 'dd-mm-yyyy'), 47, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (365, 'LISINOPRIL', 'Excision of Left Cephalic Vein, Open Approach, Diagnostic', to_date('22-08-2023', 'dd-mm-yyyy'), 12, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (367, 'Iohexol', 'Monitoring of Gastrointestinal Pressure, Endo', to_date('19-03-2006', 'dd-mm-yyyy'), 40, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (368, 'TOXICODENDRON PUBESCENS LEAF', 'Destruction of Left Inguinal Lymphatic, Perc Endo Approach', to_date('20-06-2009', 'dd-mm-yyyy'), 39, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (370, 'Gerbil Epithelia', 'Resection of Left Superior Parathyroid Gland, Open Approach', to_date('26-01-2023', 'dd-mm-yyyy'), 16, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (371, 'Propranolol Hydrochloride', 'Introduce Local Anesth in Skin/Mucous Mem, Extern', to_date('28-03-2017', 'dd-mm-yyyy'), 24, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (373, 'HYDROCORTISONE', 'Repair Lumbar Sympathetic Nerve, Percutaneous Approach', to_date('06-06-2016', 'dd-mm-yyyy'), 22, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (374, 'Aesculus hippocastanum', 'Repair Superior Vena Cava, Percutaneous Approach', to_date('05-02-2019', 'dd-mm-yyyy'), 34, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (376, 'Phytolacca', 'Revision of Synth Sub in L Finger Phalanx Jt, Open Approach', to_date('04-12-2011', 'dd-mm-yyyy'), 18, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (377, 'Sodium Bicarbonate', 'Dilation of Right Hand Artery, Percutaneous Approach', to_date('16-12-2006', 'dd-mm-yyyy'), 28, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (379, 'Imipenem', 'Drainage of Peritoneum with Drain Dev, Perc Endo Approach', to_date('12-10-2025', 'dd-mm-yyyy'), 30, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (380, 'Metoprolol Tartrate', 'Supplement Left Foot Vein with Synth Sub, Open Approach', to_date('09-10-2022', 'dd-mm-yyyy'), 41, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (382, 'Cocklebur', 'Resection of Large Intestine, Endo', to_date('26-10-2024', 'dd-mm-yyyy'), 31, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (383, 'ONDANSETRON HYDROCHLORIDE', 'Drainage of Left Lobe Liver with Drain Dev, Perc Approach', to_date('25-01-2010', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (385, 'Ferrum phosphoricum', 'Change Drainage Device in Liver, External Approach', to_date('05-05-2005', 'dd-mm-yyyy'), 10, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (386, 'sumatriptan succinate', 'Destruction of Right Fibula, Perc Endo Approach', to_date('10-03-2020', 'dd-mm-yyyy'), 12, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (388, 'Ciprofloxacin Hydrochloride', 'Removal of Synth Sub from Abd Wall, Extern Approach', to_date('25-05-2011', 'dd-mm-yyyy'), 24, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (390, 'zolpidem tartrate', 'Removal of Synthetic Substitute from Urethra, Via Opening', to_date('27-06-2008', 'dd-mm-yyyy'), 39, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (391, 'Dibasic', 'Insertion of Other Device into Upper Jaw, Perc Approach', to_date('27-09-2017', 'dd-mm-yyyy'), 18, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (393, 'Cetirizine Hydrochloride', 'Excision of L Up Extrem Lymph, Perc Endo Approach, Diagn', to_date('25-03-2005', 'dd-mm-yyyy'), 37, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (394, 'risperidone', 'Dilate of Sup Mesent Art with Drug-elut Intra, Open Approach', to_date('28-03-2013', 'dd-mm-yyyy'), 40, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (396, 'Amoxicillin', 'Excision of L Up Extrem Lymph, Perc Endo Approach, Diagn', to_date('08-07-2017', 'dd-mm-yyyy'), 15, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (397, 'Bellis perennis', 'Repair Right Upper Leg Tendon, Percutaneous Approach', to_date('24-01-2005', 'dd-mm-yyyy'), 46, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (399, 'Vinorelbine tartrate', 'Insertion of Other Device into Upper Jaw, Perc Approach', to_date('03-09-2010', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (400, 'Ferrum metallicum', 'Removal of Autol Sub from L Eye, Extern Approach', to_date('14-06-2013', 'dd-mm-yyyy'), 34, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (401, 'Titanium Dioxide', 'Revision of Spacer in L Metacarpocarp Jt, Perc Approach', to_date('15-07-2005', 'dd-mm-yyyy'), 42, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (402, 'Phosphoricum acidum Pituitary suis', 'Drainage of Right Sacroiliac Joint, Open Approach, Diagn', to_date('24-03-2009', 'dd-mm-yyyy'), 50, '4');
commit;
prompt 300 records committed...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (403, 'Arnica montana', 'Bypass R Axilla Art to R Low Arm Art w Autol Art, Open', to_date('25-11-2006', 'dd-mm-yyyy'), 12, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (404, 'Hydrocodone Bitartrate', 'Bypass L Com Iliac Art to R Femor A w Synth Sub, Open', to_date('26-08-2007', 'dd-mm-yyyy'), 38, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (405, 'Promethazine Hydrochloride', 'Drainage of Peritoneum with Drain Dev, Perc Endo Approach', to_date('01-05-2025', 'dd-mm-yyyy'), 25, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (406, 'Guaifenesin', 'Revision of Spacer in L Metacarpocarp Jt, Perc Approach', to_date('25-01-2015', 'dd-mm-yyyy'), 47, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (407, 'Germanium sesquioxide', 'Beam Radiation of Urethra using Electrons', to_date('23-02-2024', 'dd-mm-yyyy'), 45, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (408, 'Methionine', 'Beam Radiation of Lung using Electrons, Intraoperative', to_date('14-02-2008', 'dd-mm-yyyy'), 10, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (409, 'Magnesium Sulfate', 'Bypass L Com Iliac Art to B Int Ilia w Autol Art, Perc Endo', to_date('02-08-2014', 'dd-mm-yyyy'), 38, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (410, 'ENSULIZOLE', 'Revision of Monitor Dev in Cranial Nrv, Extern Approach', to_date('12-09-2017', 'dd-mm-yyyy'), 15, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (411, 'Terazosin hydrochloride', 'Excision of Right Middle Lobe Bronchus, Endo, Diagn', to_date('25-11-2025', 'dd-mm-yyyy'), 21, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (412, 'Erythropoietin', 'Revision of Monitor Dev in Cranial Nrv, Extern Approach', to_date('18-08-2007', 'dd-mm-yyyy'), 20, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (413, 'LORAZEPAM', 'CT Scan L Pelvic Vein w H Osm Contrast, Unenh, Enhance', to_date('13-09-2007', 'dd-mm-yyyy'), 18, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (414, 'Amoxicillin', 'Supplement L Ring Finger with Nonaut Sub, Perc Endo Approach', to_date('17-05-2018', 'dd-mm-yyyy'), 19, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (415, 'carbamazepine', 'Replace R Low Arm Skin w Synth Sub, Full Thick, Extern', to_date('26-08-2012', 'dd-mm-yyyy'), 48, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (416, 'Mycobacterium phlei', 'Reposition Left Metacarpal, Open Approach', to_date('25-07-2007', 'dd-mm-yyyy'), 48, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (417, 'Mezereum Comp.', 'Revision of Int Fix in R Toe Phalanx, Perc Approach', to_date('20-05-2011', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (418, 'oxycodone', 'Replace of Pancreat Duct with Synth Sub, Perc Endo Approach', to_date('15-11-2007', 'dd-mm-yyyy'), 32, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (420, 'PROLINE', 'Supplement L Axilla Art with Synth Sub, Perc Endo Approach', to_date('08-10-2020', 'dd-mm-yyyy'), 13, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (421, 'Dextromethorphan HBr', 'Reposition L Up Femur with Monopln Ext Fix, Perc Approach', to_date('22-12-2014', 'dd-mm-yyyy'), 23, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (423, 'Castanea vesca', 'Detachment at Left 4th Toe, Low, Open Approach', to_date('26-05-2026', 'dd-mm-yyyy'), 29, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (424, 'Furosemide', 'Replace of Abd Subcu/Fascia with Autol Sub, Perc Approach', to_date('04-11-2008', 'dd-mm-yyyy'), 47, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (426, 'LORAZEPAM', 'Control Bleeding in Left Upper Arm, Open Approach', to_date('11-11-2014', 'dd-mm-yyyy'), 44, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (427, 'Hepar suis', 'Change Splint on Face', to_date('18-01-2020', 'dd-mm-yyyy'), 17, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (429, 'PRAVASTATIN SODIUM', 'CT Scan of Bi Pulm Vein using L Osm Contrast, Unenh, Enhance', to_date('02-04-2025', 'dd-mm-yyyy'), 30, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (430, 'alcohol', 'Fragmentation in Right Parotid Duct, External Approach', to_date('22-03-2016', 'dd-mm-yyyy'), 19, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (432, 'Heal Grief', 'Drainage of Upper Lip, External Approach', to_date('04-12-2019', 'dd-mm-yyyy'), 33, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (433, 'acetaminophen', 'Revision of Other Device in Cranial Cavity, Extern Approach', to_date('07-07-2023', 'dd-mm-yyyy'), 19, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (435, 'Tizanidine', 'Bypass Abd Aorta to Low Ex Art w Nonaut Sub, Perc Endo', to_date('28-12-2024', 'dd-mm-yyyy'), 23, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (436, 'dextromethorphan hydrobromide', 'Removal of Drainage Device from Left Eye, External Approach', to_date('09-04-2018', 'dd-mm-yyyy'), 47, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (438, 'Doxylamine succinate', 'Drainage of Azygos Vein, Open Approach, Diagnostic', to_date('27-02-2025', 'dd-mm-yyyy'), 10, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (439, 'HISTIDINE', 'Excision of Right Innominate Vein, Percutaneous Approach', to_date('15-10-2026', 'dd-mm-yyyy'), 19, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (441, 'Amlodipine Besylate', 'Removal of Int Fix from L Sternoclav Jt, Perc Approach', to_date('18-05-2005', 'dd-mm-yyyy'), 26, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (442, 'Octinoxate', 'CT Scan of Neck using L Osm Contrast, Unenh, Enhance', to_date('20-03-2026', 'dd-mm-yyyy'), 35, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (444, 'lamotrigine', 'Insertion of Stimulator Lead into Bladder, Via Opening', to_date('06-07-2008', 'dd-mm-yyyy'), 45, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (445, 'Digitalis', 'Repair Sciatic Nerve, Percutaneous Approach', to_date('04-04-2025', 'dd-mm-yyyy'), 15, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (447, 'Acetaminophen', 'Replace of Pancreat Duct with Synth Sub, Perc Endo Approach', to_date('28-06-2010', 'dd-mm-yyyy'), 24, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (448, 'amlodipine besylate', 'Drainage of Ileocecal Valve, Percutaneous Approach', to_date('20-11-2014', 'dd-mm-yyyy'), 37, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (450, 'Metoclopramide', 'Removal of Synthetic Substitute from Urethra, Via Opening', to_date('15-06-2014', 'dd-mm-yyyy'), 44, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (451, 'Flumazenil', 'Dilation of Right Hand Artery, Percutaneous Approach', to_date('11-05-2016', 'dd-mm-yyyy'), 20, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (453, 'Hepar suis', 'Dilate L Int Mamm Art, Bifurc, w Drug-elut Intra, Perc Endo', to_date('18-08-2017', 'dd-mm-yyyy'), 44, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (455, 'Tricolsan', 'Removal of Autol Sub from Coccyx, Perc Endo Approach', to_date('14-03-2021', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (456, 'quetiapine fumarate', 'Alteration of R Axilla with Nonaut Sub, Perc Endo Approach', to_date('14-06-2022', 'dd-mm-yyyy'), 25, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (458, 'Ruta graveolens', 'Revision of Ext Fix in R Tarsal, Extern Approach', to_date('27-04-2015', 'dd-mm-yyyy'), 18, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (459, 'Benzocaine', 'Bypass L Ext Iliac Art to Low Ex Art, Open Approach', to_date('04-05-2005', 'dd-mm-yyyy'), 14, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (460, 'Carisoprodol', 'Dilation of L Axilla Art with Drug-elut Intra, Open Approach', to_date('19-05-2022', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (462, 'Acetaminophen', 'Removal of Int Fix from R Shoulder Jt, Perc Approach', to_date('24-08-2026', 'dd-mm-yyyy'), 28, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (463, 'Buspirone Hydrochloride', 'Beam Radiation of Lung using Electrons, Intraoperative', to_date('06-01-2018', 'dd-mm-yyyy'), 44, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (465, 'SENNOSIDES', 'Reposition Right Testis, Open Approach', to_date('21-05-2010', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (467, 'Pilocarpine Hydrochloride', 'Dilation of Left Upper Lobe Bronchus with Intralum Dev, Endo', to_date('21-06-2013', 'dd-mm-yyyy'), 13, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (468, 'Salicylic Acid', 'Drainage of Genitalia Skin, External Approach, Diagnostic', to_date('19-02-2022', 'dd-mm-yyyy'), 32, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (470, 'acetaminophen', 'Dilation of Vagina, Open Approach', to_date('03-05-2008', 'dd-mm-yyyy'), 22, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (471, 'Heal Grief', 'Replacement of Sup Mesent Art with Autol Sub, Open Approach', to_date('20-08-2014', 'dd-mm-yyyy'), 15, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (473, 'ZINC OXIDE', 'Drainage of Left Lacrimal Bone with Drain Dev, Open Approach', to_date('03-11-2008', 'dd-mm-yyyy'), 14, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (474, 'Belladonna', 'Bypass L Com Iliac Art to L Int Ilia w Autol Art, Open', to_date('15-05-2023', 'dd-mm-yyyy'), 31, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (476, 'Acetaminophen', 'Dilation of L Radial Art with 2 Intralum Dev, Open Approach', to_date('02-10-2011', 'dd-mm-yyyy'), 45, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (477, 'TITANIUM DIOXIDE', 'Revision of Other Device in Cranial Cavity, Extern Approach', to_date('07-03-2005', 'dd-mm-yyyy'), 38, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (478, 'triclosan', 'Hyperthermia of Hard Palate', to_date('03-08-2013', 'dd-mm-yyyy'), 43, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (480, 'Benzoicum acidum', 'Repair Left Hip Joint, Percutaneous Endoscopic Approach', to_date('07-01-2016', 'dd-mm-yyyy'), 40, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (481, 'TITANIUM DIOXIDE', 'Removal of Int Fix from R Shoulder Jt, Perc Approach', to_date('12-07-2008', 'dd-mm-yyyy'), 23, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (482, 'Tyrosine', 'Fusion of L Shoulder Jt with Synth Sub, Perc Endo Approach', to_date('12-09-2014', 'dd-mm-yyyy'), 43, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (483, 'Titanium Dioxide', 'Supplement Epiglottis with Synth Sub, Open Approach', to_date('28-11-2009', 'dd-mm-yyyy'), 28, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (484, 'Galantamine Hydrobromide', 'Replace of Chest Subcu/Fascia with Synth Sub, Open Approach', to_date('27-10-2019', 'dd-mm-yyyy'), 27, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (485, 'ACETAMINOPHEN', 'Drainage of Left Brachial Vein, Percutaneous Approach, Diagn', to_date('27-08-2022', 'dd-mm-yyyy'), 29, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (486, 'SUS SCROFA UMBILICAL CORD', 'Revise of Synth Sub in Sacrococcygeal Jt, Perc Endo Approach', to_date('17-11-2010', 'dd-mm-yyyy'), 15, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (487, 'Iohexol', 'Introduction of Oth Hormone into Central Art, Perc Approach', to_date('25-06-2008', 'dd-mm-yyyy'), 31, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (488, 'Magnesium Hydroxide', 'Reposition Left Radius, Percutaneous Endoscopic Approach', to_date('26-06-2019', 'dd-mm-yyyy'), 31, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (489, 'levodopa', 'Removal of Drainage Device from L Elbow Jt, Perc Approach', to_date('18-08-2011', 'dd-mm-yyyy'), 40, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (490, 'Phytolacca', 'Cochlear Implant Assessment using Hear Aid Equipment', to_date('16-06-2026', 'dd-mm-yyyy'), 32, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (491, 'desvenlafaxine', 'Insertion of Radioact Elem into Hepatobil Duct, Via Opening', to_date('08-04-2012', 'dd-mm-yyyy'), 13, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (492, 'Metformin Hydrochloride', 'Excision of R Temporomandib Jt, Perc Endo Approach, Diagn', to_date('10-03-2009', 'dd-mm-yyyy'), 25, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (493, 'Avobenzone', 'Removal of Autol Sub from L Humeral Head, Open Approach', to_date('08-05-2020', 'dd-mm-yyyy'), 35, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (494, 'Calcarea carbonica', 'Release Scalp Subcutaneous Tissue and Fascia, Perc Approach', to_date('22-11-2007', 'dd-mm-yyyy'), 43, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (495, 'levalbuterol inhalation', 'Destruction of Thyroid Gland, Perc Endo Approach', to_date('01-09-2024', 'dd-mm-yyyy'), 21, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (496, 'TITANIUM DIOXIDE', 'Drain of L Peroneal Art with Drain Dev, Perc Endo Approach', to_date('13-02-2007', 'dd-mm-yyyy'), 37, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (497, 'Mezereum Comp.', 'Replacement of Left Eye with Autol Sub, Perc Approach', to_date('06-01-2018', 'dd-mm-yyyy'), 15, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (498, 'alcohol', 'Revision of Extralum Dev in Up Intest Tract, Via Opening', to_date('02-11-2012', 'dd-mm-yyyy'), 29, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (499, 'Carbamazepine', 'Destruction of Thyroid Gland, Perc Endo Approach', to_date('07-11-2024', 'dd-mm-yyyy'), 23, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (501, 'pramoxine hydrochloride', 'Insertion of Other Device into L Wrist, Perc Approach', to_date('08-06-2025', 'dd-mm-yyyy'), 25, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (503, 'Riboflavinum', 'Revision of Int Fix in R Toe Phalanx, Perc Approach', to_date('03-12-2013', 'dd-mm-yyyy'), 14, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (504, 'Lachesis', 'Excision of Left External Iliac Artery, Perc Approach, Diagn', to_date('05-03-2011', 'dd-mm-yyyy'), 29, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (506, 'levalbuterol inhalation', 'Drainage of Left Ulnar Artery, Percutaneous Approach, Diagn', to_date('06-02-2019', 'dd-mm-yyyy'), 44, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (507, 'Coumarinum', 'Drainage of Bilateral Fallopian Tubes, Endo', to_date('06-10-2021', 'dd-mm-yyyy'), 10, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (509, 'Sulphuricum acidum', 'Excision of Left Femoral Shaft, Percutaneous Approach', to_date('01-01-2008', 'dd-mm-yyyy'), 46, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (510, 'Dextrose', 'Inspection of Right Knee Region, External Approach', to_date('14-09-2015', 'dd-mm-yyyy'), 14, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (512, 'vobenzone', 'LDR Brachytherapy of Pancreas using Palladium 103', to_date('24-03-2024', 'dd-mm-yyyy'), 43, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (514, 'Guaifenesin', 'Resection of Left Superior Parathyroid Gland, Open Approach', to_date('28-05-2016', 'dd-mm-yyyy'), 47, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (515, 'TRYPTOPHAN', 'Fluoroscopy of L Temporomand Jt using Oth Contrast', to_date('01-08-2008', 'dd-mm-yyyy'), 16, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (517, 'Baclofen', 'HDR Brachytherapy of Jejunum using Palladium 103', to_date('16-10-2021', 'dd-mm-yyyy'), 26, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (518, 'RISPERIDONE', 'Bypass Asc Colon to Trans Colon w Autol Sub, Perc Endo', to_date('10-03-2022', 'dd-mm-yyyy'), 34, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (520, 'Nicotine Polacrilex', 'Replace of L Humeral Shaft with Nonaut Sub, Perc Approach', to_date('03-09-2009', 'dd-mm-yyyy'), 13, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (521, 'Nicotine Polacrilex', 'Release Right Knee Joint, External Approach', to_date('23-03-2016', 'dd-mm-yyyy'), 28, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (522, 'OCTINOXATE', 'Drainage of Right Common Iliac Vein, Perc Approach, Diagn', to_date('03-11-2008', 'dd-mm-yyyy'), 33, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (524, 'Pineal', 'Replacement of L Atrium with Zooplastic, Perc Endo Approach', to_date('25-12-2025', 'dd-mm-yyyy'), 39, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (525, 'MENTHOL', 'Bypass R Axilla Art to R Low Arm Art w Autol Art, Open', to_date('21-12-2022', 'dd-mm-yyyy'), 34, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (527, 'diphenhydramine HCl', 'Revision of Extralum Dev in Up Intest Tract, Via Opening', to_date('01-09-2011', 'dd-mm-yyyy'), 15, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (528, 'Miconazole Nitrate', 'Restriction of Right Hand Artery, Open Approach', to_date('20-04-2023', 'dd-mm-yyyy'), 12, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (530, 'Hydrastis', 'Reposition Right Tibia with Monopln Ext Fix, Perc Approach', to_date('25-08-2014', 'dd-mm-yyyy'), 30, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (531, 'Phenylephrine HCl', 'Excision of Para-aortic Body, Percutaneous Approach, Diagn', to_date('22-03-2013', 'dd-mm-yyyy'), 39, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (533, 'Lymph (suis)', 'Dilate L Brach Art, Bifurc, w 2 Drug-elut, Open', to_date('19-05-2012', 'dd-mm-yyyy'), 43, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (534, 'sodium monofluorophosphate', 'Replacement of R Fem Art with Nonaut Sub, Perc Endo Approach', to_date('08-12-2009', 'dd-mm-yyyy'), 21, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (536, 'Titanium Dioxide', 'Excision of Nasal Septum, Perc Endo Approach, Diagn', to_date('09-12-2012', 'dd-mm-yyyy'), 37, '4');
commit;
prompt 400 records committed...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (537, 'Threonine', 'Revise of Infusion Dev in R Metatarsotars Jt, Open Approach', to_date('15-12-2012', 'dd-mm-yyyy'), 31, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (539, 'Ulmus fulva', 'Revision of Extralum Dev in Up Intest Tract, Via Opening', to_date('21-11-2024', 'dd-mm-yyyy'), 30, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (540, 'Threonine', 'Excision of Head Muscle, Percutaneous Endoscopic Approach', to_date('02-04-2019', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (542, 'Avobenzone', 'Reposition Accessory Nerve, Open Approach', to_date('21-08-2018', 'dd-mm-yyyy'), 42, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (543, 'guaifenesin', 'Exercise Trmt Circ Body w Mech/Electromech Equip', to_date('11-09-2013', 'dd-mm-yyyy'), 36, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (545, 'Sulfur', 'Supplement Left Foot Vein with Synth Sub, Perc Endo Approach', to_date('03-01-2019', 'dd-mm-yyyy'), 17, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (546, 'Calcarea silicata', 'Bypass Lower Esophagus to Cutaneous, Endo', to_date('14-12-2013', 'dd-mm-yyyy'), 47, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (548, 'Hypothalamus', 'Revision of Ext Fix in R Ulna, Extern Approach', to_date('05-05-2010', 'dd-mm-yyyy'), 43, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (549, 'Cetirizine HCl', 'Reposition Pulmonary Trunk, Open Approach', to_date('04-09-2023', 'dd-mm-yyyy'), 41, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (551, 'Erythromycin', 'Extraction of Right Cornea, External Approach, Diagnostic', to_date('20-03-2009', 'dd-mm-yyyy'), 45, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (552, 'TITANIUM DIOXIDE', 'Removal of Artificial Sphincter from Bladder, Endo', to_date('28-02-2013', 'dd-mm-yyyy'), 35, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (554, 'TITANIUM DIOXIDE', 'Dilate 4+ Cor Art, Bifurc, w 2 Intralum Dev, Perc', to_date('17-03-2021', 'dd-mm-yyyy'), 29, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (555, 'Acetaminophen', 'Insertion of Intraluminal Device into Jejunum, Open Approach', to_date('05-08-2025', 'dd-mm-yyyy'), 25, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (557, 'Hypericum perforatum', 'Alteration of R Axilla with Nonaut Sub, Perc Endo Approach', to_date('08-03-2005', 'dd-mm-yyyy'), 32, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (558, 'Valsartan', 'Drainage of R Occipital Bone with Drain Dev, Perc Approach', to_date('20-03-2006', 'dd-mm-yyyy'), 42, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (560, 'Chicken Feathers', 'Bypass R Ext Jugular Vein to Up Vein w Autol Vn, Perc Endo', to_date('19-03-2019', 'dd-mm-yyyy'), 40, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (561, 'Salicylic Acid', 'Repair Left Knee Tendon, Percutaneous Approach', to_date('23-07-2022', 'dd-mm-yyyy'), 22, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (562, 'Spleen', 'Revision of Nonaut Sub in L Up Femur, Open Approach', to_date('06-12-2019', 'dd-mm-yyyy'), 21, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (563, 'Monobasic', 'Bypass L Com Iliac Art to L Int Ilia w Autol Art, Open', to_date('22-08-2012', 'dd-mm-yyyy'), 29, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (564, 'Nicotine Polacrilex', 'Insertion of Oth Dev into Retroperitoneum, Open Approach', to_date('25-11-2022', 'dd-mm-yyyy'), 30, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (565, 'Phenylephrine HCl', 'Excision of Head Muscle, Percutaneous Endoscopic Approach', to_date('13-01-2017', 'dd-mm-yyyy'), 36, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (566, 'OCTINOXATE', 'Repair Right Lower Arm, Percutaneous Endoscopic Approach', to_date('07-06-2021', 'dd-mm-yyyy'), 31, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (567, 'Hepar suis', 'Drain of L Trunk Muscle with Drain Dev, Perc Endo Approach', to_date('19-01-2010', 'dd-mm-yyyy'), 27, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (568, 'Hydrocodone Bitartrate', 'Removal of Autol Sub from Mediastinum, Perc Endo Approach', to_date('01-08-2026', 'dd-mm-yyyy'), 22, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (569, 'ETHYL ALCOHOL', 'Destruction of R Hand Subcu/Fascia, Perc Approach', to_date('26-05-2021', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (570, 'diphenhydramine HCl', 'Fluoroscopy of L Temporomand Jt using Oth Contrast', to_date('20-04-2012', 'dd-mm-yyyy'), 21, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (571, 'phenylephrine HCl', 'Supplement Left Foot Vein with Synth Sub, Open Approach', to_date('08-06-2013', 'dd-mm-yyyy'), 15, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (572, 'Carduus mar.', 'Excision of Right Axilla, Percutaneous Approach, Diagnostic', to_date('14-11-2021', 'dd-mm-yyyy'), 31, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (573, 'antihemophilic factor/von', 'Extraction of Peroneal Nerve, Open Approach', to_date('18-01-2012', 'dd-mm-yyyy'), 13, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (574, 'Ethyl Alcohol', 'Occlusion of Ascending Colon with Intralum Dev, Via Opening', to_date('11-05-2016', 'dd-mm-yyyy'), 27, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (575, 'Lidocaine', 'Revision of Nonaut Sub in Cervcal Vertebra, Open Approach', to_date('05-11-2024', 'dd-mm-yyyy'), 26, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (576, 'ALCOHOL', 'Revision of Drain Dev in Vagina & Cul-de-sac, Open Approach', to_date('05-08-2011', 'dd-mm-yyyy'), 31, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (577, 'Famotidine', 'Extirpation of Matter from L Fem Art, Open Approach', to_date('18-07-2006', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (578, 'ascorbic acid', 'Removal of Radioactive Element from Up Jaw, Extern Approach', to_date('21-04-2008', 'dd-mm-yyyy'), 20, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (579, 'Clotrimazole', 'CT Scan of Cereb Vent using H Osm Contrast, Unenh, Enhance', to_date('26-09-2009', 'dd-mm-yyyy'), 47, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (580, 'sodium monofluorophosphate', 'Dilate R Subclav Art, Bifurc, w 2 Drug-elut, Open', to_date('01-10-2018', 'dd-mm-yyyy'), 32, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (581, 'Octinoxate', 'MRI of Bi Pelvic Vein using Oth Contrast, Unenh, Enhance', to_date('13-11-2016', 'dd-mm-yyyy'), 42, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (583, 'Petrolatum', 'Revision of Nonaut Sub in Penis, Open Approach', to_date('09-01-2024', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (585, 'Helium', 'Restrict Pancreat Duct w Intralum Dev, Perc Endo', to_date('18-10-2010', 'dd-mm-yyyy'), 20, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (586, 'lorazepam', 'Replace R Hip Jt, Acetab w Metal, Uncement, Open', to_date('22-06-2025', 'dd-mm-yyyy'), 42, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (588, 'Granisetron', 'Exercise Treatment of Musculosk Low Back/LE using Prosthesis', to_date('16-01-2021', 'dd-mm-yyyy'), 14, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (589, 'Amoxicillin', 'Dilate of R Verteb Art with 3 Drug-elut, Perc Endo Approach', to_date('09-01-2025', 'dd-mm-yyyy'), 21, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (591, 'Carbamazepine', 'Revision of Neuro Lead in Cranial Nrv, Open Approach', to_date('23-07-2017', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (592, 'pramoxine hydrochloride', 'Replace R Low Arm Skin w Synth Sub, Full Thick, Extern', to_date('01-11-2022', 'dd-mm-yyyy'), 40, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (594, 'White Ash', 'Replacement of Sup Mesent Art with Autol Sub, Open Approach', to_date('14-12-2010', 'dd-mm-yyyy'), 47, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (595, 'levalbuterol inhalation', 'Revision of Nonaut Sub in Cervcal Vertebra, Open Approach', to_date('17-05-2018', 'dd-mm-yyyy'), 46, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (597, 'Morphine Sulfate', 'Excision of Buccal Mucosa, Percutaneous Approach', to_date('14-05-2015', 'dd-mm-yyyy'), 37, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (598, 'Phenylephrine HCl', 'Excision of Neck, External Approach, Diagnostic', to_date('23-07-2026', 'dd-mm-yyyy'), 24, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (599, 'Phenylalanine', 'Replace R Low Arm Skin w Synth Sub, Full Thick, Extern', to_date('22-12-2016', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (601, 'Hepar suis', 'Replace of Chest Subcu/Fascia with Synth Sub, Open Approach', to_date('26-12-2012', 'dd-mm-yyyy'), 15, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (602, 'alcohol', 'Excision of Left Carotid Body, Percutaneous Approach', to_date('26-02-2015', 'dd-mm-yyyy'), 24, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (604, 'Threonine', 'LDR Brachytherapy of Pancreas using Palladium 103', to_date('03-11-2025', 'dd-mm-yyyy'), 16, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (605, 'Streptococcus viridans', 'Restriction of Right Hand Artery, Open Approach', to_date('28-04-2010', 'dd-mm-yyyy'), 47, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (607, 'Divalproex sodium', 'Division of Right Lower Arm and Wrist Tendon, Open Approach', to_date('24-01-2015', 'dd-mm-yyyy'), 30, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (608, 'Rhus toxicodendron', 'Bypass R Axilla Art to R Low Arm Art w Autol Art, Open', to_date('22-11-2013', 'dd-mm-yyyy'), 16, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (610, 'Lithium benzoicum', 'Excision of L Abd Bursa/Lig, Perc Endo Approach', to_date('12-04-2020', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (611, 'Natrum carbonicum', 'Dilation of L Axilla Art with Drug-elut Intra, Open Approach', to_date('02-12-2024', 'dd-mm-yyyy'), 34, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (613, 'Treatment Set TS348562', 'Repair Nasal Bone, External Approach', to_date('23-05-2020', 'dd-mm-yyyy'), 39, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (614, 'Lidocaine', 'Revision of Spacer in L Metacarpocarp Jt, Perc Approach', to_date('06-05-2013', 'dd-mm-yyyy'), 37, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (616, 'risperidone', 'Supplement R Vas Deferens with Autol Sub, Perc Endo Approach', to_date('21-06-2007', 'dd-mm-yyyy'), 29, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (617, 'Clozapine', 'Excision of Upper Back, Percutaneous Approach', to_date('01-11-2010', 'dd-mm-yyyy'), 35, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (618, 'Bellis perennis', 'Removal of Infusion Device from Up Art, Extern Approach', to_date('21-08-2017', 'dd-mm-yyyy'), 15, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (620, 'Belladonna', 'Beam Radiation of Lung using Electrons, Intraoperative', to_date('26-11-2024', 'dd-mm-yyyy'), 13, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (621, 'Ranitidine', 'Drain R Metacarpocarp Jt w Drain Dev, Perc Endo', to_date('10-03-2013', 'dd-mm-yyyy'), 31, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (623, 'Amlodipine Besylate', 'Occlusion R Ext Jugular Vein w Intralum Dev, Open', to_date('21-11-2025', 'dd-mm-yyyy'), 23, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (624, 'ibuprofen', 'Release Left Metacarpophalangeal Joint, Open Approach', to_date('08-12-2018', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (626, 'Calcarea sulphurica', 'Replace R Low Arm Skin w Synth Sub, Full Thick, Extern', to_date('23-11-2019', 'dd-mm-yyyy'), 45, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (627, 'Allantoin', 'Insertion of Intralum Dev into L Renal Vein, Open Approach', to_date('22-06-2011', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (629, 'Titanium Dioxide', 'Beam Radiation of Lung using Electrons, Intraoperative', to_date('15-10-2014', 'dd-mm-yyyy'), 21, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (630, 'Acteaminophen', 'Removal of Autol Sub from Great Vessel, Open Approach', to_date('27-11-2006', 'dd-mm-yyyy'), 12, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (631, 'Cuprum Aceticum 3', 'Drainage of Right Main Bronchus, Perc Endo Approach', to_date('26-12-2006', 'dd-mm-yyyy'), 37, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (633, 'Germanium sesquioxide', 'Insertion of Other Device into Upper Jaw, Perc Approach', to_date('04-03-2015', 'dd-mm-yyyy'), 10, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (635, 'Neisseria Meningitidis Group C Capsular Polysaccharide Antigen', 'CT Scan of Cereb Vent using H Osm Contrast, Unenh, Enhance', to_date('15-03-2024', 'dd-mm-yyyy'), 29, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (636, 'Atenolol', 'Resection of Left Superior Parathyroid Gland, Open Approach', to_date('18-06-2026', 'dd-mm-yyyy'), 40, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (638, 'Helianthus annuus', 'CT Scan Chest, Abd & Pelvis w Oth Contrast, Unenh, Enhance', to_date('04-08-2026', 'dd-mm-yyyy'), 10, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (639, 'CIPROFLOXACIN', 'Dilation of R Mid Lobe Bronc with Intralum Dev, Via Opening', to_date('03-07-2013', 'dd-mm-yyyy'), 17, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (640, 'Dextromethorphan HBr', 'Revision of Neuro Lead in Cranial Nrv, Open Approach', to_date('09-11-2015', 'dd-mm-yyyy'), 19, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (641, 'Bryonia', 'CT Scan Chest, Abd & Pelvis w Oth Contrast, Unenh, Enhance', to_date('04-08-2026', 'dd-mm-yyyy'), 32, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (642, 'Acetaminophen', 'Aural Rehabilitation Status Assessment using AV Equipment', to_date('25-06-2005', 'dd-mm-yyyy'), 33, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (643, 'Phenylalanine', 'Extraction of Upper Tooth, All, External Approach', to_date('03-05-2020', 'dd-mm-yyyy'), 39, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (644, 'warfarin sodium', 'Fragmentation in Appendix, Percutaneous Endoscopic Approach', to_date('11-09-2011', 'dd-mm-yyyy'), 41, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (645, 'Acteaminophen', 'Drainage of Pancreatic Duct, Percutaneous Approach, Diagn', to_date('15-07-2021', 'dd-mm-yyyy'), 26, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (646, 'ticarcillin disodium', 'Alteration of R Axilla with Nonaut Sub, Perc Endo Approach', to_date('07-04-2020', 'dd-mm-yyyy'), 28, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (647, 'Hepar Magnesium 4', 'Restriction of Cystic Duct, Percutaneous Approach', to_date('20-10-2025', 'dd-mm-yyyy'), 44, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (648, 'Flumazenil', 'Release Right Anterior Tibial Artery, Perc Endo Approach', to_date('28-06-2008', 'dd-mm-yyyy'), 44, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (649, 'carbidopa', 'Drain of L Peroneal Art with Drain Dev, Perc Endo Approach', to_date('26-01-2023', 'dd-mm-yyyy'), 22, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (650, 'lorazepam', 'Bypass Left Kidney Pelvis to Colon, Open Approach', to_date('05-07-2013', 'dd-mm-yyyy'), 34, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (651, 'GLYCERIN', 'Excision of Multiple Parathyroid Glands, Perc Approach', to_date('27-02-2013', 'dd-mm-yyyy'), 11, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (652, 'Glimepiride', 'Fluoroscopy of Right Pulmonary Artery using H Osm Contrast', to_date('24-12-2020', 'dd-mm-yyyy'), 42, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (653, 'Alanine', 'Dilate 4+ Cor Art, Bifurc, w 2 Intralum Dev, Perc', to_date('03-03-2025', 'dd-mm-yyyy'), 38, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (654, 'SUS SCROFA CARTILAGE', 'Insertion of Tissue Expander into Right Nipple, Via Opening', to_date('27-12-2012', 'dd-mm-yyyy'), 14, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (655, 'Bellis perennis', 'HDR Brachytherapy of Jejunum using Palladium 103', to_date('25-08-2020', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (656, 'Dog Epithelia', 'Revision of Synth Sub in L Sacroiliac Jt, Perc Approach', to_date('04-01-2023', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (657, 'COMFREY ROOT', 'Beam Radiation of Lung using Electrons, Intraoperative', to_date('10-02-2005', 'dd-mm-yyyy'), 17, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (658, 'Acetaminophen', 'Bypass L Int Jugular Vein to Up Vein w Nonaut Sub, Perc Endo', to_date('27-07-2011', 'dd-mm-yyyy'), 38, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (659, 'Lysine', 'Bypass Colic Vein to Low Vein with Autol Art, Open Approach', to_date('22-05-2010', 'dd-mm-yyyy'), 48, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (661, 'Progesterone', 'Removal of Synth Sub from L Low Femur, Perc Approach', to_date('10-02-2025', 'dd-mm-yyyy'), 37, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (662, 'OCTINOXATE', 'Drainage of Right Inguinal Region, Perc Approach, Diagn', to_date('19-07-2024', 'dd-mm-yyyy'), 35, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (664, 'Argentum nitricum', 'Repair Left Foot Muscle, Percutaneous Approach', to_date('01-09-2010', 'dd-mm-yyyy'), 34, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (665, 'levodopa', 'Drainage of Left Upper Arm Tendon, Open Approach, Diagnostic', to_date('14-05-2017', 'dd-mm-yyyy'), 45, '1');
commit;
prompt 500 records committed...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (667, 'polymyxin b sulfate', 'Fusion C-thor Jt w Autol Sub, Post Appr A Col, Perc', to_date('21-05-2009', 'dd-mm-yyyy'), 10, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (668, 'Bellis perennis', 'Fluoroscopy of Head and Neck', to_date('19-03-2015', 'dd-mm-yyyy'), 47, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (670, 'Sulphuricum acidum', 'Head and Facial Bones, Destruction', to_date('18-11-2011', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (671, 'Fluoxetine Hydrochloride', 'Revision of Nonaut Sub in T-lum Jt, Open Approach', to_date('12-06-2016', 'dd-mm-yyyy'), 36, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (673, 'Chlorpehniramine HCl', 'Revision of Autol Sub in L Acetabulum, Open Approach', to_date('26-01-2011', 'dd-mm-yyyy'), 33, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (674, 'Chicken Feathers', 'Dilate R Subclav Art, Bifurc, w 2 Drug-elut, Open', to_date('27-05-2024', 'dd-mm-yyyy'), 15, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (676, 'Titanium Dioxide', 'Release Right Knee Joint, External Approach', to_date('04-04-2013', 'dd-mm-yyyy'), 11, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (677, 'Leucine', 'Occlusion of Lg Intest with Extralum Dev, Perc Endo Approach', to_date('23-05-2019', 'dd-mm-yyyy'), 31, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (679, 'Oxymorphone hydrochloride', 'Reposition R Humeral Head w Monopln Ext Fix, Perc Endo', to_date('14-01-2017', 'dd-mm-yyyy'), 20, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (680, 'OCTINOXATE', 'Release Optic Nerve, Percutaneous Endoscopic Approach', to_date('26-09-2008', 'dd-mm-yyyy'), 44, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (682, 'Arnica Aurum Equisetum', 'Bypass Colic Vein to Low Vein with Autol Art, Open Approach', to_date('23-02-2020', 'dd-mm-yyyy'), 34, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (683, 'Stannum metallicum', 'Introduction of Oth Therap Subst into Eye, Via Opening', to_date('09-01-2011', 'dd-mm-yyyy'), 45, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (685, 'amlodipine besylate', 'Removal of Radioactive Element from Lower Jaw, Perc Approach', to_date('12-11-2019', 'dd-mm-yyyy'), 19, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (686, 'phenylephrine HCl', 'Reposition Left Foot Muscle, Perc Endo Approach', to_date('14-06-2007', 'dd-mm-yyyy'), 14, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (688, 'Erythropoietin', 'Drainage of Left Lacrimal Bone with Drain Dev, Open Approach', to_date('10-08-2011', 'dd-mm-yyyy'), 25, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (689, 'Veratrum album', 'Reposition Left Neck Muscle, Open Approach', to_date('16-11-2017', 'dd-mm-yyyy'), 35, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (691, 'Metoclopramide', 'Extirpate matter from L Ankle Bursa/Lig, Perc Endo', to_date('21-05-2009', 'dd-mm-yyyy'), 21, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (692, 'Phosphorus', 'Revision of Synth Sub in R Finger Phalanx, Open Approach', to_date('11-04-2023', 'dd-mm-yyyy'), 26, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (694, 'Bellis Perennis', 'Release Left Diaphragm, Open Approach', to_date('20-06-2011', 'dd-mm-yyyy'), 36, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (695, 'Diclofenac Sodium', 'Drain of L Trunk Muscle with Drain Dev, Perc Endo Approach', to_date('20-07-2020', 'dd-mm-yyyy'), 43, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (697, 'Hamamelis', 'Revision of Nonaut Sub in T-lum Jt, Open Approach', to_date('19-05-2021', 'dd-mm-yyyy'), 43, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (698, 'oxybenzone', 'Removal of Drainage Device from L Elbow Jt, Perc Approach', to_date('16-11-2006', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (700, 'misoprostol', 'Destruction of Right Fallopian Tube, Open Approach', to_date('26-01-2008', 'dd-mm-yyyy'), 27, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (701, 'Glycyrrha glabra', 'Removal of Autol Sub from Coccyx, Perc Endo Approach', to_date('17-12-2015', 'dd-mm-yyyy'), 18, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (703, 'Polygonum multiflorum', 'Revision of Drainage Device in Lumsac Disc, Extern Approach', to_date('26-09-2015', 'dd-mm-yyyy'), 29, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (704, 'Phenylalanine', 'Removal of Radioactive Element from Up Jaw, Extern Approach', to_date('25-11-2017', 'dd-mm-yyyy'), 31, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (706, 'Avobenzone', 'Replace of Pancreat Duct with Synth Sub, Perc Endo Approach', to_date('14-12-2011', 'dd-mm-yyyy'), 43, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (707, 'Metoclopramide', 'Reposition Accessory Nerve, Open Approach', to_date('17-09-2013', 'dd-mm-yyyy'), 34, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (709, 'Kalmia latifolia', 'Excision of Left Face Vein, Open Approach, Diagnostic', to_date('02-09-2020', 'dd-mm-yyyy'), 28, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (711, 'fentanyl transdermal system', 'Chiropractic Manipulation of Abdomen, Extra-Articular', to_date('15-06-2026', 'dd-mm-yyyy'), 31, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (712, 'Naproxen sodium', 'Insertion of Other Device into L Wrist, Perc Approach', to_date('24-05-2005', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (714, 'Sanguinaria canadensis', 'Dilation of R Ext Iliac Art with 2 Drug-elut, Perc Approach', to_date('19-04-2019', 'dd-mm-yyyy'), 28, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (715, 'risperidone', 'Inspection of Left Shoulder Region, External Approach', to_date('25-03-2005', 'dd-mm-yyyy'), 48, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (717, 'Aesculus hipp.', 'Insertion of Stimulator Lead into Bladder, Via Opening', to_date('25-10-2021', 'dd-mm-yyyy'), 33, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (718, 'Calcarea carbonica', 'Cochlear Implant Assessment using Hear Aid Equipment', to_date('25-09-2022', 'dd-mm-yyyy'), 30, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (720, 'Nicotine Polacrilex', 'Bypass L Com Iliac Art to B Int Ilia w Autol Art, Perc Endo', to_date('10-01-2006', 'dd-mm-yyyy'), 25, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (721, 'BENZOYL PEROXIDE', 'Restriction of R Neck Lymph with Extralum Dev, Perc Approach', to_date('28-01-2014', 'dd-mm-yyyy'), 47, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (722, 'Gerbil Epithelia', 'Excision of R Temporomandib Jt, Perc Endo Approach, Diagn', to_date('19-02-2012', 'dd-mm-yyyy'), 24, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (723, 'Carbamazepine', 'Destruction of Thyroid Gland, Perc Endo Approach', to_date('11-06-2010', 'dd-mm-yyyy'), 16, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (724, 'Doxepin Hydrochloride', 'Remove Synth Sub from Prostate/Seminal Ves, Perc Endo', to_date('25-09-2011', 'dd-mm-yyyy'), 40, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (725, 'DIMETHICONE', 'Removal of Autol Sub from L Shoulder Jt, Perc Endo Approach', to_date('18-03-2005', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (726, 'OCTISALATE', 'Dilation of R Post Tib Art with 3 Drug-elut, Open Approach', to_date('02-08-2009', 'dd-mm-yyyy'), 41, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (727, 'hydrocortisone', 'Reposition Accessory Nerve, Open Approach', to_date('05-06-2006', 'dd-mm-yyyy'), 33, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (728, 'Tizanidine', 'Bypass 3 Cor Art from Thor Art w Autol Vn, Perc Endo', to_date('22-11-2007', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (729, 'Mesquite', 'Change Drainage Device in Liver, External Approach', to_date('03-09-2010', 'dd-mm-yyyy'), 48, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (730, 'Juniperus communis', 'Replace of Chest Subcu/Fascia with Synth Sub, Open Approach', to_date('27-12-2021', 'dd-mm-yyyy'), 25, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (731, 'Mirtazapine', 'Insertion of Intraluminal Device into Jejunum, Open Approach', to_date('22-12-2024', 'dd-mm-yyyy'), 21, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (732, 'ampicillin sodium', 'Revision of Autologous Tissue Substitute in R Breast, Endo', to_date('25-02-2017', 'dd-mm-yyyy'), 41, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (733, 'Hepar suis', 'Dilate of R Verteb Art with 3 Drug-elut, Perc Endo Approach', to_date('23-10-2014', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (734, 'White Petrolatum', 'Remove Synth Sub from Prostate/Seminal Ves, Perc Endo', to_date('20-04-2015', 'dd-mm-yyyy'), 13, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (735, 'Sodium Monofluorophosphate Silicon Dioxide', 'Replacement of L Kidney Pelvis with Synth Sub, Open Approach', to_date('24-11-2005', 'dd-mm-yyyy'), 39, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (736, 'HYDROCORTISONE', 'Reposition Pulmonary Trunk, Open Approach', to_date('22-10-2024', 'dd-mm-yyyy'), 28, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (737, 'Tyrosine', 'Removal of Drainage Device from Lower Jaw, Open Approach', to_date('23-05-2005', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (738, 'Phytolacca', 'Drainage of Left Thorax Tendon, Percutaneous Approach', to_date('04-12-2009', 'dd-mm-yyyy'), 43, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (739, 'Spleen (suis)', 'Supplement L Basilic Vein with Synth Sub, Perc Endo Approach', to_date('13-10-2022', 'dd-mm-yyyy'), 18, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (740, 'SANGUINARIA CANADENSIS ROOT', 'Drainage of Left Vertebral Artery, Percutaneous Approach', to_date('15-08-2016', 'dd-mm-yyyy'), 35, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (742, 'Loratadine', 'HDR Brachytherapy of Chest Wall using Palladium 103', to_date('12-12-2018', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (743, 'SULFUR', 'Plain Radiography of Uterus & Fallopian using H Osm Contrast', to_date('03-11-2008', 'dd-mm-yyyy'), 26, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (745, 'levothyroxine sodium', 'Bypass R Subclav Art to L Low Arm Art w Synth Sub, Open', to_date('13-10-2017', 'dd-mm-yyyy'), 47, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (746, 'Thymus (suis)', 'Destruction of Left Inguinal Lymphatic, Perc Endo Approach', to_date('14-03-2005', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (748, 'CLADOSPORIUM SPHAEROSPERMUM', 'Replacement of R Fem Art with Nonaut Sub, Perc Endo Approach', to_date('17-02-2010', 'dd-mm-yyyy'), 10, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (749, 'Hydrastis', 'CT Scan of Bi Int Carotid using L Osm Contrast', to_date('20-02-2016', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (751, 'Octocrylene', 'Muscle Perform Treatment of Neuro Head, Neck using Orthosis', to_date('01-05-2019', 'dd-mm-yyyy'), 39, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (752, 'Gabapentin', 'Excision of Left Wrist Region, Open Approach', to_date('26-06-2007', 'dd-mm-yyyy'), 31, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (754, 'Soft Cheat Brome', 'Repair Right Hip Bursa and Ligament, Percutaneous Approach', to_date('02-02-2018', 'dd-mm-yyyy'), 24, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (755, 'Magnesium hydroxide', 'Restriction of L Main Bronc with Intralum Dev, Perc Approach', to_date('02-05-2010', 'dd-mm-yyyy'), 31, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (757, 'PRAMOXINE HYDROCHLORIDE', 'Replacement of Left Eye with Autol Sub, Perc Approach', to_date('12-09-2015', 'dd-mm-yyyy'), 28, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (758, 'Vipera berus', 'Insertion of Int Fix into R Sphenoid Bone, Open Approach', to_date('27-07-2005', 'dd-mm-yyyy'), 23, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (760, 'Chlorpehniramine HCl', 'Repair Nasal Bone, External Approach', to_date('11-09-2025', 'dd-mm-yyyy'), 16, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (761, 'Pueraria lobata', 'Supplement L Temporomandib Jt with Autol Sub, Open Approach', to_date('09-06-2005', 'dd-mm-yyyy'), 25, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (763, 'clonidine hydrochloride', 'Revision of Synth Sub in L Finger Phalanx Jt, Open Approach', to_date('24-11-2012', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (764, 'Risperidone', 'Dilate R Int Mamm Art, Bifurc, w 2 Drug-elut, Open', to_date('11-04-2016', 'dd-mm-yyyy'), 14, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (766, 'Hepar suis', 'Restriction of L Main Bronc with Intralum Dev, Perc Approach', to_date('18-07-2007', 'dd-mm-yyyy'), 18, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (767, 'Cinchona', 'Extirpation of Matter from Bladder Neck, Endo', to_date('01-10-2014', 'dd-mm-yyyy'), 45, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (769, 'phenylephrine HCl', 'Revision of Infusion Dev in T-lum Disc, Perc Endo Approach', to_date('15-01-2009', 'dd-mm-yyyy'), 18, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (770, 'OCTINOXATE OCTISALATE OXYBENZONE', 'Release Left Metacarpophalangeal Joint, Open Approach', to_date('06-12-2007', 'dd-mm-yyyy'), 21, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (772, 'Phosphorus', 'Replacement of Right Radius with Synth Sub, Perc Approach', to_date('12-04-2013', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (773, 'GLYCINE', 'Occlusion of Carina with Extraluminal Device, Perc Approach', to_date('13-07-2020', 'dd-mm-yyyy'), 23, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (775, 'dalteparin sodium', 'Introduce Oth Therap Subst in Male Reprod, Perc', to_date('19-03-2017', 'dd-mm-yyyy'), 37, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (776, 'Threonine', 'Revision of Nonaut Sub in Penis, Open Approach', to_date('01-06-2020', 'dd-mm-yyyy'), 12, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (778, 'phenylephrine HCl', 'Release Scalp Subcutaneous Tissue and Fascia, Perc Approach', to_date('17-02-2009', 'dd-mm-yyyy'), 11, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (780, 'Sepia', 'Removal of Ext Fix from R Femur Shaft, Extern Approach', to_date('09-08-2007', 'dd-mm-yyyy'), 27, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (781, 'Carisoprodol', 'Excision of Right Pelvic Bone, Percutaneous Approach, Diagn', to_date('26-09-2018', 'dd-mm-yyyy'), 46, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (783, 'Glimepiride', 'Reposition L Up Femur with Monopln Ext Fix, Perc Approach', to_date('08-07-2021', 'dd-mm-yyyy'), 36, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (784, 'Benzocaine', 'Bypass Asc Colon to Trans Colon w Autol Sub, Perc Endo', to_date('19-08-2014', 'dd-mm-yyyy'), 19, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (786, 'ATORVASTATIN CALCIUM', 'Excision of Left Femoral Shaft, Percutaneous Approach', to_date('24-08-2010', 'dd-mm-yyyy'), 38, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (787, 'Phenylephrine hydrochloride', 'Reposition L Sternoclav Jt with Int Fix, Open Approach', to_date('19-05-2017', 'dd-mm-yyyy'), 41, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (789, 'Bryonia', 'Repair Left Knee Tendon, Percutaneous Approach', to_date('02-08-2020', 'dd-mm-yyyy'), 20, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (790, 'Coal Tar', 'Release Right Metacarpophalangeal Joint, Open Approach', to_date('12-04-2015', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (792, 'Carbo vegetabilis', 'Release Right Shoulder Joint, Open Approach', to_date('16-12-2018', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (793, 'BACLOFEN', 'Removal of Synth Sub from Cranial Cav, Perc Endo Approach', to_date('22-11-2016', 'dd-mm-yyyy'), 29, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (795, 'SULFUR', 'Occlusion of Carina with Extraluminal Device, Perc Approach', to_date('21-10-2023', 'dd-mm-yyyy'), 38, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (796, 'OCTINOXATE', 'Bypass L Int Jugular Vein to Up Vein w Nonaut Sub, Perc Endo', to_date('21-05-2016', 'dd-mm-yyyy'), 48, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (798, 'Estradiol', 'Drainage of Carina, Percutaneous Endoscopic Approach, Diagn', to_date('22-12-2008', 'dd-mm-yyyy'), 24, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (799, 'CHLORPROMAZINE HYDROCHLORIDE', 'Revision of Ext Fix in R Tarsal, Extern Approach', to_date('02-09-2020', 'dd-mm-yyyy'), 48, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (801, 'Bryonia', 'Bypass R Int Iliac Art to R Ext Ilia w Synth Sub, Open', to_date('09-02-2026', 'dd-mm-yyyy'), 47, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (802, 'Triclosan', 'Repair Nasal Bone, External Approach', to_date('04-05-2009', 'dd-mm-yyyy'), 34, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (803, 'norethindrone acetate/ethinyl estradiol', 'Removal of Synth Sub from L Clavicle, Perc Endo Approach', to_date('05-10-2013', 'dd-mm-yyyy'), 34, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (804, 'CLADOSPORIUM SPHAEROSPERMUM', 'Extirpate matter from Uterine Support Struct, Perc Endo', to_date('02-11-2008', 'dd-mm-yyyy'), 14, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (805, 'ATROPINE SULFATE', 'Removal of Synth Sub from Cranial Cav, Perc Endo Approach', to_date('10-05-2016', 'dd-mm-yyyy'), 31, '4');
commit;
prompt 600 records committed...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (806, 'Zinc Oxide', 'Dilation of Portal Vein with Intralum Dev, Perc Approach', to_date('08-12-2015', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (807, 'Dextromethorphan HBr', 'Release Right Metacarpophalangeal Joint, Open Approach', to_date('19-04-2016', 'dd-mm-yyyy'), 20, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (808, 'Magnesium Hydroxide', 'Alteration of Left Axilla with Autol Sub, Perc Endo Approach', to_date('22-04-2020', 'dd-mm-yyyy'), 27, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (809, 'sodium chloride', 'Removal of Ext Fix from R Femur Shaft, Extern Approach', to_date('18-07-2005', 'dd-mm-yyyy'), 42, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (810, 'Octinoxate', 'Drainage of Pancreatic Duct, Percutaneous Approach, Diagn', to_date('02-01-2024', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (811, 'Benzethonium Chloride', 'Dilate Sup Mesent Art, Bifurc, w Intralum Dev, Perc Endo', to_date('07-11-2012', 'dd-mm-yyyy'), 24, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (812, 'PREGABALIN', 'Dilation of L Axilla Art with Drug-elut Intra, Open Approach', to_date('04-01-2015', 'dd-mm-yyyy'), 38, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (813, 'Cuprum metallicum', 'Resection of Left Superior Parathyroid Gland, Open Approach', to_date('24-08-2025', 'dd-mm-yyyy'), 43, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (814, 'zolpidem tartrate', 'Aural Rehabilitation Status Assessment using AV Equipment', to_date('06-12-2006', 'dd-mm-yyyy'), 37, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (815, 'ATP (Adenosine Triphosphate Disodium)', 'Excision of L Up Extrem Lymph, Perc Endo Approach, Diagn', to_date('23-07-2025', 'dd-mm-yyyy'), 25, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (816, 'Glimepiride', 'Revision of Bone Stim in Up Bone, Extern Approach', to_date('01-03-2020', 'dd-mm-yyyy'), 13, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (817, 'Benzethonium chloride', 'Supplement Cervical Nerve with Autol Sub, Perc Endo Approach', to_date('07-04-2022', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (818, 'THREONINE', 'Revision of Int Fix in Lum Jt, Perc Approach', to_date('03-03-2022', 'dd-mm-yyyy'), 20, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (819, 'Hypothalamus', 'Release Right Metacarpophalangeal Joint, Open Approach', to_date('19-12-2012', 'dd-mm-yyyy'), 31, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (820, 'Cholesterinum', 'Removal of Autol Sub from Mediastinum, Perc Endo Approach', to_date('08-07-2017', 'dd-mm-yyyy'), 18, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (822, 'Saline Laxative', 'Insertion of Intralum Dev into R Brach Vein, Open Approach', to_date('28-09-2008', 'dd-mm-yyyy'), 20, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (823, 'Glycyrrha glabra', 'Bursae and Ligaments, Revision', to_date('24-05-2005', 'dd-mm-yyyy'), 24, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (825, 'Guaifenesin', 'Insert VAD Reservoir in R Low Arm Subcu/Fascia, Open', to_date('20-05-2024', 'dd-mm-yyyy'), 19, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (826, 'SERINE', 'Revision of Int Fix in L Humeral Shaft, Extern Approach', to_date('06-11-2013', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (828, 'ETHYL ALCOHOL', 'Dilate R Subclav Art, Bifurc, w 2 Drug-elut, Open', to_date('08-01-2005', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (829, 'OCTOCRYLENE', 'Removal of Infusion Device from Up Art, Perc Endo Approach', to_date('03-07-2007', 'dd-mm-yyyy'), 18, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (831, 'Loratadine', 'Repair Left Heart, Open Approach', to_date('22-01-2007', 'dd-mm-yyyy'), 29, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (832, 'HYDROXYPROLINE', 'Bypass R Axilla Art to R Extracran Art w Autol Art, Open', to_date('03-10-2006', 'dd-mm-yyyy'), 34, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (834, 'Ciprofloxacin Hydrochloride', 'Supplement L Axilla Art with Synth Sub, Perc Endo Approach', to_date('09-11-2007', 'dd-mm-yyyy'), 38, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (835, 'Benzethonium Chloride', 'Drainage of Left Lacrimal Bone with Drain Dev, Open Approach', to_date('26-09-2011', 'dd-mm-yyyy'), 13, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (836, 'Amoxicillin', 'Extraction of Upper Tooth, All, External Approach', to_date('27-12-2006', 'dd-mm-yyyy'), 24, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (838, 'Benzoicum acidum', 'Extirpation of Matter from R Inf Parathyroid, Open Approach', to_date('22-08-2010', 'dd-mm-yyyy'), 32, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (839, 'SENNOSIDES A', 'Destruction of Right Fallopian Tube, Open Approach', to_date('02-10-2007', 'dd-mm-yyyy'), 44, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (841, 'Carduus Oxalis', 'Cochlear Implant Assessment using Hear Aid Equipment', to_date('17-05-2009', 'dd-mm-yyyy'), 45, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (842, 'Amino acids', 'CT Scan of Bi Pulm Vein using L Osm Contrast, Unenh, Enhance', to_date('25-04-2017', 'dd-mm-yyyy'), 47, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (844, 'Propranolol Hydrochloride', 'Change Other Device in Up Intest Tract, Extern Approach', to_date('13-02-2024', 'dd-mm-yyyy'), 30, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (846, 'Fluoxetine Hydrochloride', 'Bypass R Axilla Art to R Low Arm Art w Autol Art, Open', to_date('28-10-2006', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (847, 'Sweet Vernal Grass', 'Release Right Shoulder Joint, Open Approach', to_date('14-06-2005', 'dd-mm-yyyy'), 42, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (849, 'Alanine', 'Plain Radiography of Uterus & Fallopian using H Osm Contrast', to_date('11-08-2019', 'dd-mm-yyyy'), 48, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (850, 'Clonazepam', 'Restrict Cystic Duct w Intralum Dev, Perc Endo', to_date('15-10-2020', 'dd-mm-yyyy'), 33, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (852, 'Doxylamine succinate', 'Drainage of Bilateral Fallopian Tubes, Endo', to_date('21-08-2019', 'dd-mm-yyyy'), 34, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (853, 'ascorbic acid', 'Insertion of Oth Dev into Retroperitoneum, Open Approach', to_date('06-06-2014', 'dd-mm-yyyy'), 46, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (855, 'Acetaldehyde', 'Supplement L Abd Bursa/Lig w Synth Sub, Perc Endo', to_date('11-05-2010', 'dd-mm-yyyy'), 20, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (856, 'Acetaminophen', 'Drain of L Trunk Muscle with Drain Dev, Perc Endo Approach', to_date('15-07-2006', 'dd-mm-yyyy'), 44, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (858, 'BACLOFEN', 'Drainage of Right Thyroid Gland Lobe, Perc Endo Approach', to_date('01-09-2007', 'dd-mm-yyyy'), 33, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (859, 'PRAVASTATIN SODIUM', 'Repair Left Hip Joint, Percutaneous Endoscopic Approach', to_date('07-08-2013', 'dd-mm-yyyy'), 46, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (861, 'Bryonia', 'Removal of Int Fix from R Toe Phalanx Jt, Perc Endo Approach', to_date('14-12-2021', 'dd-mm-yyyy'), 20, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (862, 'PHOSPHORIC ACID', 'Revision of Other Device in Cranial Cavity, Extern Approach', to_date('22-03-2020', 'dd-mm-yyyy'), 21, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (864, 'Pulsatilla', 'Drainage of R Occipital Bone with Drain Dev, Perc Approach', to_date('08-11-2007', 'dd-mm-yyyy'), 30, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (865, 'fluvoxamine maleate', 'Replacement of R Hand Art with Autol Sub, Perc Endo Approach', to_date('10-03-2011', 'dd-mm-yyyy'), 43, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (867, 'Dermatophagoides farinae', 'Revision of Ext Fix in R Ulna, Extern Approach', to_date('11-03-2019', 'dd-mm-yyyy'), 26, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (868, 'Diltiazem Hydrochloride', 'Excision of Left Toe Phalangeal Joint, Percutaneous Approach', to_date('12-04-2005', 'dd-mm-yyyy'), 31, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (870, 'Eptifibatide', 'Excision of Left Upper Arm, Percutaneous Endoscopic Approach', to_date('21-11-2022', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (871, 'Ibuprofen', 'Removal of Nonaut Sub from Mouth/Throat, Endo', to_date('05-10-2005', 'dd-mm-yyyy'), 12, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (873, 'Salicylic Acid', 'Removal of Drainage Device from Left Eye, External Approach', to_date('20-05-2026', 'dd-mm-yyyy'), 33, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (874, 'dextromethorphan hydrobromide', 'Extirpation of Matter from R Adrenal Gland, Perc Approach', to_date('18-12-2026', 'dd-mm-yyyy'), 48, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (876, 'Bryonia', 'Drainage of Right Main Bronchus, Perc Endo Approach', to_date('10-04-2024', 'dd-mm-yyyy'), 31, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (877, 'ZINC OXIDE TITANIUM DIOXIDE', 'Control Bleeding in Left Upper Arm, Open Approach', to_date('26-08-2005', 'dd-mm-yyyy'), 20, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (879, 'antihemophilic factor/von', 'Replace of Pancreat Duct with Synth Sub, Perc Endo Approach', to_date('17-12-2013', 'dd-mm-yyyy'), 31, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (880, 'ATP (Adenosine Triphosphate Disodium)', 'Repair Left Temporal Bone, Percutaneous Approach', to_date('23-01-2010', 'dd-mm-yyyy'), 28, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (881, 'Oxygen', 'Dilate Sup Mesent Art, Bifurc, w Intralum Dev, Perc Endo', to_date('24-03-2006', 'dd-mm-yyyy'), 23, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (882, 'Octisalate', 'Excision of Right Innominate Vein, Percutaneous Approach', to_date('09-11-2022', 'dd-mm-yyyy'), 36, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (883, 'Topiramate', 'Alteration of L Ext Ear with Synth Sub, Perc Endo Approach', to_date('14-10-2009', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (884, 'Oxalicum acidum', 'Insertion of Monitor Dev into L Diaphragm, Perc Approach', to_date('09-08-2026', 'dd-mm-yyyy'), 46, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (885, 'OLANZAPINE', 'Inspection of Sacrococcygeal Joint, External Approach', to_date('14-10-2016', 'dd-mm-yyyy'), 46, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (886, 'PREGABALIN', 'Reposition L Up Femur with Monopln Ext Fix, Perc Approach', to_date('12-06-2017', 'dd-mm-yyyy'), 36, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (887, 'Titanium Dioxide', 'Supplement L Verteb Vein with Nonaut Sub, Open Approach', to_date('15-01-2025', 'dd-mm-yyyy'), 45, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (888, 'VANCOMYCIN HYDROCHLORIDE', 'Revision of Neuro Lead in Cranial Nrv, Open Approach', to_date('02-08-2008', 'dd-mm-yyyy'), 34, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (889, 'HISTIDINE', 'Repair Left Foot, External Approach', to_date('04-09-2026', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (890, 'Pareira', 'Resection of Large Intestine, Endo', to_date('19-02-2020', 'dd-mm-yyyy'), 14, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (891, 'Titanium Dioxide', 'Excision of Left Carotid Body, Percutaneous Approach', to_date('18-02-2007', 'dd-mm-yyyy'), 18, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (892, 'Platinum metallicum', 'Excision of Right Pelvic Bone, Percutaneous Approach, Diagn', to_date('25-08-2019', 'dd-mm-yyyy'), 21, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (893, 'Titanium Dioxide', 'Supplement Cervical Nerve with Autol Sub, Perc Endo Approach', to_date('24-12-2021', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (894, 'Phenylephrine HCl', 'Transfuse Autol Frozen Red Cells in Central Art, Open', to_date('18-08-2021', 'dd-mm-yyyy'), 21, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (895, 'loteprednol etabonate', 'Revision of Autol Sub in L Breast, Extern Approach', to_date('13-06-2020', 'dd-mm-yyyy'), 23, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (896, 'verapamil hydrochloride', 'Revision of Extralum Dev in Up Intest Tract, Via Opening', to_date('04-10-2025', 'dd-mm-yyyy'), 20, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (897, 'Gelsemium', 'Repair Left Foot Muscle, Percutaneous Approach', to_date('22-12-2010', 'dd-mm-yyyy'), 23, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (898, 'Torula cerevisiae', 'Dilation of Portal Vein with Intralum Dev, Perc Approach', to_date('08-06-2018', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (899, 'SULFACETAMIDE SODIUM', 'Revision of Ext Fix in R Ulna, Extern Approach', to_date('20-11-2010', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (901, 'HOMOSALATE', 'Insertion of Neuro Lead into Brain, Perc Endo Approach', to_date('08-06-2010', 'dd-mm-yyyy'), 12, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (902, 'estradiol', 'Introduce Local Anesth in Skin/Mucous Mem, Extern', to_date('15-05-2006', 'dd-mm-yyyy'), 12, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (904, 'Acetaminophen', 'Fusion of Left Wrist Joint with Synth Sub, Perc Approach', to_date('22-09-2018', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (905, 'Dextromethorphan HBr', 'Occlusion of Lg Intest with Extralum Dev, Perc Endo Approach', to_date('24-11-2015', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (907, 'Niacinamide', 'Dilate R Int Carotid, Bifurc, w 3 Drug-elut, Perc Endo', to_date('15-02-2020', 'dd-mm-yyyy'), 26, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (908, 'THREONINE', 'Drainage of Left Thorax Tendon, Percutaneous Approach', to_date('16-06-2022', 'dd-mm-yyyy'), 35, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (910, 'Mirtazapine', 'Dilate L Com Carotid, Bifurc, w 4 Drug-elut, Perc', to_date('11-12-2026', 'dd-mm-yyyy'), 15, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (911, 'Ranitidine', 'Dilation of Right Hand Artery, Percutaneous Approach', to_date('17-09-2022', 'dd-mm-yyyy'), 37, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (913, 'OXYBENZONE', 'Introduction of Destr Agent into Fem Reprod, Via Opening', to_date('22-07-2007', 'dd-mm-yyyy'), 31, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (914, 'calcipotriene', 'Bypass Bi Ureter to Colon w Nonaut Sub, Perc Endo', to_date('25-08-2011', 'dd-mm-yyyy'), 45, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (916, 'benztropine mesylate', 'CT Scan L Pelvic Vein w H Osm Contrast, Unenh, Enhance', to_date('21-12-2026', 'dd-mm-yyyy'), 27, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (918, 'Triclocarban', 'Revision of Autologous Tissue Substitute in R Breast, Endo', to_date('12-11-2014', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (919, 'Sertraline Hydrochloride', 'Release Right Metacarpophalangeal Joint, Open Approach', to_date('17-07-2024', 'dd-mm-yyyy'), 20, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (921, 'Ciprofloxacin Hydrochloride', 'Head and Facial Bones, Destruction', to_date('24-12-2024', 'dd-mm-yyyy'), 29, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (922, 'Phytolacca', 'Bypass R Axilla Art to R Low Arm Art w Autol Art, Open', to_date('10-10-2014', 'dd-mm-yyyy'), 22, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (924, 'GUAIFENESIN', 'Excision of Cervical Vertebral Disc, Perc Approach, Diagn', to_date('11-12-2015', 'dd-mm-yyyy'), 39, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (926, 'Nux vomica', 'Revision of Nonaut Sub in Hepatobil Duct, Perc Endo Approach', to_date('04-03-2021', 'dd-mm-yyyy'), 44, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (927, 'Mirtazapine', 'Alteration of Left Axilla with Nonaut Sub, Open Approach', to_date('15-04-2017', 'dd-mm-yyyy'), 25, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (929, 'LEVOFLOXACIN', 'Destruction of Thyroid Gland, Perc Endo Approach', to_date('22-12-2020', 'dd-mm-yyyy'), 41, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (930, 'OXYBENZONE', 'Revision of Nonaut Sub in Penis, Open Approach', to_date('14-09-2007', 'dd-mm-yyyy'), 44, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (932, 'Dextromethorphan HBr', 'Removal of Nonaut Sub from Mouth/Throat, Endo', to_date('13-08-2026', 'dd-mm-yyyy'), 40, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (933, 'Mephitis mephitica', 'Release Scalp Subcutaneous Tissue and Fascia, Perc Approach', to_date('23-09-2014', 'dd-mm-yyyy'), 13, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (935, 'indomethacin', 'Reposition Right Tibia with Monopln Ext Fix, Perc Approach', to_date('12-09-2015', 'dd-mm-yyyy'), 15, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (936, 'OCTINOXATE', 'Extirpation of Matter from R Sperm Cord, Perc Approach', to_date('13-09-2022', 'dd-mm-yyyy'), 45, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (938, 'OCTINOXATE', 'Creation of Penis in Female Perineum, Open Approach', to_date('18-11-2017', 'dd-mm-yyyy'), 14, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (939, 'Cocklebur', 'Revision of Int Fix in L Humeral Shaft, Extern Approach', to_date('16-04-2012', 'dd-mm-yyyy'), 42, '4');
commit;
prompt 700 records committed...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (941, 'Magnesium hydroxide', 'Replacement of Esophagus with Autol Sub, Open Approach', to_date('24-07-2021', 'dd-mm-yyyy'), 41, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (943, 'Diphenhydramine Hydrochloride', 'LDR Brachytherapy of Pancreas using Californium 252', to_date('26-05-2016', 'dd-mm-yyyy'), 35, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (944, 'Phenylephrine HCl', 'Reposition Right Acetabulum, Perc Endo Approach', to_date('15-02-2024', 'dd-mm-yyyy'), 41, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (945, 'Octisalate', 'Drainage of Bilateral Fallopian Tubes, Endo', to_date('12-12-2006', 'dd-mm-yyyy'), 39, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (947, 'Goose Feathers', 'Drainage of Left Lacrimal Bone with Drain Dev, Open Approach', to_date('10-10-2025', 'dd-mm-yyyy'), 12, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (948, 'Thymus (suis)', 'Extirpation of Matter from R Sperm Cord, Perc Approach', to_date('24-04-2012', 'dd-mm-yyyy'), 42, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (950, 'CIPROFLOXACIN', 'Release Optic Nerve, Percutaneous Endoscopic Approach', to_date('13-05-2007', 'dd-mm-yyyy'), 13, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (951, 'Phytolacca', 'Hyperthermia of Hard Palate', to_date('22-04-2009', 'dd-mm-yyyy'), 16, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (953, 'Monobasic', 'Revision of Ext Fix in R Tarsal, Extern Approach', to_date('13-09-2014', 'dd-mm-yyyy'), 18, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (954, 'Aluminum Zirconium Octachlorohydrex Gly', 'Supplement Hemiazygos Vein with Synth Sub, Perc Approach', to_date('23-02-2023', 'dd-mm-yyyy'), 14, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (956, 'Podofilox', 'Supplement Epiglottis with Synth Sub, Open Approach', to_date('27-08-2023', 'dd-mm-yyyy'), 19, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (957, 'West Wheat Grass', 'LDR Brachytherapy of Pancreas using Californium 252', to_date('14-08-2024', 'dd-mm-yyyy'), 22, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (959, 'Riboflavinum', 'Introduce Oth Therap Subst in Male Reprod, Perc', to_date('19-12-2010', 'dd-mm-yyyy'), 35, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (960, 'Acetaldehyde', 'Drain R Metacarpocarp Jt w Drain Dev, Perc Endo', to_date('13-09-2016', 'dd-mm-yyyy'), 10, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (962, 'Morphine Sulfate', 'Fluency Assessment', to_date('25-08-2026', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (963, 'Sepia', 'Repair Right Lower Arm, Percutaneous Endoscopic Approach', to_date('14-12-2014', 'dd-mm-yyyy'), 30, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (964, 'PROLINE', 'Excision of Right Eustachian Tube, Open Approach, Diagnostic', to_date('08-07-2016', 'dd-mm-yyyy'), 14, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (965, 'Sorbitol', 'Dilate of Intracran Art with Drug-elut Intra, Open Approach', to_date('27-11-2010', 'dd-mm-yyyy'), 14, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (966, 'Homosalate', 'Excision of Left Femoral Shaft, Percutaneous Approach', to_date('02-02-2015', 'dd-mm-yyyy'), 21, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (967, 'Carbamazepine', 'Introduce Electrol/Water Bal in Central Vein, Open', to_date('13-03-2010', 'dd-mm-yyyy'), 25, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (968, 'Dibasic', 'Drainage of Right Main Bronchus, Perc Endo Approach', to_date('02-10-2007', 'dd-mm-yyyy'), 40, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (969, 'Pituitarum posterium', 'Revision of Synthetic Substitute in Low Art, Perc Approach', to_date('10-09-2025', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (970, 'Rhus toxicodendron', 'Division of Right Lower Arm and Wrist Tendon, Open Approach', to_date('10-08-2016', 'dd-mm-yyyy'), 19, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (971, 'Salicylic Acid', 'Dilate 4+ Cor Art, Bifurc, w 2 Intralum Dev, Perc', to_date('24-06-2018', 'dd-mm-yyyy'), 16, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (972, 'ENSULIZOLE', 'Reposition Left Foot Muscle, Perc Endo Approach', to_date('20-12-2010', 'dd-mm-yyyy'), 11, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (973, 'Ledum Palustre', 'Bypass R Hepatic Duct to Cyst Duct w Intralum Dev, Open', to_date('19-12-2014', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (974, 'Aluminum Chlorohydrate', 'Fragmentation in Left Hepatic Duct, Endo', to_date('16-08-2018', 'dd-mm-yyyy'), 41, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (975, 'Saline Laxative', 'Dressing of Right Upper Leg using Bandage', to_date('19-02-2023', 'dd-mm-yyyy'), 36, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (976, 'estradiol', 'Revision of Synth Sub in Up Muscle, Extern Approach', to_date('04-04-2023', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (977, 'Estradiol', 'Supplement Buccal Mucosa with Autol Sub, Extern Approach', to_date('11-04-2022', 'dd-mm-yyyy'), 47, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (978, 'oxybenzone', 'Revision of Drainage Device in Up Intest Tract, Via Opening', to_date('24-04-2013', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (979, 'Oxygen', 'Dilate of R Verteb Art with 3 Drug-elut, Perc Endo Approach', to_date('09-10-2019', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (980, 'Mirtazapine', 'Bypass L Great Saphenous to Low Vein w Synth Sub, Open', to_date('03-08-2005', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (981, 'PHENYLEPHRINE HYDROCHLORIDE', 'Removal of Synth Sub from Cranial Cav, Perc Endo Approach', to_date('05-12-2011', 'dd-mm-yyyy'), 43, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (982, 'LYSINE', 'Excision of Right Eustachian Tube, Open Approach, Diagnostic', to_date('12-02-2021', 'dd-mm-yyyy'), 48, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (983, 'Sabal', 'Excision of Left Toe Phalangeal Joint, Percutaneous Approach', to_date('19-07-2013', 'dd-mm-yyyy'), 19, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (984, 'Nicotine Polacrilex', 'Repair Lumbar Sympathetic Nerve, Percutaneous Approach', to_date('26-06-2011', 'dd-mm-yyyy'), 33, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (985, 'Hypothalamus', 'Bypass Abd Aorta to B Int Ilia w Autol Vn, Perc Endo', to_date('05-05-2015', 'dd-mm-yyyy'), 27, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (986, 'bacitracin zinc', 'Bypass Abd Aorta to B Int Ilia w Autol Vn, Perc Endo', to_date('04-10-2025', 'dd-mm-yyyy'), 22, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (987, 'TITANIUM DIOXIDE', 'Extirpation of Matter from R Axilla Art, Perc Endo Approach', to_date('10-07-2007', 'dd-mm-yyyy'), 33, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (988, 'THREONINE', 'Release Scalp Subcutaneous Tissue and Fascia, Perc Approach', to_date('22-08-2006', 'dd-mm-yyyy'), 47, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (989, 'Hydrogen Peroxide', 'Revise Tissue Expander in Up Extrem Subcu/Fascia, Open', to_date('08-05-2016', 'dd-mm-yyyy'), 28, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (990, 'PHOSPHORIC ACID', 'Removal of Drain Dev from Cisterna Chyli, Perc Endo Approach', to_date('20-01-2024', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (991, 'Asparagus', 'Insertion of Radioactive Element into GU Tract, Via Opening', to_date('08-02-2011', 'dd-mm-yyyy'), 22, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (992, 'Sulphuricum acidum', 'Insertion of Int Fix into L Clavicle, Perc Approach', to_date('01-04-2023', 'dd-mm-yyyy'), 36, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (993, 'morphine sulfate', 'Alteration of Left Axilla with Autol Sub, Perc Endo Approach', to_date('26-10-2024', 'dd-mm-yyyy'), 36, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (994, 'erythromycin', 'Bypass R Hepatic Duct to Cyst Duct w Intralum Dev, Open', to_date('08-09-2012', 'dd-mm-yyyy'), 45, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (995, 'Imipenem', 'Revision of Infusion Dev in T-lum Disc, Perc Endo Approach', to_date('04-06-2014', 'dd-mm-yyyy'), 38, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (996, 'Hydrogen Peroxide', 'Repair Right Hand, Percutaneous Approach', to_date('14-04-2026', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (997, 'Naproxen sodium', 'Supplement Right 1st Toe with Synth Sub, Perc Endo Approach', to_date('26-06-2008', 'dd-mm-yyyy'), 24, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (998, 'Nicotine Polacrilex', 'Repair Thalamus, Percutaneous Endoscopic Approach', to_date('10-09-2022', 'dd-mm-yyyy'), 13, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (999, 'indomethacin', 'Restrict Pancreat Duct w Intralum Dev, Perc Endo', to_date('14-12-2006', 'dd-mm-yyyy'), 29, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (1000, 'PHENYLALANINE', 'Reposition Left Metacarpal, Open Approach', to_date('01-09-2024', 'dd-mm-yyyy'), 16, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (221, 'Hepar suis', 'Excision of Rectum, Via Natural or Artificial Opening', to_date('16-07-2009', 'dd-mm-yyyy'), 10, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (223, 'Octocrylene', 'Dilation of R Mid Lobe Bronc with Intralum Dev, Via Opening', to_date('24-11-2022', 'dd-mm-yyyy'), 37, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (226, 'hydroxyzine pamoate', 'Dilation of R Post Tib Art with 3 Drug-elut, Open Approach', to_date('24-11-2008', 'dd-mm-yyyy'), 23, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (230, 'Diazepam', 'Restriction of Esophagus, Open Approach', to_date('08-11-2014', 'dd-mm-yyyy'), 33, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (232, 'OCTISALATE', 'Excision of Left Femoral Shaft, Percutaneous Approach', to_date('06-03-2023', 'dd-mm-yyyy'), 17, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (235, 'SOLANUM DULCAMARA TOP', 'Beam Radiation of Urethra using Electrons', to_date('16-07-2025', 'dd-mm-yyyy'), 17, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (238, 'Methionine', 'Replacement of Left Eye with Autol Sub, Perc Approach', to_date('21-10-2008', 'dd-mm-yyyy'), 14, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (261, 'Avena sativa', 'Bypass R Vas Deferens to R Vas Def w Synth Sub,', to_date('15-01-2023', 'dd-mm-yyyy'), 43, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (264, 'Levetiracetam', 'Drainage of Left Vertebral Artery, Percutaneous Approach', to_date('19-01-2016', 'dd-mm-yyyy'), 29, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (267, 'Clotrimazole', 'LDR Brachytherapy of Pituitary Gland using Palladium 103', to_date('07-03-2025', 'dd-mm-yyyy'), 44, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (269, 'Dock Sour Sheep Sorrel', 'Insert VAD Reservoir in R Low Arm Subcu/Fascia, Open', to_date('02-12-2019', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (273, 'vobenzone', 'Release Left Main Bronchus, Endo', to_date('04-07-2021', 'dd-mm-yyyy'), 31, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (275, 'SUS SCROFA PLACENTA', 'Supplement L Basilic Vein with Synth Sub, Perc Endo Approach', to_date('20-05-2009', 'dd-mm-yyyy'), 35, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (278, 'temazepam', 'Exercise Trmt Circ Body w Mech/Electromech Equip', to_date('11-05-2014', 'dd-mm-yyyy'), 13, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (281, 'Avobenzone', 'CT Scan of Bi Pulm Vein using L Osm Contrast, Unenh, Enhance', to_date('01-10-2013', 'dd-mm-yyyy'), 15, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (284, 'Ranitidine', 'Excision of Head Muscle, Percutaneous Endoscopic Approach', to_date('25-05-2009', 'dd-mm-yyyy'), 35, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (287, 'Stannum metallicum', 'Occlusion of Left Popliteal Artery, Percutaneous Approach', to_date('10-08-2007', 'dd-mm-yyyy'), 26, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (290, 'Phytolacca', 'Dilate of R Verteb Art with 3 Drug-elut, Perc Endo Approach', to_date('05-11-2021', 'dd-mm-yyyy'), 46, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (293, 'TITANIUM DIOXIDE', 'Excision of Cervical Vertebral Disc, Perc Approach, Diagn', to_date('14-03-2025', 'dd-mm-yyyy'), 12, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (296, 'Uva-ursi', 'Reposition Right Tibia with Monopln Ext Fix, Perc Approach', to_date('26-03-2014', 'dd-mm-yyyy'), 21, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (299, 'Octocrylene', 'Drainage of Transverse Colon with Drain Dev, Via Opening', to_date('15-09-2021', 'dd-mm-yyyy'), 43, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (302, 'Titanium Dioxide', 'Supplement Right 1st Toe with Synth Sub, Perc Endo Approach', to_date('22-07-2008', 'dd-mm-yyyy'), 21, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (305, 'Benazepril Hydrochloride', 'Excision of Left Upper Arm, Percutaneous Endoscopic Approach', to_date('18-08-2022', 'dd-mm-yyyy'), 35, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (308, 'Galantamine Hydrobromide', 'Excision of Right Axilla, Percutaneous Approach, Diagnostic', to_date('15-05-2009', 'dd-mm-yyyy'), 48, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (311, 'Nicotine Polacrilex', 'Replacement of Right Eye with Synth Sub, Perc Approach', to_date('21-08-2007', 'dd-mm-yyyy'), 29, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (315, 'Dextromethorphan HBr', 'Insertion of Int Fix into L Metatarsotars Jt, Perc Approach', to_date('07-03-2026', 'dd-mm-yyyy'), 17, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (318, 'Pueraria lobata', 'Drainage of Hyoid Bone, Percutaneous Endoscopic Approach', to_date('07-07-2026', 'dd-mm-yyyy'), 41, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (341, 'CHLOROXYLENOL', 'Excision of Nasal Septum, Perc Endo Approach, Diagn', to_date('01-06-2020', 'dd-mm-yyyy'), 21, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (343, 'Octinoxate', 'Extirpation of Matter from L Shoulder Tendon, Perc Approach', to_date('01-11-2022', 'dd-mm-yyyy'), 22, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (346, 'Omeprazole', 'Change Other Device in Lower Joint, External Approach', to_date('26-09-2012', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (349, 'Aspirin', 'Bypass L Subclav Art to Bi Up Arm Art w Autol Art, Open', to_date('10-09-2010', 'dd-mm-yyyy'), 48, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (352, 'MENTHOL', 'CT Scan of Bi Int Carotid using L Osm Contrast', to_date('11-04-2009', 'dd-mm-yyyy'), 45, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (355, 'Dog Epithelia', 'MRI of Bi Pelvic Vein using Oth Contrast, Unenh, Enhance', to_date('11-11-2008', 'dd-mm-yyyy'), 27, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (358, 'Hepar Magnesium 4', 'Introduce of Analg/Hypnot/Sedat into GU Tract, Via Opening', to_date('28-08-2010', 'dd-mm-yyyy'), 29, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (361, 'Fexofenadine HCl', 'Drain R Metacarpocarp Jt w Drain Dev, Perc Endo', to_date('20-06-2021', 'dd-mm-yyyy'), 47, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (364, 'Deer Hair', 'Bypass R Radial Art to Low Arm Vein w Autol Art, Open', to_date('19-04-2011', 'dd-mm-yyyy'), 16, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (194, 'Citalopram', 'Revision of Ext Fix in R Tarsal, Extern Approach', to_date('09-07-2005', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (197, 'Aluminum Zirconium Tetrachlorohydrex GLY', 'Drainage of Genitalia Skin, External Approach, Diagnostic', to_date('02-09-2016', 'dd-mm-yyyy'), 24, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (200, 'Titanium Dioxide', 'Fusion of Right Finger Phalangeal Joint, Open Approach', to_date('11-11-2023', 'dd-mm-yyyy'), 25, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (203, 'Threonine', 'CT Scan L Pelvic Vein w H Osm Contrast, Unenh, Enhance', to_date('25-10-2013', 'dd-mm-yyyy'), 17, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (206, 'Pulsatilla', 'Occlusion of Superior Mesenteric Vein, Open Approach', to_date('04-05-2023', 'dd-mm-yyyy'), 42, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (209, 'Guaifenesin', 'Dilate of R Verteb Art with 3 Drug-elut, Perc Endo Approach', to_date('01-12-2023', 'dd-mm-yyyy'), 44, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (212, 'Erythromycin', 'Bypass Lower Esophagus to Cutaneous, Endo', to_date('03-11-2008', 'dd-mm-yyyy'), 40, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (215, 'TITANIUM DIOXIDE', 'Introduce of Local Anesth into Mouth/Phar, Extern Approach', to_date('07-10-2008', 'dd-mm-yyyy'), 32, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (218, 'Hydrocotyle asiatica', 'Extirpate matter from Chordae Tendineae, Perc Endo', to_date('14-04-2017', 'dd-mm-yyyy'), 32, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (1001, 'Aspirin', 'Pain reliever', to_date('17-06-2025 18:37:23', 'dd-mm-yyyy hh24:mi:ss'), 0, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (22, 'Juniperus communis', 'Drainage of Bilateral Fallopian Tubes, Endo', to_date('03-01-2019', 'dd-mm-yyyy'), 42, '3');
commit;
prompt 800 records committed...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (25, 'Juniperus communis', 'Dilation of Jejunum with Intraluminal Device, Via Opening', to_date('03-09-2024', 'dd-mm-yyyy'), 43, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (28, 'Ledum Palustre', 'Alteration of R Axilla with Nonaut Sub, Perc Endo Approach', to_date('09-04-2024', 'dd-mm-yyyy'), 25, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (31, 'Sulfur', 'Drainage of Bilateral Fallopian Tubes, Endo', to_date('26-07-2026', 'dd-mm-yyyy'), 11, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (34, 'Duloxetine', 'Bypass L Great Saphenous to Low Vein w Synth Sub, Open', to_date('21-02-2022', 'dd-mm-yyyy'), 23, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (37, 'Equisetum hyemale', 'Insertion of Other Device into R Knee, Perc Approach', to_date('04-08-2019', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (39, 'Bryonia', 'Dilation of R Ext Iliac Art with 2 Drug-elut, Perc Approach', to_date('10-01-2016', 'dd-mm-yyyy'), 40, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (42, 'Chlorpehniramine HCl', 'Drainage of Right Sphenoid Bone, Perc Endo Approach, Diagn', to_date('28-09-2017', 'dd-mm-yyyy'), 15, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (46, 'Pulsatilla', 'Removal of Autol Sub from Great Vessel, Open Approach', to_date('11-06-2016', 'dd-mm-yyyy'), 31, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (48, 'Pulsatilla', 'Extirpate matter from Uterine Support Struct, Perc Endo', to_date('23-09-2019', 'dd-mm-yyyy'), 43, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (51, 'Calcarea fluorica', 'Reposition Right Anterior Tibial Artery, Open Approach', to_date('11-07-2010', 'dd-mm-yyyy'), 35, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (54, 'Aluminum Zirconium Tetrachlorohydrex Gly', 'Dilation of L Peroneal Art with 4 Drug-elut, Perc Approach', to_date('20-05-2005', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (58, 'West Wheat Grass', 'Drainage of Pancreas, Perc Endo Approach, Diagn', to_date('05-07-2019', 'dd-mm-yyyy'), 10, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (61, 'TITANIUM DIOXIDE', 'Aural Rehabilitation Status Assessment using AV Equipment', to_date('11-09-2005', 'dd-mm-yyyy'), 46, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (64, 'Acetaminophen', 'Revise of Infusion Dev in R Metatarsotars Jt, Open Approach', to_date('01-05-2024', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (67, 'Isosorbide Dinitrate', 'Introduce of Local Anesth into Mouth/Phar, Extern Approach', to_date('07-07-2025', 'dd-mm-yyyy'), 46, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (70, 'Morphine Sulfate', 'Fusion of Left Wrist Joint with Synth Sub, Perc Approach', to_date('17-12-2006', 'dd-mm-yyyy'), 16, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (73, 'Atenolol', 'Excision of Left Femoral Shaft, Percutaneous Approach', to_date('25-07-2013', 'dd-mm-yyyy'), 28, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (76, 'Carisoprodol', 'Replace of Chest Subcu/Fascia with Synth Sub, Open Approach', to_date('26-02-2019', 'dd-mm-yyyy'), 41, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (99, 'Terazosin hydrochloride', 'Introduction of Oth Therap Subst into Eye, Via Opening', to_date('27-11-2017', 'dd-mm-yyyy'), 26, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (102, 'CIPROFLOXACIN', 'Reposition L Humeral Head with Hybrid Ext Fix, Open Approach', to_date('14-05-2021', 'dd-mm-yyyy'), 36, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (105, 'Rhus toxicodendron', 'Introduce Oth Therap Subst in Male Reprod, Perc', to_date('15-09-2022', 'dd-mm-yyyy'), 12, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (108, 'Glycerin', 'Extirpate matter from Chordae Tendineae, Perc Endo', to_date('06-01-2025', 'dd-mm-yyyy'), 26, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (110, 'Famotidine', 'Excision of Cervical Vertebral Joint, Open Approach', to_date('17-06-2022', 'dd-mm-yyyy'), 40, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (113, 'Glycine', 'Dilation of R Post Tib Art with 3 Drug-elut, Open Approach', to_date('02-01-2018', 'dd-mm-yyyy'), 35, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (116, 'Titanium Dioxide', 'Repair Left Knee Tendon, Percutaneous Approach', to_date('02-08-2011', 'dd-mm-yyyy'), 22, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (119, 'Malic Acid', 'Removal of Drain Dev from R Finger Phalanx Jt, Open Approach', to_date('13-08-2010', 'dd-mm-yyyy'), 17, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (122, 'OCTINOXATE', 'Bypass L Axilla Art to L Extracran Art, Open Approach', to_date('01-11-2014', 'dd-mm-yyyy'), 15, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (125, 'Homosalate', 'Dilation of Jejunum with Intraluminal Device, Via Opening', to_date('20-04-2007', 'dd-mm-yyyy'), 28, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (128, 'Leucine', 'Revise Tissue Expander in Up Extrem Subcu/Fascia, Open', to_date('13-10-2020', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (130, 'erythromycin', 'Restriction of Cystic Duct, Percutaneous Approach', to_date('28-08-2008', 'dd-mm-yyyy'), 28, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (133, 'Amlodipine Besylate', 'Beam Radiation of Radius/Ulna using Neutron Capture', to_date('23-08-2026', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (136, 'OCTINOXATE', 'Introduce Oth Therap Subst in Male Reprod, Perc', to_date('03-02-2019', 'dd-mm-yyyy'), 43, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (139, 'escitalopram', 'Bypass L Hypogast Vein to Low Vein w Autol Art, Perc Endo', to_date('22-12-2026', 'dd-mm-yyyy'), 34, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (142, 'Alcohol', 'Revision of Synth Sub in L Sacroiliac Jt, Perc Approach', to_date('03-02-2013', 'dd-mm-yyyy'), 29, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (145, 'warfarin sodium', 'Replacement of Sup Mesent Art with Autol Sub, Open Approach', to_date('09-01-2026', 'dd-mm-yyyy'), 24, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (148, 'Isopropyl Alcohol', 'Cochlear Implant Assessment using Hear Aid Equipment', to_date('22-11-2009', 'dd-mm-yyyy'), 23, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (151, 'OXYBENZONE', 'Supplement R Foot Art with Autol Sub, Perc Endo Approach', to_date('15-03-2015', 'dd-mm-yyyy'), 35, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (154, 'DHEA ', 'Head and Facial Bones, Destruction', to_date('04-11-2017', 'dd-mm-yyyy'), 35, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (156, 'AVOBENZONE', 'Bypass Left Kidney Pelvis to Colon, Open Approach', to_date('01-10-2024', 'dd-mm-yyyy'), 25, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (159, 'Hydrastis', 'Bypass R Fem Art to Low Ex Vein w Autol Art, Perc Endo', to_date('14-12-2023', 'dd-mm-yyyy'), 32, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (181, 'Aluminum Chlorohydrate', 'Alteration of Left Upper Leg with Autol Sub, Open Approach', to_date('12-01-2024', 'dd-mm-yyyy'), 19, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (185, 'HYDROMORPHONE HYDROCHLORIDE', 'Excision of Right Innominate Vein, Percutaneous Approach', to_date('27-04-2016', 'dd-mm-yyyy'), 45, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (188, 'Iohexol', 'Insertion of Intralum Dev into L Renal Vein, Open Approach', to_date('14-12-2010', 'dd-mm-yyyy'), 35, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (191, 'Salicylic Acid', 'CT Scan of Bi Pulm Vein using L Osm Contrast, Unenh, Enhance', to_date('26-05-2011', 'dd-mm-yyyy'), 35, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (366, 'alcohol', 'Release Right Knee Joint, External Approach', to_date('14-12-2008', 'dd-mm-yyyy'), 33, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (369, 'Isosorbide Dinitrate', 'Release Left Finger Phalanx, Open Approach', to_date('01-07-2015', 'dd-mm-yyyy'), 26, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (372, 'antihemophilic factor/von', 'Fusion C-thor Jt w Nonaut Sub, Post Appr A Col, Open', to_date('20-12-2023', 'dd-mm-yyyy'), 30, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (375, 'Titanium Dioxide', 'Drainage of Right Thorax Tendon, Perc Endo Approach, Diagn', to_date('07-08-2023', 'dd-mm-yyyy'), 20, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (378, 'Furosemide', 'Control Bleeding in Left Upper Arm, Open Approach', to_date('21-01-2017', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (381, 'Colchicum autumnale', 'Dilate R Int Mamm Art, Bifurc, w 2 Drug-elut, Open', to_date('09-03-2006', 'dd-mm-yyyy'), 46, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (384, 'OLANZAPINE', 'Insertion of Hybrid Ext Fix into R Ulna, Perc Endo Approach', to_date('18-09-2016', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (387, 'SOLANUM DULCAMARA TOP', 'Change Splint on Face', to_date('17-04-2012', 'dd-mm-yyyy'), 43, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (389, 'PHENYLEPHRINE HYDROCHLORIDE', 'LDR Brachytherapy of Pancreas using Californium 252', to_date('19-10-2008', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (392, 'Histaminum hydrochloricum', 'Excision of Para-aortic Body, Percutaneous Approach, Diagn', to_date('25-07-2005', 'dd-mm-yyyy'), 20, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (395, 'Black Willow', 'Insertion of Int Fix into R Sphenoid Bone, Open Approach', to_date('05-12-2006', 'dd-mm-yyyy'), 24, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (398, 'fluvoxamine maleate', 'Removal of Nonautologous Tissue Substitute from L Eye, Endo', to_date('20-01-2010', 'dd-mm-yyyy'), 28, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (419, 'Dextromethorphan Hydrobromide', 'Removal of Autol Sub from L Eye, Extern Approach', to_date('16-10-2016', 'dd-mm-yyyy'), 46, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (422, 'Guaifenesin', 'Restrict Pelvis Lymph w Extralum Dev, Perc Endo', to_date('24-06-2017', 'dd-mm-yyyy'), 45, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (425, 'Oxazepam', 'Removal of Drain Dev from R Finger Phalanx Jt, Open Approach', to_date('02-11-2026', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (428, 'Cetirizine HCl', 'Release Left Metacarpophalangeal Joint, Open Approach', to_date('11-06-2014', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (431, 'misoprostol', 'Extirpate matter from L Shoulder Bursa/Lig, Perc Endo', to_date('28-10-2024', 'dd-mm-yyyy'), 11, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (434, 'Nux vomica', 'Reposition Right Toe Phalangeal Joint, Perc Endo Approach', to_date('24-03-2017', 'dd-mm-yyyy'), 28, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (437, 'SODIUM FLUORIDE', 'Supplement Left Foot Vein with Synth Sub, Perc Endo Approach', to_date('09-05-2016', 'dd-mm-yyyy'), 32, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (440, 'CHLORPROMAZINE HYDROCHLORIDE', 'Dilate L Int Mamm Art, Bifurc, w Drug-elut Intra, Perc Endo', to_date('28-08-2012', 'dd-mm-yyyy'), 19, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (443, 'Alanine', 'Restrict R Com Iliac Vein w Intralum Dev, Perc Endo', to_date('22-01-2013', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (446, 'ATROPINE SULFATE', 'Removal of Synthetic Substitute from Urethra, Via Opening', to_date('12-03-2009', 'dd-mm-yyyy'), 39, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (449, 'ONDANSETRON HYDROCHLORIDE', 'Release Right Patella, Percutaneous Approach', to_date('05-07-2008', 'dd-mm-yyyy'), 23, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (452, 'Octocrylene', 'Restriction of Esophagus, Open Approach', to_date('01-05-2020', 'dd-mm-yyyy'), 14, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (454, 'Stannum metallicum', 'Destruction of Thor Aorta Desc, Perc Endo Approach', to_date('24-07-2020', 'dd-mm-yyyy'), 17, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (457, 'eomycin sulfate', 'Repair Right Lower Arm and Wrist Muscle, Perc Endo Approach', to_date('02-12-2008', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (461, 'PRAVASTATIN SODIUM', 'Reposition R Humeral Head w Monopln Ext Fix, Perc Endo', to_date('25-12-2026', 'dd-mm-yyyy'), 44, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (464, 'Phosphorus', 'Bypass L Hypogast Vein to Low Vein w Autol Art, Perc Endo', to_date('22-04-2023', 'dd-mm-yyyy'), 36, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (466, 'Histidine', 'Insertion of Reservoir into Abd Subcu/Fascia, Perc Approach', to_date('01-04-2017', 'dd-mm-yyyy'), 22, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (469, 'levothyroxine sodium', 'Fusion of Right Finger Phalangeal Joint, Open Approach', to_date('27-11-2016', 'dd-mm-yyyy'), 46, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (472, 'Ranitidine', 'Repair Thalamus, Percutaneous Endoscopic Approach', to_date('22-12-2020', 'dd-mm-yyyy'), 17, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (475, 'Oxymorphone hydrochloride', 'Revise of Infusion Dev in R Metatarsotars Jt, Open Approach', to_date('22-03-2017', 'dd-mm-yyyy'), 11, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (479, 'Stannum metallicum', 'Fusion of L Shoulder Jt with Synth Sub, Perc Endo Approach', to_date('13-01-2026', 'dd-mm-yyyy'), 47, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (500, 'Pulsatilla', 'Dilation of Jejunum, Percutaneous Approach', to_date('15-03-2025', 'dd-mm-yyyy'), 14, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (502, 'chlorine', 'Drainage of Hyoid Bone, Percutaneous Endoscopic Approach', to_date('04-08-2023', 'dd-mm-yyyy'), 27, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (505, 'Citalopram', 'Head and Facial Bones, Destruction', to_date('10-07-2025', 'dd-mm-yyyy'), 41, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (508, 'avobenzone', 'Removal of Drainage Device from Lower Jaw, Open Approach', to_date('07-10-2026', 'dd-mm-yyyy'), 28, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (511, 'ONDANSETRON', 'Revision of Bone Stim in Up Bone, Extern Approach', to_date('24-07-2017', 'dd-mm-yyyy'), 23, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (513, 'Citalopram', 'MRI of Bi Pelvic Vein using Oth Contrast, Unenh, Enhance', to_date('23-07-2008', 'dd-mm-yyyy'), 46, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (516, 'Salicylic acid', 'Insertion of Tissue Expander into Right Nipple, Via Opening', to_date('04-05-2020', 'dd-mm-yyyy'), 32, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (519, 'Hydrocotyle asiatica', 'Supplement R Vas Deferens with Autol Sub, Perc Endo Approach', to_date('23-08-2010', 'dd-mm-yyyy'), 45, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (523, 'Dock Sour Sheep Sorrel', 'Drainage of Carina, Percutaneous Endoscopic Approach, Diagn', to_date('11-08-2006', 'dd-mm-yyyy'), 38, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (526, 'Salicylic Acid', 'Dilate Celiac Art w Drug-elut Intra, Perc Endo', to_date('09-06-2013', 'dd-mm-yyyy'), 30, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (529, 'Mirtazapine', 'Dilate Sup Mesent Art, Bifurc, w Intralum Dev, Perc Endo', to_date('02-01-2012', 'dd-mm-yyyy'), 23, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (532, 'Phenylephrine HCl', 'Revision of Spacer in L Metacarpocarp Jt, Perc Approach', to_date('06-06-2005', 'dd-mm-yyyy'), 20, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (535, 'West Wheat Grass', 'Excision of Left Face Vein, Open Approach, Diagnostic', to_date('15-12-2015', 'dd-mm-yyyy'), 46, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (538, 'Acetaminophen', 'Bypass R Axilla Art to R Low Arm Art w Autol Art, Open', to_date('16-05-2022', 'dd-mm-yyyy'), 46, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (541, 'Magnesia phosphorica', 'Revision of Extralum Dev in Up Intest Tract, Via Opening', to_date('08-03-2026', 'dd-mm-yyyy'), 46, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (544, 'ATORVASTATIN CALCIUM', 'Bypass R Radial Art to Low Arm Vein w Autol Art, Open', to_date('04-05-2016', 'dd-mm-yyyy'), 44, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (547, 'Promethazine Hydrochloride', 'Drainage of Upper Lip, External Approach', to_date('07-04-2006', 'dd-mm-yyyy'), 43, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (550, 'indomethacin', 'Drainage of R Occipital Bone with Drain Dev, Perc Approach', to_date('21-01-2020', 'dd-mm-yyyy'), 32, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (553, 'Riboflavinum', 'Revision of Drainage Device in Thor Jt, Extern Approach', to_date('26-02-2009', 'dd-mm-yyyy'), 47, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (556, 'bacitracin zinc', 'Repair Right Submaxillary Gland, Percutaneous Approach', to_date('01-01-2022', 'dd-mm-yyyy'), 12, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (559, 'Salicylic acid', 'Excision of Para-aortic Body, Percutaneous Approach, Diagn', to_date('27-03-2020', 'dd-mm-yyyy'), 48, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (582, 'Serine', 'Fluoroscopy of Head and Neck', to_date('14-03-2012', 'dd-mm-yyyy'), 34, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (584, 'OXYMORPHONE HYDROCHLORIDE', 'Excision of Left Toe Phalangeal Joint, Percutaneous Approach', to_date('03-01-2007', 'dd-mm-yyyy'), 19, '2');
commit;
prompt 900 records committed...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (587, 'Magnesium Hydroxide', 'Revision of Synthetic Substitute in L Tarsal, Open Approach', to_date('03-02-2025', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (590, 'Plantago major', 'Replacement of Right Eye with Synth Sub, Perc Approach', to_date('13-02-2009', 'dd-mm-yyyy'), 20, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (593, 'Doxylamine succinate', 'Revision of Nonaut Sub in Cervcal Vertebra, Open Approach', to_date('03-08-2025', 'dd-mm-yyyy'), 10, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (596, 'Calcarea carbonica', 'Supplement L Temporomandib Jt with Autol Sub, Open Approach', to_date('10-01-2020', 'dd-mm-yyyy'), 23, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (600, 'Aluminum Chlorohydrate', 'Replacement of Back Skin with Synth Sub, Extern Approach', to_date('24-01-2010', 'dd-mm-yyyy'), 35, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (603, 'Chlorpehniramine HCl', 'Release Right Knee Joint, External Approach', to_date('03-04-2026', 'dd-mm-yyyy'), 41, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (606, 'Lycopodium clavatum', 'Dilation of L Peroneal Art with 4 Drug-elut, Perc Approach', to_date('15-12-2021', 'dd-mm-yyyy'), 15, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (609, 'TOXICODENDRON PUBESCENS LEAF', 'Revise of Nonaut Sub in R Metacarpophal Jt, Extern Approach', to_date('13-05-2014', 'dd-mm-yyyy'), 44, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (612, 'Equisetum hyemale', 'Dilation of Left Upper Lobe Bronchus with Intralum Dev, Endo', to_date('25-06-2026', 'dd-mm-yyyy'), 27, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (615, 'Magnesium citrate', 'Drainage of Carina, Percutaneous Endoscopic Approach, Diagn', to_date('17-09-2017', 'dd-mm-yyyy'), 46, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (619, 'norethindrone acetate/ethinyl estradiol', 'Excision of Left Upper Arm, Percutaneous Endoscopic Approach', to_date('10-01-2016', 'dd-mm-yyyy'), 24, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (622, 'White Petrolatum', 'Bypass Abd Aorta to Low Ex Art w Nonaut Sub, Perc Endo', to_date('09-10-2021', 'dd-mm-yyyy'), 22, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (625, 'Allergenic Extracts Alum Precipitated', 'Reposition Pulmonary Trunk, Open Approach', to_date('03-05-2022', 'dd-mm-yyyy'), 25, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (628, 'Oxymorphone hydrochloride', 'Supplement L Up Leg Subcu/Fascia w Autol Sub, Open', to_date('05-08-2025', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (632, 'Octinoxate', 'Removal of Int Fix from L Sternoclav Jt, Perc Approach', to_date('16-11-2025', 'dd-mm-yyyy'), 20, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (634, 'OCTINOXATE', 'Drainage of Right Common Iliac Vein, Perc Approach, Diagn', to_date('12-02-2010', 'dd-mm-yyyy'), 39, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (637, 'Loratadine', 'Bypass L Com Iliac Art to L Int Ilia w Autol Art, Open', to_date('20-05-2023', 'dd-mm-yyyy'), 33, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (660, 'Phosphorus', 'Replacement of Right Eye with Synth Sub, Perc Approach', to_date('17-11-2022', 'dd-mm-yyyy'), 33, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (663, 'TOXICODENDRON PUBESCENS LEAF', 'Revision of Extralum Dev in Up Intest Tract, Via Opening', to_date('19-11-2021', 'dd-mm-yyyy'), 12, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (666, 'Promethazine Hydrochloride', 'Division of Right Lower Arm and Wrist Tendon, Open Approach', to_date('28-09-2008', 'dd-mm-yyyy'), 31, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (669, 'Benazepril Hydrochloride', 'Release Left Metacarpophalangeal Joint, Open Approach', to_date('01-06-2008', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (672, 'urea', 'Extirpate matter from Uterine Support Struct, Perc Endo', to_date('04-04-2012', 'dd-mm-yyyy'), 35, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (675, 'Leucine', 'Excision of Cervical Vertebral Joint, Open Approach', to_date('05-05-2017', 'dd-mm-yyyy'), 21, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (678, 'Bryonia', 'Introduce of Analg/Hypnot/Sedat into GU Tract, Via Opening', to_date('08-03-2023', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (681, 'Bryonia', 'Extirpation of Matter from L Fem Art, Open Approach', to_date('23-06-2005', 'dd-mm-yyyy'), 31, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (684, 'quetiapine fumarate', 'Bypass L Great Saphenous to Low Vein w Synth Sub, Open', to_date('21-01-2005', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (687, 'helminthosporium solani', 'Fusion C-thor Jt w Nonaut Sub, Post Appr A Col, Open', to_date('20-09-2006', 'dd-mm-yyyy'), 43, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (690, 'Cuprum metallicum', 'Occlusion of Ascending Colon with Intralum Dev, Via Opening', to_date('07-05-2012', 'dd-mm-yyyy'), 20, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (693, 'Leucine', 'Insertion of Neuro Lead into Brain, Perc Endo Approach', to_date('21-04-2017', 'dd-mm-yyyy'), 40, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (696, 'Acetaminophen', 'Drainage of Lung Lingula, Percutaneous Approach, Diagnostic', to_date('27-09-2010', 'dd-mm-yyyy'), 48, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (699, 'Cuprum Aceticum 3', 'Removal of Int Fix from L Sternoclav Jt, Perc Approach', to_date('19-11-2022', 'dd-mm-yyyy'), 13, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (702, 'Amoxicillin', 'Insertion of Other Device into R Knee, Perc Approach', to_date('02-11-2005', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (705, 'Mephitis mephitica', 'Restriction of L Radial Art with Extralum Dev, Open Approach', to_date('14-10-2012', 'dd-mm-yyyy'), 36, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (708, 'oxybenzone', 'Dilate R Int Mamm Art, Bifurc, w 2 Drug-elut, Open', to_date('16-03-2018', 'dd-mm-yyyy'), 41, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (710, 'Ibuprofen', 'Supplement Epiglottis with Synth Sub, Open Approach', to_date('08-06-2015', 'dd-mm-yyyy'), 48, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (713, 'Ulmus fulva', 'Remove Synth Sub from Prostate/Seminal Ves, Perc Endo', to_date('09-02-2008', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (716, 'Veratrum album', 'Destruction of Esophagogastric Junction, Perc Approach', to_date('04-09-2016', 'dd-mm-yyyy'), 33, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (719, 'Acetaminophen', 'Extirpation of Matter from L Fem Art, Open Approach', to_date('27-06-2014', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (741, 'ARGININE', 'Revision of Monitor Dev in Cranial Nrv, Extern Approach', to_date('08-07-2008', 'dd-mm-yyyy'), 12, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (744, 'Quercus', 'Insertion of Stimulator Lead into Bladder, Via Opening', to_date('03-06-2020', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (747, 'Pilocarpine Hydrochloride', 'Supplement L Verteb Vein with Nonaut Sub, Open Approach', to_date('18-09-2008', 'dd-mm-yyyy'), 41, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (750, 'Dyclonine Hydrochloride', 'Restriction of Left Brachial Artery, Percutaneous Approach', to_date('19-10-2021', 'dd-mm-yyyy'), 23, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (753, 'Spleen (suis)', 'Bypass L Fem Art to Peron Art with Synth Sub, Open Approach', to_date('20-03-2010', 'dd-mm-yyyy'), 50, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (756, 'Gabapentin', 'Excision of Right Middle Lobe Bronchus, Endo, Diagn', to_date('03-01-2022', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (759, 'Equisetum hyemale', 'Introduce of Analg/Hypnot/Sedat into GU Tract, Via Opening', to_date('10-05-2025', 'dd-mm-yyyy'), 16, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (762, 'Hepar suis', 'Inspection of Left Foot, Percutaneous Endoscopic Approach', to_date('20-04-2024', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (765, 'Natrum carbonicum', 'Introduce of Analg/Hypnot/Sedat into GU Tract, Via Opening', to_date('05-02-2016', 'dd-mm-yyyy'), 34, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (768, 'Carbo vegetabilis', 'Drainage of Right Main Bronchus, Perc Endo Approach', to_date('02-03-2015', 'dd-mm-yyyy'), 25, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (771, 'Lycopodium', 'Removal of Autol Sub from L Eye, Extern Approach', to_date('01-06-2022', 'dd-mm-yyyy'), 34, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (774, 'Acetaminophen', 'Removal of Synth Sub from Abd Wall, Extern Approach', to_date('08-12-2020', 'dd-mm-yyyy'), 28, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (777, 'OCTINOXATE', 'Supplement Epiglottis with Synth Sub, Open Approach', to_date('20-08-2023', 'dd-mm-yyyy'), 47, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (779, 'Erythromycin', 'Replacement of Left Eye with Autol Sub, Perc Approach', to_date('19-05-2026', 'dd-mm-yyyy'), 38, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (782, 'ENSULIZOLE', 'Drainage of Carina, Percutaneous Endoscopic Approach, Diagn', to_date('27-02-2022', 'dd-mm-yyyy'), 30, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (785, 'Valine', 'Removal of Synth Sub from L Clavicle, Perc Endo Approach', to_date('07-09-2026', 'dd-mm-yyyy'), 29, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (788, 'Promethazine Hydrochloride', 'Reposition R Humeral Head w Monopln Ext Fix, Perc Endo', to_date('05-01-2010', 'dd-mm-yyyy'), 10, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (791, 'Gelsemium', 'Replacement of Right Eye with Synth Sub, Perc Approach', to_date('08-09-2011', 'dd-mm-yyyy'), 45, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (794, 'diphenhydramine HCl', 'Occlusion of Left Popliteal Artery, Percutaneous Approach', to_date('14-01-2018', 'dd-mm-yyyy'), 37, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (797, 'Elaps corallinus', 'Bypass Colic Vein to Low Vein with Autol Art, Open Approach', to_date('04-09-2011', 'dd-mm-yyyy'), 33, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (800, 'Carduus marianus', 'Reposition Left Toe Phalanx, External Approach', to_date('02-11-2019', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (821, 'Carbo vegetabilis', 'Repair Left Knee Tendon, Percutaneous Approach', to_date('21-07-2007', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (824, 'Atropa Belladonna', 'Excision of Left Toe Phalangeal Joint, Percutaneous Approach', to_date('20-06-2022', 'dd-mm-yyyy'), 47, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (827, 'Plantago major', 'Drainage of Right Thorax Tendon, Perc Endo Approach, Diagn', to_date('02-11-2022', 'dd-mm-yyyy'), 45, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (830, 'glyburide', 'Excision of Anus, Via Natural or Artificial Opening, Diagn', to_date('27-02-2005', 'dd-mm-yyyy'), 10, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (833, 'Promethazine Hydrochloride', 'Revise of Infusion Dev in R Metatarsotars Jt, Open Approach', to_date('20-01-2005', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (837, 'Pulsatilla', 'Drainage of Right Sacroiliac Joint, Open Approach, Diagn', to_date('12-07-2025', 'dd-mm-yyyy'), 47, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (840, 'OCTINOXATE', 'Revision of Synthetic Substitute in L Tarsal, Open Approach', to_date('06-05-2022', 'dd-mm-yyyy'), 11, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (843, 'Octisalate', 'Destruction of Thor Aorta Desc, Perc Endo Approach', to_date('22-04-2012', 'dd-mm-yyyy'), 33, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (845, 'chlorine', 'Removal of Extraluminal Device from Bladder, Open Approach', to_date('13-06-2017', 'dd-mm-yyyy'), 15, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (848, 'Famotidine', 'Fusion C-thor Jt w Autol Sub, Post Appr A Col, Perc', to_date('18-07-2020', 'dd-mm-yyyy'), 42, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (851, 'Fexofenadine HCl', 'Drainage of Pancreatic Duct, Percutaneous Approach, Diagn', to_date('08-11-2019', 'dd-mm-yyyy'), 34, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (854, 'Ranitidine', 'Supplement L Up Leg Subcu/Fascia w Autol Sub, Open', to_date('12-01-2014', 'dd-mm-yyyy'), 38, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (857, 'Pregnenolone', 'Bypass L Com Iliac Art to L Int Ilia w Autol Art, Open', to_date('20-06-2009', 'dd-mm-yyyy'), 12, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (860, 'temazepam', 'Removal of Drain Dev from Cisterna Chyli, Perc Endo Approach', to_date('19-04-2022', 'dd-mm-yyyy'), 12, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (863, 'Titanium Dioxide', 'Repair Right Hip Bursa and Ligament, Percutaneous Approach', to_date('01-07-2020', 'dd-mm-yyyy'), 31, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (866, 'PHENYLEPHRINE HYDROCHLORIDE', 'Revision of Drainage Device in R Carpal Jt, Extern Approach', to_date('24-06-2007', 'dd-mm-yyyy'), 26, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (869, 'CIPROFLOXACIN', 'Drainage of Pancreatic Duct, Percutaneous Approach, Diagn', to_date('14-03-2016', 'dd-mm-yyyy'), 50, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (872, 'OCTOCRYLENE', 'Repair Right Hand, Percutaneous Approach', to_date('10-09-2025', 'dd-mm-yyyy'), 50, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (875, 'Arnica Aurum 6 10', 'CT Scan of Cereb Vent using H Osm Contrast, Unenh, Enhance', to_date('27-07-2020', 'dd-mm-yyyy'), 30, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (878, 'levothyroxine sodium', 'MRI of Low Extrem Tendon using Oth Contrast, Unenh, Enhance', to_date('03-10-2015', 'dd-mm-yyyy'), 44, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (900, 'VANCOMYCIN HYDROCHLORIDE', 'Supplement L Basilic Vein with Synth Sub, Perc Endo Approach', to_date('22-11-2021', 'dd-mm-yyyy'), 14, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (903, 'Cattle Epithelia', 'Remove Synth Sub from Prostate/Seminal Ves, Perc Endo', to_date('01-04-2011', 'dd-mm-yyyy'), 45, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (906, 'lamotrigine', 'Dilate L Com Carotid, Bifurc, w 4 Drug-elut, Perc', to_date('07-01-2005', 'dd-mm-yyyy'), 13, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (909, 'Amoxicillin', 'Excision of Left Toe Phalangeal Joint, Percutaneous Approach', to_date('18-02-2022', 'dd-mm-yyyy'), 48, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (912, 'Lycopodium Clavatum', 'Repair Left Temporal Bone, Percutaneous Approach', to_date('28-09-2024', 'dd-mm-yyyy'), 39, '5');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (915, 'Valine', 'Revision of Autol Sub in L Acetabulum, Open Approach', to_date('08-01-2017', 'dd-mm-yyyy'), 46, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (917, 'Cinnamic Acid', 'Drainage of Bi Fallopian Tube with Drain Dev, Via Opening', to_date('10-02-2024', 'dd-mm-yyyy'), 45, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (920, 'CYSTEINE', 'Destruction of Bilateral Lungs, Endo', to_date('23-04-2015', 'dd-mm-yyyy'), 25, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (923, 'Alanine', 'Bypass R Vas Deferens to R Vas Def w Synth Sub,', to_date('06-05-2005', 'dd-mm-yyyy'), 14, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (925, 'Elaps corallinus', 'Destruction of Right Radius, Open Approach', to_date('03-06-2005', 'dd-mm-yyyy'), 12, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (928, 'alcohol', 'Dilation of R Ext Iliac Art with 2 Drug-elut, Perc Approach', to_date('22-10-2008', 'dd-mm-yyyy'), 50, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (931, 'dextromethorphan HBr', 'Revision of Ext Fix in R Ulna, Extern Approach', to_date('19-08-2025', 'dd-mm-yyyy'), 35, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (934, 'levalbuterol inhalation', 'Beam Radiation of Lung using Electrons, Intraoperative', to_date('25-09-2014', 'dd-mm-yyyy'), 21, '2');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (937, 'Aspirin', 'HDR Brachytherapy of Jejunum using Palladium 103', to_date('17-05-2013', 'dd-mm-yyyy'), 29, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (940, 'Saline Laxative', 'Release Left Hand Skin, External Approach', to_date('24-01-2011', 'dd-mm-yyyy'), 19, '4');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (942, 'Aluminum Zirconium Tetrachlorohydrex Gly', 'Drainage of Left Upper Arm Tendon, Open Approach, Diagnostic', to_date('05-08-2020', 'dd-mm-yyyy'), 45, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (946, 'SUS SCROFA UMBILICAL CORD', 'Removal of Autol Sub from L Eye, Extern Approach', to_date('05-05-2023', 'dd-mm-yyyy'), 45, '1');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (949, 'Morphine Sulfate', 'Excision of Head Muscle, Percutaneous Endoscopic Approach', to_date('23-12-2009', 'dd-mm-yyyy'), 15, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (952, 'Rhus toxicodendron', 'Beam Radiation of Lung using Electrons, Intraoperative', to_date('10-09-2026', 'dd-mm-yyyy'), 29, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (955, 'Octinoxate', 'Replace of R Femur Shaft with Synth Sub, Perc Endo Approach', to_date('08-12-2019', 'dd-mm-yyyy'), 50, '3');
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (958, 'Erythromycin', 'Insertion of Monitor Dev into L Diaphragm, Perc Approach', to_date('03-03-2008', 'dd-mm-yyyy'), 11, '4');
commit;
prompt 1000 records committed...
insert into MEDICATION (medicationid, name, description, expirationdate, quantityinstock, strength)
values (961, 'guaifenesin', 'Revision of Drainage Device in Thor Jt, Extern Approach', to_date('15-10-2017', 'dd-mm-yyyy'), 20, '2');
commit;
prompt 1001 records loaded
prompt Loading ROOM...
insert into ROOM (roomid, type, departmentid)
values (1, 'Psychiatric', 143);
insert into ROOM (roomid, type, departmentid)
values (2, 'Isolation', 212);
insert into ROOM (roomid, type, departmentid)
values (3, 'Private', 126);
insert into ROOM (roomid, type, departmentid)
values (4, 'Labor and Delivery', 472);
insert into ROOM (roomid, type, departmentid)
values (5, 'General Ward', 205);
insert into ROOM (roomid, type, departmentid)
values (6, 'Emergency', 331);
insert into ROOM (roomid, type, departmentid)
values (7, 'Isolation', 483);
insert into ROOM (roomid, type, departmentid)
values (8, 'Rehabilitation', 321);
insert into ROOM (roomid, type, departmentid)
values (9, 'Labor and Delivery', 169);
insert into ROOM (roomid, type, departmentid)
values (10, 'Rehabilitation', 458);
insert into ROOM (roomid, type, departmentid)
values (11, 'General Ward', 318);
insert into ROOM (roomid, type, departmentid)
values (12, 'NICU', 167);
insert into ROOM (roomid, type, departmentid)
values (13, 'Private', 297);
insert into ROOM (roomid, type, departmentid)
values (14, 'PICU', 427);
insert into ROOM (roomid, type, departmentid)
values (15, 'Labor and Delivery', 383);
insert into ROOM (roomid, type, departmentid)
values (16, 'Surgery', 102);
insert into ROOM (roomid, type, departmentid)
values (17, 'CCU', 7);
insert into ROOM (roomid, type, departmentid)
values (18, 'CCU', 47);
insert into ROOM (roomid, type, departmentid)
values (19, 'PICU', 305);
insert into ROOM (roomid, type, departmentid)
values (20, 'Psychiatric', 193);
insert into ROOM (roomid, type, departmentid)
values (21, 'Recovery', 229);
insert into ROOM (roomid, type, departmentid)
values (22, 'Labor and Delivery', 459);
insert into ROOM (roomid, type, departmentid)
values (23, 'PICU', 144);
insert into ROOM (roomid, type, departmentid)
values (24, 'Recovery', 428);
insert into ROOM (roomid, type, departmentid)
values (25, 'Semi-Private', 411);
insert into ROOM (roomid, type, departmentid)
values (26, 'Psychiatric', 409);
insert into ROOM (roomid, type, departmentid)
values (27, 'Semi-Private', 112);
insert into ROOM (roomid, type, departmentid)
values (28, 'PICU', 58);
insert into ROOM (roomid, type, departmentid)
values (29, 'Surgery', 195);
insert into ROOM (roomid, type, departmentid)
values (30, 'Isolation', 423);
insert into ROOM (roomid, type, departmentid)
values (31, 'Surgery', 434);
insert into ROOM (roomid, type, departmentid)
values (32, 'Rehabilitation', 354);
insert into ROOM (roomid, type, departmentid)
values (33, 'CCU', 229);
insert into ROOM (roomid, type, departmentid)
values (34, 'Labor and Delivery', 382);
insert into ROOM (roomid, type, departmentid)
values (35, 'Private', 385);
insert into ROOM (roomid, type, departmentid)
values (36, 'General Ward', 261);
insert into ROOM (roomid, type, departmentid)
values (37, 'Recovery', 159);
insert into ROOM (roomid, type, departmentid)
values (38, 'Labor and Delivery', 18);
insert into ROOM (roomid, type, departmentid)
values (39, 'CCU', 463);
insert into ROOM (roomid, type, departmentid)
values (40, 'Recovery', 471);
insert into ROOM (roomid, type, departmentid)
values (41, 'Rehabilitation', 251);
insert into ROOM (roomid, type, departmentid)
values (42, 'Semi-Private', 300);
insert into ROOM (roomid, type, departmentid)
values (43, 'Private', 234);
insert into ROOM (roomid, type, departmentid)
values (44, 'PICU', 386);
insert into ROOM (roomid, type, departmentid)
values (45, 'Maternity', 196);
insert into ROOM (roomid, type, departmentid)
values (46, 'Recovery', 239);
insert into ROOM (roomid, type, departmentid)
values (47, 'Surgery', 324);
insert into ROOM (roomid, type, departmentid)
values (48, 'General Ward', 3);
insert into ROOM (roomid, type, departmentid)
values (49, 'Maternity', 49);
insert into ROOM (roomid, type, departmentid)
values (50, 'Private', 91);
insert into ROOM (roomid, type, departmentid)
values (51, 'Private', 73);
insert into ROOM (roomid, type, departmentid)
values (52, 'Maternity', 194);
insert into ROOM (roomid, type, departmentid)
values (53, 'Surgery', 338);
insert into ROOM (roomid, type, departmentid)
values (54, 'PICU', 470);
insert into ROOM (roomid, type, departmentid)
values (55, 'CCU', 341);
insert into ROOM (roomid, type, departmentid)
values (56, 'PICU', 399);
insert into ROOM (roomid, type, departmentid)
values (57, 'Rehabilitation', 324);
insert into ROOM (roomid, type, departmentid)
values (58, 'Private', 368);
insert into ROOM (roomid, type, departmentid)
values (59, 'Recovery', 472);
insert into ROOM (roomid, type, departmentid)
values (60, 'Recovery', 219);
insert into ROOM (roomid, type, departmentid)
values (61, 'General Ward', 415);
insert into ROOM (roomid, type, departmentid)
values (62, 'PICU', 77);
insert into ROOM (roomid, type, departmentid)
values (63, 'ICU', 412);
insert into ROOM (roomid, type, departmentid)
values (64, 'General Ward', 426);
insert into ROOM (roomid, type, departmentid)
values (65, 'General Ward', 246);
insert into ROOM (roomid, type, departmentid)
values (66, 'CCU', 24);
insert into ROOM (roomid, type, departmentid)
values (67, 'NICU', 490);
insert into ROOM (roomid, type, departmentid)
values (68, 'General Ward', 362);
insert into ROOM (roomid, type, departmentid)
values (69, 'Surgery', 400);
insert into ROOM (roomid, type, departmentid)
values (70, 'CCU', 3);
insert into ROOM (roomid, type, departmentid)
values (71, 'Isolation', 347);
insert into ROOM (roomid, type, departmentid)
values (72, 'Private', 264);
insert into ROOM (roomid, type, departmentid)
values (73, 'General Ward', 302);
insert into ROOM (roomid, type, departmentid)
values (74, 'Psychiatric', 325);
insert into ROOM (roomid, type, departmentid)
values (75, 'CCU', 28);
insert into ROOM (roomid, type, departmentid)
values (76, 'NICU', 480);
insert into ROOM (roomid, type, departmentid)
values (77, 'Emergency', 253);
insert into ROOM (roomid, type, departmentid)
values (78, 'Recovery', 362);
insert into ROOM (roomid, type, departmentid)
values (79, 'Semi-Private', 221);
insert into ROOM (roomid, type, departmentid)
values (80, 'Maternity', 100);
insert into ROOM (roomid, type, departmentid)
values (81, 'Private', 137);
insert into ROOM (roomid, type, departmentid)
values (82, 'Psychiatric', 6);
insert into ROOM (roomid, type, departmentid)
values (83, 'Maternity', 168);
insert into ROOM (roomid, type, departmentid)
values (84, 'Semi-Private', 487);
insert into ROOM (roomid, type, departmentid)
values (85, 'ICU', 266);
insert into ROOM (roomid, type, departmentid)
values (86, 'Semi-Private', 31);
insert into ROOM (roomid, type, departmentid)
values (87, 'Semi-Private', 211);
insert into ROOM (roomid, type, departmentid)
values (88, 'ICU', 220);
insert into ROOM (roomid, type, departmentid)
values (89, 'CCU', 398);
insert into ROOM (roomid, type, departmentid)
values (90, 'ICU', 361);
insert into ROOM (roomid, type, departmentid)
values (91, 'NICU', 17);
insert into ROOM (roomid, type, departmentid)
values (92, 'ICU', 441);
insert into ROOM (roomid, type, departmentid)
values (93, 'Recovery', 402);
insert into ROOM (roomid, type, departmentid)
values (94, 'Maternity', 246);
insert into ROOM (roomid, type, departmentid)
values (95, 'CCU', 442);
insert into ROOM (roomid, type, departmentid)
values (96, 'Emergency', 105);
insert into ROOM (roomid, type, departmentid)
values (97, 'Isolation', 80);
insert into ROOM (roomid, type, departmentid)
values (98, 'Private', 341);
insert into ROOM (roomid, type, departmentid)
values (99, 'Psychiatric', 55);
insert into ROOM (roomid, type, departmentid)
values (100, 'Rehabilitation', 143);
commit;
prompt 100 records committed...
insert into ROOM (roomid, type, departmentid)
values (101, 'Recovery', 146);
insert into ROOM (roomid, type, departmentid)
values (102, 'PICU', 195);
insert into ROOM (roomid, type, departmentid)
values (103, 'NICU', 329);
insert into ROOM (roomid, type, departmentid)
values (104, 'ICU', 23);
insert into ROOM (roomid, type, departmentid)
values (105, 'Maternity', 365);
insert into ROOM (roomid, type, departmentid)
values (106, 'Isolation', 143);
insert into ROOM (roomid, type, departmentid)
values (107, 'Labor and Delivery', 471);
insert into ROOM (roomid, type, departmentid)
values (108, 'Labor and Delivery', 226);
insert into ROOM (roomid, type, departmentid)
values (109, 'PICU', 342);
insert into ROOM (roomid, type, departmentid)
values (110, 'ICU', 109);
insert into ROOM (roomid, type, departmentid)
values (111, 'Isolation', 424);
insert into ROOM (roomid, type, departmentid)
values (112, 'Maternity', 122);
insert into ROOM (roomid, type, departmentid)
values (113, 'CCU', 471);
insert into ROOM (roomid, type, departmentid)
values (114, 'Psychiatric', 308);
insert into ROOM (roomid, type, departmentid)
values (115, 'Psychiatric', 14);
insert into ROOM (roomid, type, departmentid)
values (116, 'ICU', 254);
insert into ROOM (roomid, type, departmentid)
values (117, 'PICU', 40);
insert into ROOM (roomid, type, departmentid)
values (118, 'PICU', 361);
insert into ROOM (roomid, type, departmentid)
values (119, 'ICU', 259);
insert into ROOM (roomid, type, departmentid)
values (120, 'General Ward', 28);
insert into ROOM (roomid, type, departmentid)
values (121, 'Emergency', 492);
insert into ROOM (roomid, type, departmentid)
values (122, 'Psychiatric', 313);
insert into ROOM (roomid, type, departmentid)
values (123, 'Surgery', 333);
insert into ROOM (roomid, type, departmentid)
values (124, 'Private', 311);
insert into ROOM (roomid, type, departmentid)
values (125, 'CCU', 341);
insert into ROOM (roomid, type, departmentid)
values (126, 'Rehabilitation', 56);
insert into ROOM (roomid, type, departmentid)
values (127, 'Psychiatric', 186);
insert into ROOM (roomid, type, departmentid)
values (128, 'Maternity', 433);
insert into ROOM (roomid, type, departmentid)
values (129, 'Rehabilitation', 245);
insert into ROOM (roomid, type, departmentid)
values (130, 'CCU', 164);
insert into ROOM (roomid, type, departmentid)
values (131, 'CCU', 321);
insert into ROOM (roomid, type, departmentid)
values (132, 'Semi-Private', 97);
insert into ROOM (roomid, type, departmentid)
values (133, 'Isolation', 238);
insert into ROOM (roomid, type, departmentid)
values (134, 'PICU', 125);
insert into ROOM (roomid, type, departmentid)
values (135, 'ICU', 225);
insert into ROOM (roomid, type, departmentid)
values (136, 'ICU', 194);
insert into ROOM (roomid, type, departmentid)
values (137, 'Isolation', 110);
insert into ROOM (roomid, type, departmentid)
values (138, 'NICU', 490);
insert into ROOM (roomid, type, departmentid)
values (139, 'General Ward', 461);
insert into ROOM (roomid, type, departmentid)
values (140, 'Rehabilitation', 23);
insert into ROOM (roomid, type, departmentid)
values (141, 'Isolation', 459);
insert into ROOM (roomid, type, departmentid)
values (142, 'NICU', 420);
insert into ROOM (roomid, type, departmentid)
values (143, 'Emergency', 407);
insert into ROOM (roomid, type, departmentid)
values (144, 'Isolation', 422);
insert into ROOM (roomid, type, departmentid)
values (145, 'Isolation', 377);
insert into ROOM (roomid, type, departmentid)
values (146, 'CCU', 140);
insert into ROOM (roomid, type, departmentid)
values (147, 'Isolation', 166);
insert into ROOM (roomid, type, departmentid)
values (148, 'Private', 300);
insert into ROOM (roomid, type, departmentid)
values (149, 'ICU', 315);
insert into ROOM (roomid, type, departmentid)
values (150, 'Emergency', 306);
insert into ROOM (roomid, type, departmentid)
values (151, 'Psychiatric', 115);
insert into ROOM (roomid, type, departmentid)
values (152, 'Private', 80);
insert into ROOM (roomid, type, departmentid)
values (153, 'Isolation', 88);
insert into ROOM (roomid, type, departmentid)
values (154, 'General Ward', 271);
insert into ROOM (roomid, type, departmentid)
values (155, 'Recovery', 126);
insert into ROOM (roomid, type, departmentid)
values (156, 'NICU', 41);
insert into ROOM (roomid, type, departmentid)
values (157, 'Private', 42);
insert into ROOM (roomid, type, departmentid)
values (158, 'Recovery', 259);
insert into ROOM (roomid, type, departmentid)
values (159, 'Labor and Delivery', 432);
insert into ROOM (roomid, type, departmentid)
values (160, 'ICU', 74);
insert into ROOM (roomid, type, departmentid)
values (161, 'Private', 380);
insert into ROOM (roomid, type, departmentid)
values (162, 'PICU', 446);
insert into ROOM (roomid, type, departmentid)
values (163, 'Labor and Delivery', 152);
insert into ROOM (roomid, type, departmentid)
values (164, 'PICU', 344);
insert into ROOM (roomid, type, departmentid)
values (165, 'Private', 141);
insert into ROOM (roomid, type, departmentid)
values (166, 'Semi-Private', 452);
insert into ROOM (roomid, type, departmentid)
values (167, 'Semi-Private', 480);
insert into ROOM (roomid, type, departmentid)
values (168, 'Surgery', 348);
insert into ROOM (roomid, type, departmentid)
values (169, 'Surgery', 333);
insert into ROOM (roomid, type, departmentid)
values (170, 'Surgery', 228);
insert into ROOM (roomid, type, departmentid)
values (171, 'Maternity', 16);
insert into ROOM (roomid, type, departmentid)
values (172, 'Emergency', 395);
insert into ROOM (roomid, type, departmentid)
values (173, 'Rehabilitation', 227);
insert into ROOM (roomid, type, departmentid)
values (174, 'CCU', 358);
insert into ROOM (roomid, type, departmentid)
values (175, 'Recovery', 269);
insert into ROOM (roomid, type, departmentid)
values (176, 'CCU', 477);
insert into ROOM (roomid, type, departmentid)
values (177, 'Semi-Private', 307);
insert into ROOM (roomid, type, departmentid)
values (178, 'Surgery', 268);
insert into ROOM (roomid, type, departmentid)
values (179, 'Emergency', 299);
insert into ROOM (roomid, type, departmentid)
values (180, 'Recovery', 58);
insert into ROOM (roomid, type, departmentid)
values (181, 'Psychiatric', 370);
insert into ROOM (roomid, type, departmentid)
values (182, 'Isolation', 336);
insert into ROOM (roomid, type, departmentid)
values (183, 'Psychiatric', 35);
insert into ROOM (roomid, type, departmentid)
values (184, 'General Ward', 261);
insert into ROOM (roomid, type, departmentid)
values (185, 'CCU', 292);
insert into ROOM (roomid, type, departmentid)
values (186, 'Emergency', 409);
insert into ROOM (roomid, type, departmentid)
values (187, 'NICU', 231);
insert into ROOM (roomid, type, departmentid)
values (188, 'CCU', 468);
insert into ROOM (roomid, type, departmentid)
values (189, 'PICU', 440);
insert into ROOM (roomid, type, departmentid)
values (190, 'Private', 230);
insert into ROOM (roomid, type, departmentid)
values (191, 'Recovery', 90);
insert into ROOM (roomid, type, departmentid)
values (192, 'General Ward', 320);
insert into ROOM (roomid, type, departmentid)
values (193, 'CCU', 248);
insert into ROOM (roomid, type, departmentid)
values (194, 'Psychiatric', 269);
insert into ROOM (roomid, type, departmentid)
values (195, 'NICU', 39);
insert into ROOM (roomid, type, departmentid)
values (196, 'Maternity', 126);
insert into ROOM (roomid, type, departmentid)
values (197, 'Private', 448);
insert into ROOM (roomid, type, departmentid)
values (198, 'NICU', 459);
insert into ROOM (roomid, type, departmentid)
values (199, 'Labor and Delivery', 160);
insert into ROOM (roomid, type, departmentid)
values (200, 'Isolation', 184);
commit;
prompt 200 records committed...
insert into ROOM (roomid, type, departmentid)
values (201, 'Labor and Delivery', 451);
insert into ROOM (roomid, type, departmentid)
values (202, 'Recovery', 341);
insert into ROOM (roomid, type, departmentid)
values (203, 'General Ward', 285);
insert into ROOM (roomid, type, departmentid)
values (204, 'Emergency', 493);
insert into ROOM (roomid, type, departmentid)
values (205, 'NICU', 394);
insert into ROOM (roomid, type, departmentid)
values (206, 'Maternity', 113);
insert into ROOM (roomid, type, departmentid)
values (207, 'Maternity', 233);
insert into ROOM (roomid, type, departmentid)
values (208, 'CCU', 392);
insert into ROOM (roomid, type, departmentid)
values (209, 'Recovery', 335);
insert into ROOM (roomid, type, departmentid)
values (210, 'PICU', 86);
insert into ROOM (roomid, type, departmentid)
values (211, 'Recovery', 217);
insert into ROOM (roomid, type, departmentid)
values (212, 'Rehabilitation', 83);
insert into ROOM (roomid, type, departmentid)
values (213, 'Semi-Private', 108);
insert into ROOM (roomid, type, departmentid)
values (214, 'Emergency', 46);
insert into ROOM (roomid, type, departmentid)
values (215, 'CCU', 399);
insert into ROOM (roomid, type, departmentid)
values (216, 'Recovery', 81);
insert into ROOM (roomid, type, departmentid)
values (217, 'NICU', 336);
insert into ROOM (roomid, type, departmentid)
values (218, 'Private', 25);
insert into ROOM (roomid, type, departmentid)
values (219, 'Isolation', 106);
insert into ROOM (roomid, type, departmentid)
values (220, 'Maternity', 56);
insert into ROOM (roomid, type, departmentid)
values (221, 'Rehabilitation', 94);
insert into ROOM (roomid, type, departmentid)
values (222, 'Psychiatric', 471);
insert into ROOM (roomid, type, departmentid)
values (223, 'NICU', 198);
insert into ROOM (roomid, type, departmentid)
values (224, 'CCU', 85);
insert into ROOM (roomid, type, departmentid)
values (225, 'Surgery', 237);
insert into ROOM (roomid, type, departmentid)
values (226, 'Rehabilitation', 335);
insert into ROOM (roomid, type, departmentid)
values (227, 'Psychiatric', 95);
insert into ROOM (roomid, type, departmentid)
values (228, 'Emergency', 314);
insert into ROOM (roomid, type, departmentid)
values (229, 'PICU', 374);
insert into ROOM (roomid, type, departmentid)
values (230, 'NICU', 52);
insert into ROOM (roomid, type, departmentid)
values (231, 'CCU', 459);
insert into ROOM (roomid, type, departmentid)
values (232, 'Psychiatric', 22);
insert into ROOM (roomid, type, departmentid)
values (233, 'Labor and Delivery', 10);
insert into ROOM (roomid, type, departmentid)
values (234, 'General Ward', 440);
insert into ROOM (roomid, type, departmentid)
values (235, 'Labor and Delivery', 37);
insert into ROOM (roomid, type, departmentid)
values (236, 'Surgery', 92);
insert into ROOM (roomid, type, departmentid)
values (237, 'Rehabilitation', 332);
insert into ROOM (roomid, type, departmentid)
values (238, 'Emergency', 498);
insert into ROOM (roomid, type, departmentid)
values (239, 'PICU', 149);
insert into ROOM (roomid, type, departmentid)
values (240, 'ICU', 393);
insert into ROOM (roomid, type, departmentid)
values (241, 'NICU', 162);
insert into ROOM (roomid, type, departmentid)
values (242, 'Rehabilitation', 108);
insert into ROOM (roomid, type, departmentid)
values (243, 'Emergency', 346);
insert into ROOM (roomid, type, departmentid)
values (244, 'General Ward', 56);
insert into ROOM (roomid, type, departmentid)
values (245, 'Recovery', 58);
insert into ROOM (roomid, type, departmentid)
values (246, 'Isolation', 156);
insert into ROOM (roomid, type, departmentid)
values (247, 'Private', 213);
insert into ROOM (roomid, type, departmentid)
values (248, 'Rehabilitation', 174);
insert into ROOM (roomid, type, departmentid)
values (249, 'CCU', 77);
insert into ROOM (roomid, type, departmentid)
values (250, 'Labor and Delivery', 42);
insert into ROOM (roomid, type, departmentid)
values (251, 'Private', 335);
insert into ROOM (roomid, type, departmentid)
values (252, 'Labor and Delivery', 391);
insert into ROOM (roomid, type, departmentid)
values (253, 'PICU', 191);
insert into ROOM (roomid, type, departmentid)
values (254, 'Psychiatric', 110);
insert into ROOM (roomid, type, departmentid)
values (255, 'CCU', 417);
insert into ROOM (roomid, type, departmentid)
values (256, 'Emergency', 410);
insert into ROOM (roomid, type, departmentid)
values (257, 'PICU', 359);
insert into ROOM (roomid, type, departmentid)
values (258, 'CCU', 475);
insert into ROOM (roomid, type, departmentid)
values (259, 'Rehabilitation', 60);
insert into ROOM (roomid, type, departmentid)
values (260, 'ICU', 399);
insert into ROOM (roomid, type, departmentid)
values (261, 'Private', 261);
insert into ROOM (roomid, type, departmentid)
values (262, 'PICU', 265);
insert into ROOM (roomid, type, departmentid)
values (263, 'General Ward', 195);
insert into ROOM (roomid, type, departmentid)
values (264, 'Semi-Private', 309);
insert into ROOM (roomid, type, departmentid)
values (265, 'Psychiatric', 179);
insert into ROOM (roomid, type, departmentid)
values (266, 'NICU', 263);
insert into ROOM (roomid, type, departmentid)
values (267, 'ICU', 169);
insert into ROOM (roomid, type, departmentid)
values (268, 'NICU', 92);
insert into ROOM (roomid, type, departmentid)
values (269, 'PICU', 40);
insert into ROOM (roomid, type, departmentid)
values (270, 'Labor and Delivery', 452);
insert into ROOM (roomid, type, departmentid)
values (271, 'Isolation', 492);
insert into ROOM (roomid, type, departmentid)
values (272, 'Rehabilitation', 334);
insert into ROOM (roomid, type, departmentid)
values (273, 'Psychiatric', 115);
insert into ROOM (roomid, type, departmentid)
values (274, 'CCU', 479);
insert into ROOM (roomid, type, departmentid)
values (275, 'NICU', 239);
insert into ROOM (roomid, type, departmentid)
values (276, 'Emergency', 284);
insert into ROOM (roomid, type, departmentid)
values (277, 'Maternity', 374);
insert into ROOM (roomid, type, departmentid)
values (278, 'Surgery', 12);
insert into ROOM (roomid, type, departmentid)
values (279, 'Labor and Delivery', 106);
insert into ROOM (roomid, type, departmentid)
values (280, 'Semi-Private', 299);
insert into ROOM (roomid, type, departmentid)
values (281, 'Labor and Delivery', 497);
insert into ROOM (roomid, type, departmentid)
values (282, 'Isolation', 10);
insert into ROOM (roomid, type, departmentid)
values (283, 'Emergency', 125);
insert into ROOM (roomid, type, departmentid)
values (284, 'PICU', 186);
insert into ROOM (roomid, type, departmentid)
values (285, 'Private', 39);
insert into ROOM (roomid, type, departmentid)
values (286, 'CCU', 396);
insert into ROOM (roomid, type, departmentid)
values (287, 'Rehabilitation', 33);
insert into ROOM (roomid, type, departmentid)
values (288, 'Psychiatric', 461);
insert into ROOM (roomid, type, departmentid)
values (289, 'PICU', 254);
insert into ROOM (roomid, type, departmentid)
values (290, 'Surgery', 143);
insert into ROOM (roomid, type, departmentid)
values (291, 'Emergency', 300);
insert into ROOM (roomid, type, departmentid)
values (292, 'Rehabilitation', 2);
insert into ROOM (roomid, type, departmentid)
values (293, 'Semi-Private', 76);
insert into ROOM (roomid, type, departmentid)
values (294, 'CCU', 256);
insert into ROOM (roomid, type, departmentid)
values (295, 'Maternity', 310);
insert into ROOM (roomid, type, departmentid)
values (296, 'Rehabilitation', 117);
insert into ROOM (roomid, type, departmentid)
values (297, 'Psychiatric', 252);
insert into ROOM (roomid, type, departmentid)
values (298, 'Emergency', 168);
insert into ROOM (roomid, type, departmentid)
values (299, 'Isolation', 201);
insert into ROOM (roomid, type, departmentid)
values (300, 'CCU', 17);
commit;
prompt 300 records committed...
insert into ROOM (roomid, type, departmentid)
values (301, 'CCU', 138);
insert into ROOM (roomid, type, departmentid)
values (302, 'Semi-Private', 40);
insert into ROOM (roomid, type, departmentid)
values (303, 'Semi-Private', 360);
insert into ROOM (roomid, type, departmentid)
values (304, 'CCU', 192);
insert into ROOM (roomid, type, departmentid)
values (305, 'Private', 143);
insert into ROOM (roomid, type, departmentid)
values (306, 'Private', 465);
insert into ROOM (roomid, type, departmentid)
values (307, 'CCU', 73);
insert into ROOM (roomid, type, departmentid)
values (308, 'Surgery', 197);
insert into ROOM (roomid, type, departmentid)
values (309, 'Psychiatric', 335);
insert into ROOM (roomid, type, departmentid)
values (310, 'Isolation', 84);
insert into ROOM (roomid, type, departmentid)
values (311, 'ICU', 335);
insert into ROOM (roomid, type, departmentid)
values (312, 'Psychiatric', 339);
insert into ROOM (roomid, type, departmentid)
values (313, 'Recovery', 204);
insert into ROOM (roomid, type, departmentid)
values (314, 'Psychiatric', 100);
insert into ROOM (roomid, type, departmentid)
values (315, 'PICU', 311);
insert into ROOM (roomid, type, departmentid)
values (316, 'Maternity', 279);
insert into ROOM (roomid, type, departmentid)
values (317, 'CCU', 75);
insert into ROOM (roomid, type, departmentid)
values (318, 'ICU', 208);
insert into ROOM (roomid, type, departmentid)
values (319, 'General Ward', 459);
insert into ROOM (roomid, type, departmentid)
values (320, 'CCU', 29);
insert into ROOM (roomid, type, departmentid)
values (321, 'Maternity', 184);
insert into ROOM (roomid, type, departmentid)
values (322, 'CCU', 420);
insert into ROOM (roomid, type, departmentid)
values (323, 'ICU', 304);
insert into ROOM (roomid, type, departmentid)
values (324, 'Surgery', 365);
insert into ROOM (roomid, type, departmentid)
values (325, 'Semi-Private', 409);
insert into ROOM (roomid, type, departmentid)
values (326, 'Rehabilitation', 307);
insert into ROOM (roomid, type, departmentid)
values (327, 'Surgery', 373);
insert into ROOM (roomid, type, departmentid)
values (328, 'Isolation', 143);
insert into ROOM (roomid, type, departmentid)
values (329, 'Rehabilitation', 150);
insert into ROOM (roomid, type, departmentid)
values (330, 'Private', 143);
insert into ROOM (roomid, type, departmentid)
values (331, 'PICU', 280);
insert into ROOM (roomid, type, departmentid)
values (332, 'Emergency', 18);
insert into ROOM (roomid, type, departmentid)
values (333, 'Psychiatric', 376);
insert into ROOM (roomid, type, departmentid)
values (334, 'Private', 450);
insert into ROOM (roomid, type, departmentid)
values (335, 'Maternity', 478);
insert into ROOM (roomid, type, departmentid)
values (336, 'Emergency', 72);
insert into ROOM (roomid, type, departmentid)
values (337, 'Rehabilitation', 322);
insert into ROOM (roomid, type, departmentid)
values (338, 'General Ward', 458);
insert into ROOM (roomid, type, departmentid)
values (339, 'PICU', 151);
insert into ROOM (roomid, type, departmentid)
values (340, 'Isolation', 352);
insert into ROOM (roomid, type, departmentid)
values (341, 'Recovery', 344);
insert into ROOM (roomid, type, departmentid)
values (342, 'Maternity', 466);
insert into ROOM (roomid, type, departmentid)
values (343, 'ICU', 279);
insert into ROOM (roomid, type, departmentid)
values (344, 'Semi-Private', 306);
insert into ROOM (roomid, type, departmentid)
values (345, 'Rehabilitation', 428);
insert into ROOM (roomid, type, departmentid)
values (346, 'Isolation', 112);
insert into ROOM (roomid, type, departmentid)
values (347, 'ICU', 351);
insert into ROOM (roomid, type, departmentid)
values (348, 'Emergency', 131);
insert into ROOM (roomid, type, departmentid)
values (349, 'Recovery', 357);
insert into ROOM (roomid, type, departmentid)
values (350, 'PICU', 45);
insert into ROOM (roomid, type, departmentid)
values (351, 'Emergency', 230);
insert into ROOM (roomid, type, departmentid)
values (352, 'General Ward', 28);
insert into ROOM (roomid, type, departmentid)
values (353, 'Labor and Delivery', 38);
insert into ROOM (roomid, type, departmentid)
values (354, 'PICU', 8);
insert into ROOM (roomid, type, departmentid)
values (355, 'Maternity', 186);
insert into ROOM (roomid, type, departmentid)
values (356, 'CCU', 357);
insert into ROOM (roomid, type, departmentid)
values (357, 'Isolation', 477);
insert into ROOM (roomid, type, departmentid)
values (358, 'NICU', 326);
insert into ROOM (roomid, type, departmentid)
values (359, 'CCU', 75);
insert into ROOM (roomid, type, departmentid)
values (360, 'Isolation', 208);
insert into ROOM (roomid, type, departmentid)
values (361, 'Labor and Delivery', 415);
insert into ROOM (roomid, type, departmentid)
values (362, 'Private', 298);
insert into ROOM (roomid, type, departmentid)
values (363, 'ICU', 177);
insert into ROOM (roomid, type, departmentid)
values (364, 'NICU', 368);
insert into ROOM (roomid, type, departmentid)
values (365, 'Semi-Private', 125);
insert into ROOM (roomid, type, departmentid)
values (366, 'Maternity', 496);
insert into ROOM (roomid, type, departmentid)
values (367, 'Psychiatric', 194);
insert into ROOM (roomid, type, departmentid)
values (368, 'PICU', 201);
insert into ROOM (roomid, type, departmentid)
values (369, 'Recovery', 354);
insert into ROOM (roomid, type, departmentid)
values (370, 'Semi-Private', 475);
insert into ROOM (roomid, type, departmentid)
values (371, 'Rehabilitation', 398);
insert into ROOM (roomid, type, departmentid)
values (372, 'PICU', 430);
insert into ROOM (roomid, type, departmentid)
values (373, 'NICU', 431);
insert into ROOM (roomid, type, departmentid)
values (374, 'General Ward', 380);
insert into ROOM (roomid, type, departmentid)
values (375, 'General Ward', 444);
insert into ROOM (roomid, type, departmentid)
values (376, 'Isolation', 332);
insert into ROOM (roomid, type, departmentid)
values (377, 'Rehabilitation', 27);
insert into ROOM (roomid, type, departmentid)
values (378, 'Emergency', 469);
insert into ROOM (roomid, type, departmentid)
values (379, 'NICU', 328);
insert into ROOM (roomid, type, departmentid)
values (380, 'Labor and Delivery', 330);
insert into ROOM (roomid, type, departmentid)
values (381, 'General Ward', 72);
insert into ROOM (roomid, type, departmentid)
values (382, 'Emergency', 35);
insert into ROOM (roomid, type, departmentid)
values (383, 'Private', 9);
insert into ROOM (roomid, type, departmentid)
values (384, 'Isolation', 499);
insert into ROOM (roomid, type, departmentid)
values (385, 'Labor and Delivery', 329);
insert into ROOM (roomid, type, departmentid)
values (386, 'Private', 239);
insert into ROOM (roomid, type, departmentid)
values (387, 'Labor and Delivery', 188);
insert into ROOM (roomid, type, departmentid)
values (388, 'Surgery', 472);
insert into ROOM (roomid, type, departmentid)
values (389, 'Rehabilitation', 120);
insert into ROOM (roomid, type, departmentid)
values (390, 'Private', 346);
insert into ROOM (roomid, type, departmentid)
values (391, 'General Ward', 236);
insert into ROOM (roomid, type, departmentid)
values (392, 'Private', 260);
insert into ROOM (roomid, type, departmentid)
values (393, 'CCU', 218);
insert into ROOM (roomid, type, departmentid)
values (394, 'PICU', 369);
insert into ROOM (roomid, type, departmentid)
values (395, 'Surgery', 287);
insert into ROOM (roomid, type, departmentid)
values (396, 'CCU', 469);
insert into ROOM (roomid, type, departmentid)
values (397, 'Psychiatric', 383);
insert into ROOM (roomid, type, departmentid)
values (398, 'ICU', 118);
insert into ROOM (roomid, type, departmentid)
values (399, 'Psychiatric', 482);
insert into ROOM (roomid, type, departmentid)
values (400, 'PICU', 431);
commit;
prompt 400 records committed...
insert into ROOM (roomid, type, departmentid)
values (401, 'Labor and Delivery', 63);
insert into ROOM (roomid, type, departmentid)
values (402, 'Emergency', 158);
insert into ROOM (roomid, type, departmentid)
values (403, 'Semi-Private', 369);
insert into ROOM (roomid, type, departmentid)
values (404, 'Semi-Private', 237);
insert into ROOM (roomid, type, departmentid)
values (405, 'Semi-Private', 248);
insert into ROOM (roomid, type, departmentid)
values (406, 'Rehabilitation', 170);
insert into ROOM (roomid, type, departmentid)
values (407, 'Private', 461);
insert into ROOM (roomid, type, departmentid)
values (408, 'Private', 178);
insert into ROOM (roomid, type, departmentid)
values (409, 'CCU', 483);
insert into ROOM (roomid, type, departmentid)
values (410, 'Surgery', 219);
insert into ROOM (roomid, type, departmentid)
values (411, 'CCU', 451);
insert into ROOM (roomid, type, departmentid)
values (412, 'General Ward', 89);
insert into ROOM (roomid, type, departmentid)
values (413, 'Maternity', 29);
insert into ROOM (roomid, type, departmentid)
values (414, 'Semi-Private', 429);
insert into ROOM (roomid, type, departmentid)
values (415, 'Isolation', 82);
insert into ROOM (roomid, type, departmentid)
values (416, 'PICU', 108);
insert into ROOM (roomid, type, departmentid)
values (417, 'Private', 194);
insert into ROOM (roomid, type, departmentid)
values (418, 'Emergency', 67);
insert into ROOM (roomid, type, departmentid)
values (419, 'Emergency', 172);
insert into ROOM (roomid, type, departmentid)
values (420, 'Psychiatric', 329);
insert into ROOM (roomid, type, departmentid)
values (421, 'Emergency', 307);
insert into ROOM (roomid, type, departmentid)
values (422, 'Isolation', 24);
insert into ROOM (roomid, type, departmentid)
values (423, 'CCU', 297);
insert into ROOM (roomid, type, departmentid)
values (424, 'Private', 370);
insert into ROOM (roomid, type, departmentid)
values (425, 'General Ward', 354);
insert into ROOM (roomid, type, departmentid)
values (426, 'Rehabilitation', 216);
insert into ROOM (roomid, type, departmentid)
values (427, 'General Ward', 132);
insert into ROOM (roomid, type, departmentid)
values (428, 'Recovery', 346);
insert into ROOM (roomid, type, departmentid)
values (429, 'Surgery', 273);
insert into ROOM (roomid, type, departmentid)
values (430, 'Maternity', 379);
insert into ROOM (roomid, type, departmentid)
values (431, 'General Ward', 443);
insert into ROOM (roomid, type, departmentid)
values (432, 'Surgery', 242);
insert into ROOM (roomid, type, departmentid)
values (433, 'ICU', 401);
insert into ROOM (roomid, type, departmentid)
values (434, 'Semi-Private', 275);
insert into ROOM (roomid, type, departmentid)
values (435, 'Rehabilitation', 240);
insert into ROOM (roomid, type, departmentid)
values (436, 'Isolation', 205);
insert into ROOM (roomid, type, departmentid)
values (437, 'PICU', 76);
insert into ROOM (roomid, type, departmentid)
values (438, 'Labor and Delivery', 307);
insert into ROOM (roomid, type, departmentid)
values (439, 'Private', 85);
insert into ROOM (roomid, type, departmentid)
values (440, 'Isolation', 226);
insert into ROOM (roomid, type, departmentid)
values (441, 'Rehabilitation', 403);
insert into ROOM (roomid, type, departmentid)
values (442, 'Maternity', 35);
insert into ROOM (roomid, type, departmentid)
values (443, 'Isolation', 54);
insert into ROOM (roomid, type, departmentid)
values (444, 'Recovery', 245);
insert into ROOM (roomid, type, departmentid)
values (445, 'Surgery', 164);
insert into ROOM (roomid, type, departmentid)
values (446, 'Semi-Private', 104);
insert into ROOM (roomid, type, departmentid)
values (447, 'Maternity', 361);
insert into ROOM (roomid, type, departmentid)
values (448, 'Semi-Private', 146);
insert into ROOM (roomid, type, departmentid)
values (449, 'Recovery', 398);
insert into ROOM (roomid, type, departmentid)
values (450, 'Isolation', 71);
insert into ROOM (roomid, type, departmentid)
values (451, 'Psychiatric', 129);
insert into ROOM (roomid, type, departmentid)
values (452, 'PICU', 171);
insert into ROOM (roomid, type, departmentid)
values (453, 'Emergency', 127);
insert into ROOM (roomid, type, departmentid)
values (454, 'CCU', 143);
insert into ROOM (roomid, type, departmentid)
values (455, 'General Ward', 328);
insert into ROOM (roomid, type, departmentid)
values (456, 'Maternity', 235);
insert into ROOM (roomid, type, departmentid)
values (457, 'General Ward', 241);
insert into ROOM (roomid, type, departmentid)
values (458, 'Labor and Delivery', 327);
insert into ROOM (roomid, type, departmentid)
values (459, 'PICU', 357);
insert into ROOM (roomid, type, departmentid)
values (460, 'Labor and Delivery', 147);
insert into ROOM (roomid, type, departmentid)
values (461, 'PICU', 42);
insert into ROOM (roomid, type, departmentid)
values (462, 'Rehabilitation', 468);
insert into ROOM (roomid, type, departmentid)
values (463, 'Semi-Private', 299);
insert into ROOM (roomid, type, departmentid)
values (464, 'Semi-Private', 236);
insert into ROOM (roomid, type, departmentid)
values (465, 'Labor and Delivery', 442);
insert into ROOM (roomid, type, departmentid)
values (466, 'CCU', 217);
insert into ROOM (roomid, type, departmentid)
values (467, 'Psychiatric', 313);
insert into ROOM (roomid, type, departmentid)
values (468, 'Semi-Private', 388);
insert into ROOM (roomid, type, departmentid)
values (469, 'Recovery', 318);
insert into ROOM (roomid, type, departmentid)
values (470, 'Psychiatric', 386);
insert into ROOM (roomid, type, departmentid)
values (471, 'General Ward', 195);
insert into ROOM (roomid, type, departmentid)
values (472, 'PICU', 488);
insert into ROOM (roomid, type, departmentid)
values (473, 'Isolation', 18);
insert into ROOM (roomid, type, departmentid)
values (474, 'Isolation', 217);
insert into ROOM (roomid, type, departmentid)
values (475, 'Emergency', 95);
insert into ROOM (roomid, type, departmentid)
values (476, 'Semi-Private', 260);
insert into ROOM (roomid, type, departmentid)
values (477, 'Emergency', 36);
insert into ROOM (roomid, type, departmentid)
values (478, 'CCU', 61);
insert into ROOM (roomid, type, departmentid)
values (479, 'CCU', 382);
insert into ROOM (roomid, type, departmentid)
values (480, 'ICU', 28);
insert into ROOM (roomid, type, departmentid)
values (481, 'Maternity', 328);
insert into ROOM (roomid, type, departmentid)
values (482, 'ICU', 455);
insert into ROOM (roomid, type, departmentid)
values (483, 'Recovery', 175);
insert into ROOM (roomid, type, departmentid)
values (484, 'Semi-Private', 367);
insert into ROOM (roomid, type, departmentid)
values (485, 'Surgery', 297);
insert into ROOM (roomid, type, departmentid)
values (486, 'Labor and Delivery', 111);
insert into ROOM (roomid, type, departmentid)
values (487, 'ICU', 20);
insert into ROOM (roomid, type, departmentid)
values (488, 'ICU', 177);
insert into ROOM (roomid, type, departmentid)
values (489, 'PICU', 424);
insert into ROOM (roomid, type, departmentid)
values (490, 'Recovery', 310);
insert into ROOM (roomid, type, departmentid)
values (491, 'Psychiatric', 234);
insert into ROOM (roomid, type, departmentid)
values (492, 'Recovery', 148);
insert into ROOM (roomid, type, departmentid)
values (493, 'NICU', 63);
insert into ROOM (roomid, type, departmentid)
values (494, 'General Ward', 199);
insert into ROOM (roomid, type, departmentid)
values (495, 'PICU', 401);
insert into ROOM (roomid, type, departmentid)
values (496, 'Recovery', 140);
insert into ROOM (roomid, type, departmentid)
values (497, 'General Ward', 389);
insert into ROOM (roomid, type, departmentid)
values (498, 'Semi-Private', 2);
insert into ROOM (roomid, type, departmentid)
values (499, 'Surgery', 15);
insert into ROOM (roomid, type, departmentid)
values (500, 'Isolation', 470);
commit;
prompt 500 records loaded
prompt Loading PATIENT...
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (1, 'Gunter Cardenas', to_date('02-01-1970', 'dd-mm-yyyy'), '429-336-0573', 358);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (2, 'Bridgette Trythall', to_date('18-01-1955', 'dd-mm-yyyy'), '918-471-5952', 145);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (3, 'Gino Heigho', to_date('09-04-1960', 'dd-mm-yyyy'), '835-722-0925', 484);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (4, 'Hall Lighten', to_date('05-02-2008', 'dd-mm-yyyy'), '167-744-3457', 203);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (5, 'Devinne Sweetnam', to_date('05-09-1981', 'dd-mm-yyyy'), '268-371-1270', 136);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (6, 'Dennis Kix', to_date('06-11-2014', 'dd-mm-yyyy'), '545-504-8168', 91);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (7, 'Viki MacCulloch', to_date('22-10-2023', 'dd-mm-yyyy'), '630-151-8128', 219);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (8, 'Lucius Allan', to_date('02-02-1963', 'dd-mm-yyyy'), '812-537-6652', 255);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (9, 'Kaela Cabena', to_date('19-07-1999', 'dd-mm-yyyy'), '406-699-9131', null);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (10, 'Caitrin Shepley', to_date('28-05-1973', 'dd-mm-yyyy'), '106-272-4005', 451);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (11, 'Zollie Whiteland', to_date('14-07-2004', 'dd-mm-yyyy'), '120-264-9406', 48);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (12, 'Binnie Bellchamber', to_date('07-08-2013', 'dd-mm-yyyy'), '762-163-7130', 228);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (13, 'Moishe Spon', to_date('02-03-1990', 'dd-mm-yyyy'), '125-721-3337', 279);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (14, 'Geoffry Aujouanet', to_date('10-01-1992', 'dd-mm-yyyy'), '335-125-5086', 331);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (15, 'Westley Dorricott', to_date('13-04-1961', 'dd-mm-yyyy'), '815-492-8058', 305);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (16, 'Nana Lidgertwood', to_date('05-06-1975', 'dd-mm-yyyy'), '991-334-2714', 464);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (17, 'Biddy Addionizio', to_date('27-05-1951', 'dd-mm-yyyy'), '397-789-2584', 182);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (18, 'Juliane Zupone', to_date('04-03-2005', 'dd-mm-yyyy'), '568-578-7375', 194);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (19, 'Dimitry Tithacott', to_date('19-06-1963', 'dd-mm-yyyy'), '594-914-2976', 42);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (20, 'Kesley Avey', to_date('25-01-2012', 'dd-mm-yyyy'), '510-724-3174', 365);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (21, 'Cthrine Niesing', to_date('07-02-2021', 'dd-mm-yyyy'), '317-770-3561', 50);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (22, 'Kelsy Tebbutt', to_date('01-07-2022', 'dd-mm-yyyy'), '728-991-8826', 260);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (23, 'Barbi Muzzlewhite', to_date('26-11-1979', 'dd-mm-yyyy'), '811-425-5462', 233);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (24, 'Creighton Standfield', to_date('23-12-2010', 'dd-mm-yyyy'), '274-297-6695', 139);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (25, 'Salomon Reith', to_date('02-06-1974', 'dd-mm-yyyy'), '505-416-7364', 360);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (26, 'Aldis Gallety', to_date('14-01-1951', 'dd-mm-yyyy'), '372-350-9884', 260);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (27, 'Hattie Hillaby', to_date('25-03-1958', 'dd-mm-yyyy'), '217-260-3541', 179);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (28, 'Hyatt Ogborne', to_date('29-05-1950', 'dd-mm-yyyy'), '446-834-9516', 384);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (29, 'Gerard Wike', to_date('18-08-1998', 'dd-mm-yyyy'), '422-658-2629', 409);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (30, 'Waldon Belvard', to_date('25-10-1986', 'dd-mm-yyyy'), '453-348-5622', 11);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (31, 'Genna Prandi', to_date('04-08-1958', 'dd-mm-yyyy'), '596-862-2837', 160);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (32, 'Carry Sandercock', to_date('17-03-2006', 'dd-mm-yyyy'), '113-487-0375', 325);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (33, 'Lelah Moreland', to_date('04-02-2003', 'dd-mm-yyyy'), '383-972-9792', 412);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (34, 'Nedi Rontree', to_date('17-03-1976', 'dd-mm-yyyy'), '492-392-7694', 349);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (35, 'Nissy Guerre', to_date('03-04-1964', 'dd-mm-yyyy'), '263-637-2745', 439);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (36, 'Anatola Grewar', to_date('13-07-1979', 'dd-mm-yyyy'), '962-259-1913', 173);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (37, 'Del Ledwitch', to_date('18-04-2005', 'dd-mm-yyyy'), '660-417-9917', 43);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (38, 'Zia Hadlington', to_date('25-03-2009', 'dd-mm-yyyy'), '714-638-9023', 349);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (39, 'Rania Hardacre', to_date('17-03-1957', 'dd-mm-yyyy'), '550-113-1090', 423);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (40, 'Cicily Sikorsky', to_date('08-11-1985', 'dd-mm-yyyy'), '638-585-9577', 229);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (41, 'Jefferey Silvester', to_date('07-11-1962', 'dd-mm-yyyy'), '712-655-2738', 259);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (42, 'Lazar Rosenvasser', to_date('22-05-1991', 'dd-mm-yyyy'), '796-856-5044', 341);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (43, 'Dwayne Gallimore', to_date('12-05-2006', 'dd-mm-yyyy'), '924-516-1128', 21);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (44, 'Beltran Strond', to_date('25-08-1963', 'dd-mm-yyyy'), '541-596-4857', 433);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (45, 'Hilda Jobson', to_date('18-06-1950', 'dd-mm-yyyy'), '308-464-4184', 130);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (46, 'Clemmy Maydway', to_date('15-03-1996', 'dd-mm-yyyy'), '641-850-8132', 493);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (47, 'Elise Spatarul', to_date('13-04-1954', 'dd-mm-yyyy'), '723-602-0546', 382);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (48, 'Janot Gothup', to_date('30-11-2004', 'dd-mm-yyyy'), '752-911-2026', 85);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (49, 'Mabel Ginnaly', to_date('28-02-1956', 'dd-mm-yyyy'), '200-614-3330', 495);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (50, 'Heloise Flement', to_date('26-04-1991', 'dd-mm-yyyy'), '379-555-1588', 380);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (51, 'Lissa Madeley', to_date('18-12-2012', 'dd-mm-yyyy'), '596-997-5462', 207);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (52, 'Glynda O''Spellissey', to_date('21-01-1986', 'dd-mm-yyyy'), '538-427-9761', 113);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (53, 'Barbaraanne Blewitt', to_date('22-03-2016', 'dd-mm-yyyy'), '890-120-6284', 366);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (54, 'Martainn Bruhke', to_date('26-03-2016', 'dd-mm-yyyy'), '781-886-4118', 115);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (55, 'Munmro Lippitt', to_date('24-11-1971', 'dd-mm-yyyy'), '645-442-3460', 471);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (56, 'Jim Elecum', to_date('25-02-1951', 'dd-mm-yyyy'), '528-436-2648', 207);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (57, 'El Kirke', to_date('02-08-2002', 'dd-mm-yyyy'), '710-294-3636', 259);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (58, 'Hal Hedge', to_date('29-12-1977', 'dd-mm-yyyy'), '245-360-8171', 409);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (59, 'Lucio Heimes', to_date('12-09-2019', 'dd-mm-yyyy'), '652-548-2853', 290);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (60, 'Enrika Hedges', to_date('30-04-2021', 'dd-mm-yyyy'), '436-413-2553', 339);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (61, 'Willyt Ferraresi', to_date('20-07-2020', 'dd-mm-yyyy'), '295-393-8016', 71);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (62, 'Alfredo Bette', to_date('27-06-1985', 'dd-mm-yyyy'), '880-960-4168', 146);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (63, 'Molly Piscopiello', to_date('22-11-1998', 'dd-mm-yyyy'), '213-443-3274', 242);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (64, 'Seline Durrad', to_date('12-01-2018', 'dd-mm-yyyy'), '805-670-3145', 158);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (65, 'Amalle Ilott', to_date('08-01-2014', 'dd-mm-yyyy'), '772-782-8497', 222);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (66, 'Clarance Gavey', to_date('20-01-2011', 'dd-mm-yyyy'), '575-369-1321', 241);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (67, 'Cris Wooderson', to_date('21-07-2009', 'dd-mm-yyyy'), '660-378-1808', 87);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (68, 'Thomasine Taile', to_date('05-05-2015', 'dd-mm-yyyy'), '173-307-1577', 141);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (69, 'Nicola Humby', to_date('30-09-1975', 'dd-mm-yyyy'), '535-634-6980', 64);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (70, 'Andrea Adriano', to_date('27-06-1984', 'dd-mm-yyyy'), '795-401-5474', 433);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (71, 'Karlan Lyston', to_date('31-10-1995', 'dd-mm-yyyy'), '976-135-6739', 295);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (72, 'Gerik Kenneford', to_date('26-01-2023', 'dd-mm-yyyy'), '855-449-8208', 254);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (73, 'Cristy Nicol', to_date('06-07-1958', 'dd-mm-yyyy'), '249-978-4838', 475);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (74, 'Venus Jenik', to_date('16-09-2018', 'dd-mm-yyyy'), '211-249-7852', 106);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (75, 'Xymenes Finn', to_date('26-06-1966', 'dd-mm-yyyy'), '964-368-2607', 279);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (76, 'Angie Buntin', to_date('25-12-1979', 'dd-mm-yyyy'), '518-444-4586', 403);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (77, 'Delmore Gomez', to_date('02-11-2000', 'dd-mm-yyyy'), '928-357-7637', 378);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (78, 'Sunshine Pandey', to_date('31-03-2006', 'dd-mm-yyyy'), '793-428-1646', 151);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (79, 'Nana Bashford', to_date('27-09-2009', 'dd-mm-yyyy'), '175-208-1859', 53);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (80, 'Bethena Perez', to_date('06-08-1996', 'dd-mm-yyyy'), '661-619-4184', 177);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (81, 'Ramonda Wetherby', to_date('04-06-1953', 'dd-mm-yyyy'), '728-170-0724', 453);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (82, 'Teador Browell', to_date('30-09-2022', 'dd-mm-yyyy'), '731-892-5522', 425);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (83, 'Valle Kamenar', to_date('17-10-2005', 'dd-mm-yyyy'), '678-527-1310', 250);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (84, 'Townsend Cuppitt', to_date('20-05-1985', 'dd-mm-yyyy'), '200-110-0211', 28);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (85, 'Jordana Duck', to_date('24-02-2009', 'dd-mm-yyyy'), '582-252-5254', 429);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (86, 'Bogey Kmicicki', to_date('18-12-1999', 'dd-mm-yyyy'), '755-874-3632', 248);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (87, 'Skipp Loosemore', to_date('14-05-2007', 'dd-mm-yyyy'), '108-995-7310', 401);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (88, 'Sindee Ebbage', to_date('08-07-1974', 'dd-mm-yyyy'), '695-638-4084', 275);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (89, 'Calley Kubicek', to_date('18-05-1991', 'dd-mm-yyyy'), '235-166-6463', 475);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (90, 'Prudi Montel', to_date('20-11-1963', 'dd-mm-yyyy'), '749-407-1837', 174);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (91, 'Antony Braghini', to_date('23-10-1975', 'dd-mm-yyyy'), '737-730-6449', 411);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (92, 'Farrah McJury', to_date('05-04-1996', 'dd-mm-yyyy'), '911-551-6125', 328);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (93, 'Thorin Matczak', to_date('18-11-1986', 'dd-mm-yyyy'), '455-274-6266', 158);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (94, 'Kizzee Reckhouse', to_date('27-01-1982', 'dd-mm-yyyy'), '860-182-0195', 500);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (95, 'Rachel Tremelling', to_date('30-11-1986', 'dd-mm-yyyy'), '706-881-7934', 444);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (96, 'Garnette Mandres', to_date('12-03-1960', 'dd-mm-yyyy'), '124-725-5592', 237);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (97, 'Callie Eilert', to_date('27-07-2008', 'dd-mm-yyyy'), '621-345-4176', 9);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (98, 'Moises Bolver', to_date('09-03-1952', 'dd-mm-yyyy'), '391-623-8165', 303);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (99, 'Emmy Drysdale', to_date('16-03-1993', 'dd-mm-yyyy'), '465-428-5231', 326);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (100, 'Tome Whilde', to_date('23-03-1956', 'dd-mm-yyyy'), '179-950-6662', 449);
commit;
prompt 100 records committed...
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (101, 'Valentin Bailles', to_date('17-07-1968', 'dd-mm-yyyy'), '841-529-2606', 457);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (102, 'Belvia Benbow', to_date('15-10-2008', 'dd-mm-yyyy'), '126-851-1801', 459);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (103, 'Domenic Beeckx', to_date('27-07-1953', 'dd-mm-yyyy'), '780-633-1738', 192);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (104, 'Nollie Kubat', to_date('24-01-2021', 'dd-mm-yyyy'), '338-569-0869', 428);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (105, 'Elizabet Fischer', to_date('28-09-1952', 'dd-mm-yyyy'), '232-318-6591', 386);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (106, 'Zia Stolli', to_date('26-12-1992', 'dd-mm-yyyy'), '597-674-7703', 460);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (107, 'Calypso Hildrew', to_date('26-05-2017', 'dd-mm-yyyy'), '186-740-6626', 172);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (108, 'Sibbie Babalola', to_date('21-06-2004', 'dd-mm-yyyy'), '145-342-3043', 355);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (109, 'Tabor Gillett', to_date('20-10-2003', 'dd-mm-yyyy'), '774-408-6109', 317);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (110, 'Fionna Brudenell', to_date('21-04-1976', 'dd-mm-yyyy'), '905-175-5354', 426);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (111, 'Celisse Crace', to_date('22-02-2023', 'dd-mm-yyyy'), '497-426-0193', 144);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (112, 'Dylan O''Shields', to_date('08-08-2018', 'dd-mm-yyyy'), '236-355-3236', 336);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (113, 'Urbanus Dongate', to_date('13-04-2017', 'dd-mm-yyyy'), '390-562-8709', 394);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (114, 'Ginnie Templar', to_date('05-08-2010', 'dd-mm-yyyy'), '862-755-4898', 8);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (115, 'Claire Lorey', to_date('14-03-2017', 'dd-mm-yyyy'), '898-369-3346', 470);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (116, 'Amata Cogman', to_date('23-04-1955', 'dd-mm-yyyy'), '491-255-1866', 230);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (117, 'Diandra Vinsen', to_date('14-02-1985', 'dd-mm-yyyy'), '979-247-3473', 40);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (118, 'Emmery Danbi', to_date('13-11-2009', 'dd-mm-yyyy'), '276-495-8893', 354);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (119, 'Alexina Urlin', to_date('14-06-1954', 'dd-mm-yyyy'), '529-576-1488', 120);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (120, 'Shandy Barrus', to_date('24-01-2015', 'dd-mm-yyyy'), '582-957-2004', 466);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (121, 'Corry Whear', to_date('31-05-1976', 'dd-mm-yyyy'), '940-994-4943', 163);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (122, 'Kent Sotham', to_date('02-11-2023', 'dd-mm-yyyy'), '751-708-0965', 306);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (123, 'Elle Simonassi', to_date('23-12-1985', 'dd-mm-yyyy'), '615-251-6013', 428);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (124, 'Jesus Ingree', to_date('11-01-1983', 'dd-mm-yyyy'), '518-381-6224', 318);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (125, 'Alia Veall', to_date('09-04-2012', 'dd-mm-yyyy'), '478-622-3172', 311);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (126, 'Orin Ferry', to_date('13-01-1995', 'dd-mm-yyyy'), '713-526-4524', 274);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (127, 'Silvana Swindell', to_date('31-03-1978', 'dd-mm-yyyy'), '756-564-8392', 405);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (128, 'Ozzie Warrier', to_date('20-03-1979', 'dd-mm-yyyy'), '755-686-6025', 294);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (129, 'Joby Fryd', to_date('16-02-2014', 'dd-mm-yyyy'), '500-847-0201', 49);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (130, 'Ara Richmond', to_date('05-10-1990', 'dd-mm-yyyy'), '721-447-1237', 281);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (131, 'Debor McGloin', to_date('22-07-1957', 'dd-mm-yyyy'), '889-169-3330', 154);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (132, 'Jarred Biggins', to_date('30-10-1982', 'dd-mm-yyyy'), '781-233-6016', 115);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (133, 'Adriaens Divine', to_date('10-08-1973', 'dd-mm-yyyy'), '616-681-0467', 369);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (134, 'Cindelyn Rackam', to_date('31-03-1982', 'dd-mm-yyyy'), '382-346-4297', 98);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (135, 'Sigismund Quig', to_date('01-02-1953', 'dd-mm-yyyy'), '351-210-1006', 84);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (136, 'Gerrie Phippard', to_date('28-07-1957', 'dd-mm-yyyy'), '206-271-9408', 465);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (137, 'Joey Igo', to_date('15-12-1984', 'dd-mm-yyyy'), '502-402-5946', 210);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (138, 'Cleavland Bursnall', to_date('13-01-1956', 'dd-mm-yyyy'), '686-496-2099', 228);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (139, 'Gherardo Petrussi', to_date('07-12-1996', 'dd-mm-yyyy'), '405-530-7595', 108);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (140, 'Woodman Neggrini', to_date('04-02-2001', 'dd-mm-yyyy'), '335-128-2580', 152);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (141, 'Shell Clemenson', to_date('09-12-1963', 'dd-mm-yyyy'), '837-507-8137', 4);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (142, 'Josepha Keijser', to_date('29-09-1997', 'dd-mm-yyyy'), '521-700-2998', 451);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (143, 'Krystyna Brydell', to_date('09-12-1965', 'dd-mm-yyyy'), '357-987-1088', 261);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (144, 'Sergent Schiersch', to_date('25-03-1987', 'dd-mm-yyyy'), '639-415-6160', 202);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (145, 'Salomone Janzen', to_date('01-10-1999', 'dd-mm-yyyy'), '595-666-9943', 345);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (146, 'Brigida Woodrow', to_date('02-07-2008', 'dd-mm-yyyy'), '491-979-5621', 190);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (147, 'Finlay Perch', to_date('18-08-2021', 'dd-mm-yyyy'), '533-370-0216', 320);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (148, 'Kirbee MacRedmond', to_date('01-03-1960', 'dd-mm-yyyy'), '263-360-1191', 189);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (149, 'Bridget Sarrell', to_date('06-11-1959', 'dd-mm-yyyy'), '426-625-9610', 2);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (150, 'Guy Pantlin', to_date('21-01-1983', 'dd-mm-yyyy'), '148-138-3280', 5);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (151, 'Freeman Rojas', to_date('30-09-2018', 'dd-mm-yyyy'), '391-965-6103', 389);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (152, 'Lee Mariolle', to_date('02-01-1993', 'dd-mm-yyyy'), '639-606-3893', 426);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (153, 'Retha Wessing', to_date('21-09-1977', 'dd-mm-yyyy'), '491-240-0733', 391);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (154, 'Arne Bottrell', to_date('17-10-1953', 'dd-mm-yyyy'), '202-921-3181', 330);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (155, 'Kenny Robert', to_date('09-11-1985', 'dd-mm-yyyy'), '469-953-3997', 235);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (156, 'Colan Kennler', to_date('11-07-1987', 'dd-mm-yyyy'), '712-179-3467', 263);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (157, 'Judd Martins', to_date('10-07-1968', 'dd-mm-yyyy'), '380-697-1938', 259);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (158, 'Lucila Muldrew', to_date('24-12-1971', 'dd-mm-yyyy'), '930-586-6583', 239);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (159, 'Silvano Mangan', to_date('27-01-1955', 'dd-mm-yyyy'), '139-604-1833', 201);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (160, 'Gratia Kobieriecki', to_date('22-05-2021', 'dd-mm-yyyy'), '200-788-8129', 483);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (161, 'Rozella Tonry', to_date('19-07-2010', 'dd-mm-yyyy'), '589-637-3847', 408);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (162, 'Philip Belliard', to_date('10-03-2010', 'dd-mm-yyyy'), '965-604-0038', 454);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (163, 'Beltran Drysdale', to_date('30-08-1995', 'dd-mm-yyyy'), '875-974-8464', 254);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (164, 'Shurwood Pryor', to_date('21-06-1990', 'dd-mm-yyyy'), '365-789-2400', 475);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (165, 'Maureen Dessaur', to_date('17-06-2007', 'dd-mm-yyyy'), '731-311-4139', 79);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (166, 'Freddy Rizzelli', to_date('26-04-2007', 'dd-mm-yyyy'), '492-918-1504', 175);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (167, 'Sibelle Fishlee', to_date('18-07-2009', 'dd-mm-yyyy'), '474-540-8850', 34);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (168, 'Fabien Marlow', to_date('06-06-2022', 'dd-mm-yyyy'), '332-967-2535', 465);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (169, 'Bronson Evers', to_date('15-03-2009', 'dd-mm-yyyy'), '289-314-6524', 5);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (170, 'Abagail Sealey', to_date('21-11-1994', 'dd-mm-yyyy'), '247-493-4433', 35);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (171, 'Kyrstin Thresher', to_date('20-03-1984', 'dd-mm-yyyy'), '341-136-4941', 126);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (172, 'Elisabeth Skates', to_date('27-02-2015', 'dd-mm-yyyy'), '276-826-4437', 494);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (173, 'Corinne Janks', to_date('28-06-2005', 'dd-mm-yyyy'), '103-731-8803', 82);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (174, 'Jammie Akehurst', to_date('08-08-1995', 'dd-mm-yyyy'), '700-833-4559', 88);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (175, 'Hollyanne Scothron', to_date('04-07-1956', 'dd-mm-yyyy'), '397-327-4495', 67);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (176, 'Sandor Kornousek', to_date('02-08-1978', 'dd-mm-yyyy'), '686-918-0379', 53);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (177, 'Patric Hum', to_date('11-07-1991', 'dd-mm-yyyy'), '401-364-0702', 401);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (178, 'Hube Bisp', to_date('21-10-2022', 'dd-mm-yyyy'), '117-324-7029', 363);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (179, 'Lenette Hiscoe', to_date('09-03-1953', 'dd-mm-yyyy'), '669-308-6227', 51);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (180, 'Yule Gummory', to_date('02-09-2015', 'dd-mm-yyyy'), '326-644-2531', 383);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (181, 'Eugine Veitch', to_date('13-10-1952', 'dd-mm-yyyy'), '822-729-6274', 400);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (182, 'Launce Kelbie', to_date('24-04-1989', 'dd-mm-yyyy'), '733-181-9785', 288);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (183, 'Sadie Bernade', to_date('16-12-1968', 'dd-mm-yyyy'), '143-978-6410', 175);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (184, 'Amie Alflatt', to_date('25-07-1969', 'dd-mm-yyyy'), '656-254-5386', 336);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (185, 'Diannne Domnick', to_date('26-12-1986', 'dd-mm-yyyy'), '878-797-6765', 241);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (186, 'Eli Chasteney', to_date('21-02-2009', 'dd-mm-yyyy'), '734-490-8769', 357);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (187, 'Bride Simonin', to_date('24-10-1988', 'dd-mm-yyyy'), '405-207-0276', 435);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (188, 'Corabel Pavie', to_date('23-08-1983', 'dd-mm-yyyy'), '195-549-3578', 116);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (189, 'Wyatt Tavener', to_date('27-01-1970', 'dd-mm-yyyy'), '396-400-8995', 196);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (190, 'Saraann Ullyatt', to_date('08-11-2018', 'dd-mm-yyyy'), '442-879-3851', 107);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (191, 'Ev Cummine', to_date('21-10-1973', 'dd-mm-yyyy'), '140-159-7372', 22);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (192, 'Vin Dyzart', to_date('27-06-1991', 'dd-mm-yyyy'), '693-748-6218', 112);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (193, 'Morena Heaker', to_date('01-09-2013', 'dd-mm-yyyy'), '553-842-8860', 233);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (194, 'Brnaby Tremmil', to_date('01-03-1971', 'dd-mm-yyyy'), '697-112-9353', 253);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (195, 'Obediah Hacking', to_date('24-01-2023', 'dd-mm-yyyy'), '221-359-4748', 181);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (196, 'Dix Burchard', to_date('23-03-2008', 'dd-mm-yyyy'), '171-969-0377', 145);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (197, 'Kristos Osgarby', to_date('17-09-1972', 'dd-mm-yyyy'), '200-296-2377', 490);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (198, 'Carroll Jacklings', to_date('08-11-1976', 'dd-mm-yyyy'), '337-801-4255', 425);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (199, 'Iver Denacamp', to_date('19-12-2009', 'dd-mm-yyyy'), '163-992-4259', 86);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (200, 'Odetta Clausner', to_date('30-09-1971', 'dd-mm-yyyy'), '132-981-7975', 246);
commit;
prompt 200 records committed...
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (201, 'Hi Adamovitz', to_date('05-12-1980', 'dd-mm-yyyy'), '359-524-1416', 436);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (202, 'Crysta Paddick', to_date('23-03-1951', 'dd-mm-yyyy'), '668-374-2051', 33);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (203, 'Artemis Silley', to_date('09-06-1994', 'dd-mm-yyyy'), '594-989-3616', 473);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (204, 'Hanny Sherme', to_date('31-05-2003', 'dd-mm-yyyy'), '790-156-6399', 285);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (205, 'Aurie Brouwer', to_date('21-10-1986', 'dd-mm-yyyy'), '735-229-9031', 97);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (206, 'Elizabeth Hydes', to_date('27-02-2022', 'dd-mm-yyyy'), '254-355-0530', 351);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (207, 'Suellen De Zuani', to_date('12-02-2004', 'dd-mm-yyyy'), '758-762-3154', 369);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (208, 'Edy Enoksson', to_date('04-01-1988', 'dd-mm-yyyy'), '244-562-2631', 390);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (209, 'Jemimah Shoobridge', to_date('28-11-1958', 'dd-mm-yyyy'), '167-327-4214', 348);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (210, 'Tabatha Blasio', to_date('28-12-2001', 'dd-mm-yyyy'), '825-177-6108', 53);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (211, 'Hedvige Ends', to_date('11-05-1964', 'dd-mm-yyyy'), '609-334-2719', 249);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (212, 'Patti Palfrie', to_date('02-02-2011', 'dd-mm-yyyy'), '468-441-3683', 162);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (213, 'Sasha Moan', to_date('01-02-1953', 'dd-mm-yyyy'), '215-268-0367', 85);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (214, 'Hugh Hinchshaw', to_date('12-02-1965', 'dd-mm-yyyy'), '674-182-4154', 192);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (215, 'Georgetta Trubshawe', to_date('13-01-1997', 'dd-mm-yyyy'), '809-732-7906', 125);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (216, 'Arleta Abbate', to_date('27-07-1989', 'dd-mm-yyyy'), '336-583-3419', 329);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (217, 'Jeffrey Brookzie', to_date('13-08-1953', 'dd-mm-yyyy'), '538-489-2032', 46);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (218, 'Michelle Arnefield', to_date('14-09-1982', 'dd-mm-yyyy'), '239-976-7239', 307);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (219, 'Carrol Huffer', to_date('25-12-1980', 'dd-mm-yyyy'), '425-132-1035', 103);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (220, 'Gayle Bicheno', to_date('17-02-1964', 'dd-mm-yyyy'), '554-895-2564', 267);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (221, 'Violetta Berrill', to_date('25-06-2016', 'dd-mm-yyyy'), '715-492-5722', 20);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (222, 'Alia Montacute', to_date('11-02-1975', 'dd-mm-yyyy'), '617-918-6095', 108);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (223, 'Fremont Rotlauf', to_date('31-08-1963', 'dd-mm-yyyy'), '305-541-6555', 2);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (224, 'Mathias Hymers', to_date('07-05-2019', 'dd-mm-yyyy'), '515-786-7634', 435);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (225, 'Atlante Cowburn', to_date('27-05-2007', 'dd-mm-yyyy'), '776-654-8171', 247);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (226, 'Konstanze Elford', to_date('22-12-2021', 'dd-mm-yyyy'), '654-382-5775', 440);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (227, 'Xever Damsell', to_date('03-11-1996', 'dd-mm-yyyy'), '804-708-2690', 256);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (228, 'Halley Trickey', to_date('11-12-1951', 'dd-mm-yyyy'), '910-472-3315', 405);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (229, 'Umeko Amori', to_date('26-10-1991', 'dd-mm-yyyy'), '180-328-7306', 25);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (230, 'Helge Bengefield', to_date('06-10-1961', 'dd-mm-yyyy'), '973-971-9945', 302);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (231, 'Boycey Skeemor', to_date('13-12-2023', 'dd-mm-yyyy'), '518-353-7554', 399);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (232, 'Melisandra Hazeldene', to_date('11-03-2016', 'dd-mm-yyyy'), '678-460-1776', 459);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (233, 'Eldon McCleverty', to_date('27-08-1982', 'dd-mm-yyyy'), '606-133-7484', 244);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (234, 'Piggy Baggs', to_date('30-09-1989', 'dd-mm-yyyy'), '697-738-8738', 232);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (235, 'Catlee Klimkovich', to_date('23-06-1973', 'dd-mm-yyyy'), '908-702-0132', 452);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (236, 'Valene Mardle', to_date('07-05-1962', 'dd-mm-yyyy'), '283-608-9535', 182);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (237, 'Moses Riccione', to_date('21-09-1974', 'dd-mm-yyyy'), '941-960-2379', 248);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (238, 'Oriana Putman', to_date('18-05-1974', 'dd-mm-yyyy'), '461-831-9006', 356);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (239, 'Esmaria Snalham', to_date('31-05-1964', 'dd-mm-yyyy'), '318-838-0880', 292);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (240, 'Randy Goering', to_date('07-05-2021', 'dd-mm-yyyy'), '217-132-0416', 63);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (241, 'Luis Gover', to_date('22-09-1951', 'dd-mm-yyyy'), '689-314-4916', 53);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (242, 'Corena Nezey', to_date('06-02-2004', 'dd-mm-yyyy'), '816-802-9233', 416);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (243, 'Nicolai de Merida', to_date('11-09-2021', 'dd-mm-yyyy'), '729-387-3718', 231);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (244, 'Lotte Birden', to_date('30-09-1984', 'dd-mm-yyyy'), '146-743-6245', 292);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (245, 'Chicky Shiel', to_date('05-12-2001', 'dd-mm-yyyy'), '466-849-1408', 41);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (246, 'Victoria Lebell', to_date('13-12-1976', 'dd-mm-yyyy'), '538-854-4611', 271);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (247, 'Janeen Joddins', to_date('29-10-1979', 'dd-mm-yyyy'), '433-419-3136', 349);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (248, 'Nady Readman', to_date('04-09-1964', 'dd-mm-yyyy'), '753-799-5989', 472);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (249, 'Winfred Fowlie', to_date('17-09-1988', 'dd-mm-yyyy'), '926-223-8071', 42);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (250, 'Hyacinthe Ruane', to_date('07-02-1994', 'dd-mm-yyyy'), '397-198-3999', 458);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (251, 'Reinaldos Geydon', to_date('16-04-1992', 'dd-mm-yyyy'), '581-713-8235', 270);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (252, 'Joshia Finci', to_date('21-03-2015', 'dd-mm-yyyy'), '813-906-5393', 314);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (253, 'Martha Chown', to_date('20-03-1963', 'dd-mm-yyyy'), '801-223-7852', 70);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (254, 'Arabele Ceci', to_date('22-03-1955', 'dd-mm-yyyy'), '621-154-2884', 295);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (255, 'Lesya Dorsey', to_date('13-04-1957', 'dd-mm-yyyy'), '619-869-8319', 13);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (256, 'Sherry Leasor', to_date('15-06-1978', 'dd-mm-yyyy'), '764-370-5951', 409);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (257, 'Guillema Cline', to_date('03-04-1998', 'dd-mm-yyyy'), '985-192-7574', 370);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (258, 'Sofie Laurenceau', to_date('19-06-1950', 'dd-mm-yyyy'), '864-160-3705', 313);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (259, 'Stinky Arni', to_date('04-07-1978', 'dd-mm-yyyy'), '143-118-3350', 304);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (260, 'Mitzi Peltz', to_date('18-08-1991', 'dd-mm-yyyy'), '312-885-2043', 167);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (261, 'Rance Maddocks', to_date('13-09-2014', 'dd-mm-yyyy'), '723-524-2119', 318);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (262, 'Lynda Donke', to_date('18-01-1960', 'dd-mm-yyyy'), '949-777-7886', 237);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (263, 'Jillian Comber', to_date('04-02-2015', 'dd-mm-yyyy'), '506-213-2233', 465);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (264, 'Claribel Hartman', to_date('14-04-1984', 'dd-mm-yyyy'), '135-737-7990', 314);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (265, 'Eimile Goggin', to_date('19-03-1956', 'dd-mm-yyyy'), '592-227-7376', 451);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (266, 'Mariquilla Jemison', to_date('07-05-1966', 'dd-mm-yyyy'), '481-767-5434', 120);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (267, 'Anny Isacsson', to_date('08-08-1970', 'dd-mm-yyyy'), '611-133-4278', 204);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (268, 'Clarie Mainland', to_date('01-06-1977', 'dd-mm-yyyy'), '304-946-5014', 97);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (269, 'Rubi McKirton', to_date('19-04-1993', 'dd-mm-yyyy'), '427-604-8987', 215);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (270, 'Meier Lukins', to_date('12-04-1964', 'dd-mm-yyyy'), '294-460-1058', 70);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (271, 'Buddy Peasegood', to_date('26-06-2009', 'dd-mm-yyyy'), '185-554-6315', 318);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (272, 'Ethe Airdrie', to_date('27-11-1970', 'dd-mm-yyyy'), '538-719-5614', 187);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (273, 'Kassey Burnsyde', to_date('27-07-1951', 'dd-mm-yyyy'), '243-737-2504', 484);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (274, 'Carlynn Pearde', to_date('10-10-1992', 'dd-mm-yyyy'), '131-940-3884', 168);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (275, 'Rachael Klejin', to_date('06-10-1985', 'dd-mm-yyyy'), '970-243-3643', 89);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (276, 'Hale David', to_date('26-11-1960', 'dd-mm-yyyy'), '304-798-0158', 318);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (277, 'Pattie Largent', to_date('15-06-2016', 'dd-mm-yyyy'), '214-437-7580', 18);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (278, 'Mar Cheeney', to_date('17-04-1962', 'dd-mm-yyyy'), '337-339-5709', 366);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (279, 'Vinny Jakubovski', to_date('16-01-1999', 'dd-mm-yyyy'), '722-837-1622', 375);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (280, 'Alistair Stranger', to_date('04-12-2008', 'dd-mm-yyyy'), '623-104-0774', 236);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (281, 'Lorrie McRonald', to_date('20-02-2007', 'dd-mm-yyyy'), '184-752-9695', 97);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (282, 'Jamima Vivyan', to_date('14-09-1958', 'dd-mm-yyyy'), '670-497-9891', 479);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (283, 'Keely Kiossel', to_date('07-02-1984', 'dd-mm-yyyy'), '898-602-1186', 208);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (284, 'Koressa Niblo', to_date('06-05-1980', 'dd-mm-yyyy'), '668-284-4300', 336);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (285, 'Tallia Cogle', to_date('08-09-2016', 'dd-mm-yyyy'), '456-309-2432', 223);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (286, 'Tymothy Dirkin', to_date('13-05-1977', 'dd-mm-yyyy'), '329-584-0563', 104);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (287, 'Erick Hovard', to_date('23-10-1963', 'dd-mm-yyyy'), '416-916-4227', 22);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (288, 'Wenda Haberjam', to_date('02-12-1957', 'dd-mm-yyyy'), '842-472-5659', 171);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (289, 'Blondelle Whittam', to_date('16-10-1996', 'dd-mm-yyyy'), '316-222-7286', 346);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (290, 'Debi Dyshart', to_date('01-09-1970', 'dd-mm-yyyy'), '651-436-9912', 248);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (291, 'Gabriela Herrieven', to_date('07-09-2004', 'dd-mm-yyyy'), '613-447-5873', 124);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (292, 'Clyve Simonin', to_date('15-08-1958', 'dd-mm-yyyy'), '672-604-3469', 377);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (293, 'Kaela Culleford', to_date('01-02-1979', 'dd-mm-yyyy'), '552-657-6833', 471);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (294, 'Eduard Alywen', to_date('13-02-1980', 'dd-mm-yyyy'), '609-299-9842', 276);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (295, 'Trueman Maun', to_date('12-04-1965', 'dd-mm-yyyy'), '918-648-7882', 364);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (296, 'Herc Crepin', to_date('30-01-1986', 'dd-mm-yyyy'), '209-732-8537', 88);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (297, 'Ailina McInnes', to_date('19-10-1975', 'dd-mm-yyyy'), '502-449-2306', 319);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (298, 'Dame Morffew', to_date('26-07-1972', 'dd-mm-yyyy'), '384-386-4995', 76);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (299, 'Rooney Guarnier', to_date('03-02-2005', 'dd-mm-yyyy'), '794-174-8242', 217);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (300, 'Lamont Vido', to_date('10-10-1980', 'dd-mm-yyyy'), '182-550-3585', 451);
commit;
prompt 300 records committed...
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (301, 'Catriona Sturzaker', to_date('09-03-1995', 'dd-mm-yyyy'), '549-576-9879', 97);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (302, 'Dickie Linger', to_date('03-06-1968', 'dd-mm-yyyy'), '527-271-3615', 423);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (303, 'Jorey Byass', to_date('15-10-1967', 'dd-mm-yyyy'), '860-534-2837', 161);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (304, 'Alfy Balcombe', to_date('21-03-1990', 'dd-mm-yyyy'), '102-287-3649', 211);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (305, 'Park Venneur', to_date('13-09-1970', 'dd-mm-yyyy'), '394-953-1230', 22);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (306, 'Freida Middlemiss', to_date('19-01-2006', 'dd-mm-yyyy'), '907-243-4049', 499);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (307, 'Germaine Scrowston', to_date('01-04-2002', 'dd-mm-yyyy'), '540-221-7321', 270);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (308, 'Derril Blackledge', to_date('11-03-1997', 'dd-mm-yyyy'), '418-392-6158', 192);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (309, 'Jonah Frentz', to_date('12-10-2018', 'dd-mm-yyyy'), '424-590-2653', 276);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (310, 'Tabby Myhill', to_date('02-03-2008', 'dd-mm-yyyy'), '365-844-7051', 492);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (311, 'Cindra Lattka', to_date('09-02-1981', 'dd-mm-yyyy'), '486-825-2768', 323);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (312, 'Ozzie Scholcroft', to_date('21-12-1967', 'dd-mm-yyyy'), '456-132-3077', 268);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (313, 'Wally Briston', to_date('02-03-1956', 'dd-mm-yyyy'), '350-723-0446', 443);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (314, 'Marielle Tuft', to_date('28-03-2014', 'dd-mm-yyyy'), '246-512-3727', 214);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (315, 'Ophelie Hegden', to_date('31-05-2008', 'dd-mm-yyyy'), '337-812-2081', 120);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (316, 'Bertrand Ledner', to_date('24-02-1973', 'dd-mm-yyyy'), '311-365-5179', 327);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (317, 'Tess Grose', to_date('26-02-1999', 'dd-mm-yyyy'), '204-361-4609', 103);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (318, 'Jessee Dunphie', to_date('17-01-2018', 'dd-mm-yyyy'), '600-898-5732', 263);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (319, 'Glori Stebbing', to_date('10-09-2017', 'dd-mm-yyyy'), '642-422-5745', 288);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (320, 'Gertie Kowalski', to_date('21-02-1972', 'dd-mm-yyyy'), '614-636-6225', 321);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (321, 'Leif Joskovitch', to_date('18-09-2015', 'dd-mm-yyyy'), '216-236-9137', 494);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (322, 'Waldon Bothwell', to_date('23-11-1958', 'dd-mm-yyyy'), '866-466-8155', 410);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (323, 'Gianina Whistance', to_date('30-03-2010', 'dd-mm-yyyy'), '493-389-9723', 445);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (324, 'Rosette Widmore', to_date('05-05-1996', 'dd-mm-yyyy'), '366-213-5837', 433);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (325, 'Garvy Savoury', to_date('05-11-1963', 'dd-mm-yyyy'), '489-102-7162', 485);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (326, 'Humberto Marfell', to_date('15-01-2022', 'dd-mm-yyyy'), '423-890-3940', 283);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (327, 'Gayle Sharplin', to_date('20-03-1992', 'dd-mm-yyyy'), '998-627-4797', 59);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (328, 'Brod Willcocks', to_date('04-01-1985', 'dd-mm-yyyy'), '864-126-8021', 162);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (329, 'Nerte Ast', to_date('23-11-1954', 'dd-mm-yyyy'), '493-930-3420', 145);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (330, 'Rollins Gerran', to_date('22-07-1977', 'dd-mm-yyyy'), '102-194-3220', 297);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (331, 'Irvin Camilleri', to_date('26-10-1987', 'dd-mm-yyyy'), '654-501-9474', 237);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (332, 'Lorri Melley', to_date('29-04-1963', 'dd-mm-yyyy'), '327-933-7272', 301);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (333, 'Arabel MacNess', to_date('21-01-1956', 'dd-mm-yyyy'), '796-496-3909', 237);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (334, 'Wilmette Cleveland', to_date('17-01-1979', 'dd-mm-yyyy'), '713-416-1034', 68);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (335, 'Hedvige Carlisso', to_date('10-12-2020', 'dd-mm-yyyy'), '245-581-8055', 93);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (336, 'Claudia McDowall', to_date('13-12-2000', 'dd-mm-yyyy'), '731-824-3083', 468);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (337, 'Verine Bramelt', to_date('12-04-1976', 'dd-mm-yyyy'), '222-352-6809', 411);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (338, 'Giavani Nystrom', to_date('23-11-1962', 'dd-mm-yyyy'), '221-919-2637', 162);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (339, 'Shellysheldon Levesque', to_date('27-06-1984', 'dd-mm-yyyy'), '521-572-3184', 401);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (340, 'Barrie Hadden', to_date('04-05-1970', 'dd-mm-yyyy'), '510-994-2441', 21);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (341, 'Urbano Thelwll', to_date('15-04-2022', 'dd-mm-yyyy'), '471-731-9546', 278);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (342, 'Filippo Landsbury', to_date('19-10-1983', 'dd-mm-yyyy'), '268-127-7621', 176);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (343, 'Wayne Trigg', to_date('04-05-1996', 'dd-mm-yyyy'), '726-816-2835', 119);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (344, 'Broddie Grimsdale', to_date('16-09-1988', 'dd-mm-yyyy'), '762-247-8799', 118);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (345, 'Loren O''Halligan', to_date('20-10-1956', 'dd-mm-yyyy'), '128-303-0449', 423);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (346, 'Hayden Detheridge', to_date('12-11-1960', 'dd-mm-yyyy'), '307-775-6122', 108);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (347, 'Lissy Hynes', to_date('29-03-1957', 'dd-mm-yyyy'), '485-589-6577', 179);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (348, 'Fannie Haskell', to_date('18-09-1987', 'dd-mm-yyyy'), '463-789-5400', 229);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (349, 'Patricia Rosie', to_date('07-07-1998', 'dd-mm-yyyy'), '138-361-8635', 179);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (350, 'Byrom Conahy', to_date('27-06-2023', 'dd-mm-yyyy'), '798-898-2405', 433);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (351, 'Gwendolyn Portch', to_date('24-06-2006', 'dd-mm-yyyy'), '414-534-9108', 8);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (352, 'Damon Belleny', to_date('18-07-2004', 'dd-mm-yyyy'), '704-223-6789', 383);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (353, 'Doretta Feragh', to_date('02-05-1955', 'dd-mm-yyyy'), '658-801-2358', 479);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (354, 'Bernelle Moorwood', to_date('16-01-1964', 'dd-mm-yyyy'), '310-186-6885', 332);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (355, 'Linzy Rickaby', to_date('18-09-1965', 'dd-mm-yyyy'), '778-573-0118', 166);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (356, 'Germain Hasson', to_date('28-02-1954', 'dd-mm-yyyy'), '642-896-1865', 301);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (357, 'Gaspard Ezzell', to_date('20-06-1993', 'dd-mm-yyyy'), '663-734-2888', 373);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (358, 'Teirtza Downing', to_date('16-11-1989', 'dd-mm-yyyy'), '820-705-3058', 425);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (359, 'Kinsley Antony', to_date('03-07-2007', 'dd-mm-yyyy'), '433-788-2236', 173);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (360, 'Adolpho Burdge', to_date('20-06-2023', 'dd-mm-yyyy'), '544-146-9611', 16);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (361, 'Ugo Newall', to_date('24-07-1973', 'dd-mm-yyyy'), '288-773-5420', 163);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (362, 'Rosetta Sends', to_date('06-10-1990', 'dd-mm-yyyy'), '903-275-3234', 313);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (363, 'Eloisa Heak', to_date('07-11-1990', 'dd-mm-yyyy'), '850-127-7395', 235);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (364, 'Luciana Ludgate', to_date('30-10-1977', 'dd-mm-yyyy'), '389-199-6562', 493);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (365, 'Mayor Lesmonde', to_date('21-03-1994', 'dd-mm-yyyy'), '612-489-6052', 247);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (366, 'King Ladlow', to_date('22-03-2013', 'dd-mm-yyyy'), '968-944-0033', 451);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (367, 'Sabrina Shaudfurth', to_date('02-04-2020', 'dd-mm-yyyy'), '705-577-8220', 233);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (368, 'Renelle Blacktin', to_date('22-12-2013', 'dd-mm-yyyy'), '678-306-0104', 374);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (369, 'Allen Reith', to_date('03-01-2010', 'dd-mm-yyyy'), '920-347-9304', 124);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (370, 'Tabatha Ludgate', to_date('21-06-1953', 'dd-mm-yyyy'), '634-963-5312', 298);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (371, 'Rozalie Ogger', to_date('12-09-1963', 'dd-mm-yyyy'), '974-791-9163', 63);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (372, 'Caitrin Wolverson', to_date('26-10-2021', 'dd-mm-yyyy'), '191-759-5566', 360);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (373, 'Hardy Rowlson', to_date('11-03-2008', 'dd-mm-yyyy'), '636-807-6523', 85);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (374, 'Agnese Janaszkiewicz', to_date('31-12-1959', 'dd-mm-yyyy'), '738-293-4505', 249);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (375, 'Lauralee Himpson', to_date('25-08-1966', 'dd-mm-yyyy'), '589-273-3566', 330);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (376, 'Stephen Norris', to_date('02-10-1951', 'dd-mm-yyyy'), '926-813-3098', 341);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (377, 'Yvon Prendergrast', to_date('13-06-1993', 'dd-mm-yyyy'), '616-393-3608', 262);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (378, 'Clyve Cruickshank', to_date('09-12-1974', 'dd-mm-yyyy'), '290-210-7463', 246);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (379, 'Juli Ronaghan', to_date('07-10-1968', 'dd-mm-yyyy'), '492-383-9102', 266);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (380, 'Lucienne Gerrietz', to_date('19-05-1978', 'dd-mm-yyyy'), '840-659-1065', 102);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (381, 'Elston Pauer', to_date('31-10-2005', 'dd-mm-yyyy'), '749-679-0654', 242);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (382, 'Erena Sheivels', to_date('03-01-1985', 'dd-mm-yyyy'), '369-852-0609', 28);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (383, 'Say Mordon', to_date('07-07-1981', 'dd-mm-yyyy'), '572-397-6601', 156);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (384, 'Rebekah Leinweber', to_date('15-05-1987', 'dd-mm-yyyy'), '352-962-9419', 40);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (385, 'Urbanus Harg', to_date('29-09-1960', 'dd-mm-yyyy'), '777-926-3378', 120);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (386, 'Hunter Harsum', to_date('22-05-1956', 'dd-mm-yyyy'), '762-720-4773', 104);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (387, 'Devora Stuchbery', to_date('23-01-1994', 'dd-mm-yyyy'), '336-389-5478', 276);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (388, 'Deina Laurencot', to_date('07-01-1981', 'dd-mm-yyyy'), '718-483-8962', 10);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (389, 'Austina St. Paul', to_date('13-02-1966', 'dd-mm-yyyy'), '152-148-6638', 370);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (390, 'Alexa Pacher', to_date('22-01-2020', 'dd-mm-yyyy'), '909-652-0217', 62);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (391, 'Garnet Burnip', to_date('26-06-1996', 'dd-mm-yyyy'), '161-328-2596', 349);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (392, 'Kimmie Reilingen', to_date('16-10-1971', 'dd-mm-yyyy'), '507-937-5114', 421);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (393, 'Juan Brendeke', to_date('23-07-2006', 'dd-mm-yyyy'), '311-204-2079', 395);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (394, 'Wolfie Chmarny', to_date('23-06-2002', 'dd-mm-yyyy'), '568-565-9032', 315);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (395, 'Astra MacCroary', to_date('12-06-1960', 'dd-mm-yyyy'), '621-181-3522', 89);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (396, 'Rocky Redpath', to_date('11-06-2005', 'dd-mm-yyyy'), '227-713-1813', 353);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (397, 'Kimberlyn Hourican', to_date('15-03-1977', 'dd-mm-yyyy'), '511-404-3093', 451);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (398, 'Padget Bulleyn', to_date('15-09-1953', 'dd-mm-yyyy'), '435-576-8127', 467);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (399, 'Camilla Manston', to_date('23-12-1983', 'dd-mm-yyyy'), '645-603-8353', 406);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (400, 'Violet Demanche', to_date('02-08-1994', 'dd-mm-yyyy'), '777-664-1917', 87);
commit;
prompt 400 records committed...
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (401, 'Napoleon Humberston', to_date('11-05-2008', 'dd-mm-yyyy'), '315-185-2719', 87);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (402, 'Rica Noirel', to_date('16-06-1977', 'dd-mm-yyyy'), '704-591-6242', 159);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (403, 'Olympe Zapatero', to_date('06-07-2004', 'dd-mm-yyyy'), '993-598-4177', 192);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (404, 'Joshua Louedey', to_date('25-02-1972', 'dd-mm-yyyy'), '566-276-6826', 371);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (405, 'Chrissy Gratrex', to_date('29-09-1970', 'dd-mm-yyyy'), '516-692-3850', 481);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (406, 'Carl Janus', to_date('16-07-1983', 'dd-mm-yyyy'), '336-675-9822', 191);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (407, 'Sybille Reinbach', to_date('25-09-1973', 'dd-mm-yyyy'), '507-963-7534', 35);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (408, 'Nissie Kegley', to_date('31-10-1971', 'dd-mm-yyyy'), '363-266-3448', 297);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (409, 'Jessie Lowbridge', to_date('11-03-1991', 'dd-mm-yyyy'), '866-777-8263', 94);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (410, 'Phaedra Maggs', to_date('25-12-1995', 'dd-mm-yyyy'), '485-365-4574', 421);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (411, 'Eleanor Geater', to_date('25-10-1999', 'dd-mm-yyyy'), '200-873-7612', 214);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (412, 'Gabriel Matteoli', to_date('22-09-1971', 'dd-mm-yyyy'), '922-839-6987', 242);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (413, 'Filmore Shewery', to_date('20-11-2010', 'dd-mm-yyyy'), '862-184-0946', 254);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (414, 'Kaile Roughley', to_date('19-09-1957', 'dd-mm-yyyy'), '635-730-4867', 245);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (415, 'Shana Lanning', to_date('19-04-1977', 'dd-mm-yyyy'), '939-918-2415', 423);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (416, 'Deeann Dugald', to_date('02-11-1999', 'dd-mm-yyyy'), '717-188-9041', 389);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (417, 'Gonzales Guilliatt', to_date('16-01-1995', 'dd-mm-yyyy'), '360-318-5299', 404);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (418, 'Jacquetta Abells', to_date('12-08-1956', 'dd-mm-yyyy'), '366-503-9051', 175);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (419, 'Clarke Roofe', to_date('26-01-1961', 'dd-mm-yyyy'), '202-116-1771', 400);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (420, 'Husein Millea', to_date('13-06-1970', 'dd-mm-yyyy'), '405-275-4014', 117);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (421, 'Elspeth Leyson', to_date('04-03-2008', 'dd-mm-yyyy'), '711-324-4277', 490);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (422, 'Bridget Rannie', to_date('16-06-2019', 'dd-mm-yyyy'), '133-504-6591', 296);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (423, 'Ulrich Earengey', to_date('14-11-1985', 'dd-mm-yyyy'), '863-372-0201', 462);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (424, 'Adena Orta', to_date('12-03-2005', 'dd-mm-yyyy'), '111-236-8427', 110);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (425, 'Cherise Watkinson', to_date('09-07-1992', 'dd-mm-yyyy'), '213-557-4648', 411);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (426, 'Garald Smeaton', to_date('16-09-1971', 'dd-mm-yyyy'), '619-226-6769', 366);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (427, 'Franciska Meese', to_date('22-03-1957', 'dd-mm-yyyy'), '917-193-8144', 376);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (428, 'Helen-elizabeth Draisey', to_date('08-03-2015', 'dd-mm-yyyy'), '855-536-2952', 45);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (429, 'Maddy Maddox', to_date('01-01-2003', 'dd-mm-yyyy'), '153-540-3809', 387);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (430, 'Aubrey Norker', to_date('08-06-1962', 'dd-mm-yyyy'), '539-966-7098', 229);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (431, 'Felipe Knoble', to_date('23-06-1981', 'dd-mm-yyyy'), '770-218-9917', 290);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (432, 'Owen Paulusch', to_date('20-01-2017', 'dd-mm-yyyy'), '875-583-4054', 481);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (433, 'Mozelle Meeus', to_date('27-09-1996', 'dd-mm-yyyy'), '593-616-3186', 459);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (434, 'Alysa Piatkowski', to_date('27-09-1966', 'dd-mm-yyyy'), '782-775-1861', 478);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (435, 'Alida Tigner', to_date('22-11-2010', 'dd-mm-yyyy'), '623-784-9754', 82);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (436, 'Lisabeth Argont', to_date('19-09-1984', 'dd-mm-yyyy'), '220-591-3763', 102);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (437, 'Karita Hirschmann', to_date('02-05-2000', 'dd-mm-yyyy'), '808-798-5895', 236);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (438, 'Mallory Dotterill', to_date('08-02-1961', 'dd-mm-yyyy'), '964-249-5682', 59);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (439, 'Tiffani Mintoft', to_date('06-05-1959', 'dd-mm-yyyy'), '134-830-1892', 404);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (440, 'Korry Antuoni', to_date('08-09-2013', 'dd-mm-yyyy'), '379-591-5497', 239);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (441, 'Heloise Akrigg', to_date('30-05-2020', 'dd-mm-yyyy'), '764-358-2951', 125);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (442, 'Morissa Couth', to_date('27-01-1997', 'dd-mm-yyyy'), '438-904-5089', 32);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (443, 'Mano Robers', to_date('22-08-1994', 'dd-mm-yyyy'), '223-925-7907', 385);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (444, 'Sherri Duesbury', to_date('14-04-1963', 'dd-mm-yyyy'), '426-763-9252', 77);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (445, 'Merrielle Burner', to_date('14-10-1985', 'dd-mm-yyyy'), '525-511-9345', 383);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (446, 'Fremont Reside', to_date('21-08-2021', 'dd-mm-yyyy'), '822-994-0758', 474);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (447, 'Aleece Reisin', to_date('04-02-1972', 'dd-mm-yyyy'), '633-512-9661', 476);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (448, 'Olly Florey', to_date('08-01-2023', 'dd-mm-yyyy'), '773-273-7915', 337);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (449, 'Marilin Sapsford', to_date('24-04-2023', 'dd-mm-yyyy'), '983-166-6113', 474);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (450, 'Carmelina Lerer', to_date('30-08-2007', 'dd-mm-yyyy'), '719-194-2101', 23);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (451, 'Astra Buncom', to_date('22-04-1974', 'dd-mm-yyyy'), '331-125-4562', 347);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (452, 'Garreth Fratczak', to_date('08-11-1970', 'dd-mm-yyyy'), '487-480-1083', 143);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (453, 'Mandi Kingswood', to_date('14-08-1959', 'dd-mm-yyyy'), '549-505-8179', 465);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (454, 'Nissa Lipman', to_date('15-07-1988', 'dd-mm-yyyy'), '643-754-7663', 6);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (455, 'Gerry Absalom', to_date('12-03-1986', 'dd-mm-yyyy'), '644-719-0760', 440);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (456, 'Chelsie Matuska', to_date('19-01-1981', 'dd-mm-yyyy'), '665-106-1813', 459);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (457, 'Blakeley Verrell', to_date('11-01-2008', 'dd-mm-yyyy'), '325-333-5066', 495);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (458, 'Margit Tigner', to_date('19-12-2008', 'dd-mm-yyyy'), '285-747-7971', 216);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (459, 'Fara Rowbrey', to_date('10-09-2000', 'dd-mm-yyyy'), '115-670-9206', 434);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (460, 'Stacee Wrack', to_date('12-09-1968', 'dd-mm-yyyy'), '435-962-7830', 253);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (461, 'Sylas Knevet', to_date('02-11-2007', 'dd-mm-yyyy'), '376-744-3088', 157);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (462, 'Emmery Gabe', to_date('28-10-1998', 'dd-mm-yyyy'), '976-408-5136', 50);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (463, 'Bili Skellern', to_date('27-12-2000', 'dd-mm-yyyy'), '194-832-6998', 262);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (464, 'Torie Rossi', to_date('21-06-1963', 'dd-mm-yyyy'), '978-732-8533', 404);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (465, 'Warren Jimmes', to_date('13-01-1970', 'dd-mm-yyyy'), '705-453-5647', 108);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (466, 'Jabez Wallsworth', to_date('24-03-1986', 'dd-mm-yyyy'), '581-913-2233', 385);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (467, 'Eloise Tierney', to_date('22-05-2014', 'dd-mm-yyyy'), '167-360-3606', 206);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (468, 'Ogden Clyant', to_date('03-05-1958', 'dd-mm-yyyy'), '481-591-4296', 205);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (469, 'Vina Higginbottam', to_date('24-06-2010', 'dd-mm-yyyy'), '610-956-2628', 361);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (470, 'Nedi Beart', to_date('11-06-1955', 'dd-mm-yyyy'), '826-380-4258', 441);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (471, 'Fransisco Grigorey', to_date('06-07-2017', 'dd-mm-yyyy'), '142-738-8527', 151);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (472, 'Mady Yendle', to_date('28-09-2021', 'dd-mm-yyyy'), '396-226-5168', 239);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (473, 'Dunn Jorden', to_date('06-12-1970', 'dd-mm-yyyy'), '616-231-2013', 271);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (474, 'Torrey Laugharne', to_date('20-01-1977', 'dd-mm-yyyy'), '691-136-1250', 397);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (475, 'Genvieve Burton', to_date('11-09-1974', 'dd-mm-yyyy'), '379-196-3028', 406);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (476, 'Stan Moyles', to_date('11-02-2009', 'dd-mm-yyyy'), '203-347-2316', 446);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (477, 'Whitman Dows', to_date('27-05-2001', 'dd-mm-yyyy'), '604-977-9312', 209);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (478, 'Baxie Tebbe', to_date('23-01-1993', 'dd-mm-yyyy'), '832-664-9729', 310);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (479, 'Meyer Curado', to_date('21-07-2007', 'dd-mm-yyyy'), '467-606-6252', 176);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (480, 'Damaris Broxap', to_date('15-11-1952', 'dd-mm-yyyy'), '552-772-1595', 53);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (481, 'Stevy Ablett', to_date('30-04-1979', 'dd-mm-yyyy'), '213-270-4363', 238);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (482, 'Everard Seadon', to_date('24-01-1975', 'dd-mm-yyyy'), '984-712-0632', 399);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (483, 'Mickie Bohden', to_date('04-04-1968', 'dd-mm-yyyy'), '673-902-6020', 240);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (484, 'Garvin Truin', to_date('16-03-2006', 'dd-mm-yyyy'), '636-189-0706', 405);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (485, 'Riane Allcorn', to_date('29-09-1983', 'dd-mm-yyyy'), '302-659-3080', 456);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (486, 'Myrilla Langtry', to_date('09-08-1967', 'dd-mm-yyyy'), '401-581-1307', 271);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (487, 'Margie Mc Mechan', to_date('25-07-2011', 'dd-mm-yyyy'), '887-899-6552', 482);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (488, 'Crysta D''Alwis', to_date('08-03-1957', 'dd-mm-yyyy'), '655-951-9261', 103);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (489, 'Kirbie Marklew', to_date('04-09-1987', 'dd-mm-yyyy'), '209-578-2068', 128);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (490, 'Benedetto Mora', to_date('23-01-1994', 'dd-mm-yyyy'), '568-760-1068', 105);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (491, 'Tessie Benaine', to_date('27-08-1957', 'dd-mm-yyyy'), '118-518-4444', 255);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (492, 'Hermione Pollington', to_date('05-03-1989', 'dd-mm-yyyy'), '125-477-6523', 192);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (493, 'Ruthi Raynham', to_date('29-05-2017', 'dd-mm-yyyy'), '706-826-0815', 58);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (494, 'Clary Guirard', to_date('12-11-1966', 'dd-mm-yyyy'), '127-186-6608', 38);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (495, 'Tracie Haulkham', to_date('29-05-1971', 'dd-mm-yyyy'), '332-709-4796', 449);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (496, 'Tom Sweating', to_date('27-04-1965', 'dd-mm-yyyy'), '153-483-7354', 54);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (497, 'Geri Catherine', to_date('16-03-1989', 'dd-mm-yyyy'), '757-712-5330', 460);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (498, 'Russell Studdal', to_date('22-05-1997', 'dd-mm-yyyy'), '817-527-3117', 253);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (499, 'Ellynn Quigg', to_date('10-04-1992', 'dd-mm-yyyy'), '678-988-5213', 73);
insert into PATIENT (patientid, name, dateofbirth, phone, roomid)
values (500, 'Mattie O''Dulchonta', to_date('12-10-1996', 'dd-mm-yyyy'), '685-661-6737', 407);
commit;
prompt 500 records loaded
prompt Loading TREATMENT...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (1, 'Alcoh dep NEC/NOS-unspec', 210, 350, to_date('21-04-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (2, 'Hemarthrosis-l/leg', 313, 197, to_date('17-12-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (3, 'Inf mcr rst qn flr nt ml', 113, 434, to_date('06-10-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (4, 'Cl skl fx NEC-proln coma', 422, 456, to_date('03-02-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (5, 'Spotting-delivered', 266, 377, to_date('11-05-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (6, 'Hemarthrosis-l/leg', 17, 386, to_date('12-11-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (7, 'Unsat cerv cytlogy smear', 378, 250, to_date('05-10-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (8, 'Myelitis cause NEC', 61, 73, to_date('28-04-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (9, 'Male genetc test dis car', 10, 328, to_date('02-10-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (10, 'NB intraven hem,grade ii', 10, 457, to_date('04-10-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (11, 'Abn react-procedure NOS', 387, 362, to_date('03-02-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (12, 'Mantle cell lymph multip', 136, 171, to_date('06-09-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (13, 'Bursal cyst NEC', 422, 253, to_date('13-12-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (14, 'Abdmnal mass rt upr quad', 473, 374, to_date('22-10-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (15, 'Toxic gastroenteritis', 132, 408, to_date('19-03-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (16, 'Erosion NOS', 130, 270, to_date('22-07-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (17, 'Screen-diabetes mellitus', 190, 232, to_date('08-11-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (18, 'Great vein anomaly NOS', 192, 91, to_date('15-07-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (19, 'Hx-prostatic malignancy', 277, 188, to_date('15-10-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (20, 'War injury:bullet NEC', 153, 242, to_date('26-08-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (21, 'Fx upper humerus NEC-opn', 466, 207, to_date('24-06-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (22, 'Screen neop-nervous syst', 313, 11, to_date('20-06-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (23, 'Trichomonal prostatitis', 174, 203, to_date('03-02-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (24, 'Poisoning-tetanus vaccin', 320, 346, to_date('26-06-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (25, 'Foreign body anus/rectum', 86, 21, to_date('13-10-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (26, 'Chondromalacia patellae', 275, 210, to_date('09-05-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (27, 'Venous tributary occlus', 405, 109, to_date('11-12-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (28, 'Yoga', 405, 88, to_date('01-11-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (29, 'Cornea transplant status', 33, 497, to_date('17-01-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (30, 'Edema in preg-unspec', 106, 71, to_date('23-06-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (31, 'Dis calcium metablsm NEC', 273, 474, to_date('05-04-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (32, 'Sec DM hpros nt st uncnr', 285, 108, to_date('27-11-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (33, 'Activity NEC', 422, 446, to_date('12-08-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (34, 'Obstr eustach tube NOS', 430, 485, to_date('08-04-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (35, 'Schistosoma mansoni', 126, 494, to_date('10-05-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (36, 'Mycobacterial dis NEC', 382, 35, to_date('13-02-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (37, 'Opn skul fx NEC-coma NOS', 186, 272, to_date('09-07-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (38, 'Renal failure NOS', 167, 221, to_date('24-05-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (39, 'Placenta previa-deliver', 104, 382, to_date('06-01-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (40, 'Abdmnal mass rt upr quad', 166, 235, to_date('26-12-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (41, 'Spinal muscl atrophy NEC', 395, 351, to_date('21-09-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (42, 'Chr pulmonary embolism', 46, 465, to_date('08-09-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (43, 'Lordosis NOS', 481, 312, to_date('06-03-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (44, 'Straining on urination', 18, 404, to_date('25-10-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (45, 'Ophthalmia nodosa', 383, 133, to_date('06-09-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (46, 'Neonatal neutropenia', 294, 194, to_date('06-11-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (47, 'Toxoplasma pneumonitis', 62, 376, to_date('16-02-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (48, 'Equatorial staphyloma', 218, 70, to_date('14-09-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (49, 'Ab mammogram NOS', 453, 377, to_date('26-10-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (50, 'Diplegia of upper limbs', 186, 145, to_date('04-09-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (51, 'Superfic foreign bdy NEC', 292, 56, to_date('13-12-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (52, 'Mal neo lymph-intrapelv', 432, 30, to_date('20-03-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (53, 'Jt derangement NEC-mult', 9, 362, to_date('22-07-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (54, 'Battering by child', 369, 239, to_date('02-07-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (55, 'Mental problems NEC', 115, 172, to_date('22-03-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (56, 'Sparganosis', 349, 129, to_date('13-11-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (57, 'Toxic effect cadmium', 70, 257, to_date('22-04-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (58, 'Deep 3rd deg burn foot', 193, 431, to_date('18-03-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (59, 'Epidem hem conjunctivit', 156, 178, to_date('07-11-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (60, 'Multiple sclerosis', 400, 380, to_date('20-03-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (61, 'Esotropia NOS', 238, 74, to_date('14-11-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (62, 'Crys arthrop NOS-forearm', 475, 422, to_date('01-07-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (63, 'Myelitis cause NEC', 15, 305, to_date('08-01-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (64, 'Hx pathological fracture', 197, 285, to_date('04-05-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (65, 'Strep sore throat', 120, 468, to_date('19-01-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (66, 'TB brain abscess-cult dx', 262, 414, to_date('08-04-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (67, 'Uterine endometriosis', 399, 77, to_date('11-03-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (68, 'Acc d/t storm/flood NOS', 343, 113, to_date('26-11-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (69, 'Glaucomatous flecks', 419, 475, to_date('01-05-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (70, 'Opn skul fx NEC-coma NOS', 213, 61, to_date('16-02-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (71, 'Fx tibia NOS-open', 282, 425, to_date('10-03-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (72, 'Asympt varicose veins', 485, 499, to_date('23-10-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (73, 'Second iritis, noninfec', 393, 362, to_date('23-02-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (74, 'Meningococcemia', 249, 310, to_date('24-03-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (75, 'Prune belly syndrome', 112, 32, to_date('11-03-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (76, 'Anomalous av excitation', 232, 125, to_date('22-04-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (77, 'Asympt varicose veins', 76, 386, to_date('23-09-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (78, 'Late eff nerve inj NEC', 284, 92, to_date('10-12-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (79, 'Injury ovarian artery', 483, 15, to_date('08-05-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (80, 'Gastrostomy comp - mech', 466, 229, to_date('19-01-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (81, 'Contusion of upper arm', 440, 255, to_date('26-03-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (82, 'Breast dis NEC-del w p/p', 42, 255, to_date('14-09-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (83, 'Screen-iron defic anemia', 159, 223, to_date('19-11-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (84, 'Pap smear cervix w HGSIL', 98, 99, to_date('08-07-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (85, 'Anomalous av excitation', 209, 149, to_date('01-03-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (86, 'Complete edentulism NOS', 101, 118, to_date('07-09-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (87, 'Vaccination for Td-DT', 487, 92, to_date('16-02-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (88, 'Malfun neuro device/graf', 91, 351, to_date('05-01-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (89, 'Disorders of eyelid NEC', 331, 178, to_date('22-04-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (90, 'Disorders of eyelid NEC', 275, 58, to_date('12-04-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (91, 'Cl skull fx NEC w/o coma', 202, 400, to_date('19-04-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (92, 'Salivary gland atrophy', 233, 230, to_date('15-10-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (93, 'TB of ureter-micro dx', 237, 300, to_date('10-07-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (94, 'Cardiac arrest', 428, 498, to_date('24-12-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (95, 'Mal neo lymph-intrapelv', 60, 382, to_date('18-06-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (96, 'Abn react-procedure NOS', 153, 414, to_date('22-02-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (97, 'Joint symptom NEC-hand', 389, 48, to_date('26-11-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (98, 'Injury trunk nerve NOS', 314, 484, to_date('02-08-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (99, 'Unc behav neo testis', 245, 74, to_date('11-12-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (100, 'Epidem hem conjunctivit', 228, 444, to_date('19-12-2021', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (101, 'Trichomonal prostatitis', 315, 100, to_date('12-06-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (102, 'Lacrimal syst dis NEC', 342, 272, to_date('16-01-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (103, 'Toxic gastroenteritis', 334, 54, to_date('08-08-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (104, 'Exudat cyst pars plana', 432, 142, to_date('16-08-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (105, 'Mech loosening pros jt', 255, 63, to_date('27-07-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (106, 'Family dsrpt-estrangmemt', 81, 335, to_date('26-11-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (107, 'C1-c4 spin cord inj NOS', 104, 71, to_date('18-05-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (108, 'Jt derangement NEC-mult', 18, 262, to_date('10-02-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (109, 'Burning bedclothes', 58, 174, to_date('14-10-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (110, 'Rhinosporidiosis', 380, 24, to_date('23-01-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (111, 'Second iritis, noninfec', 13, 17, to_date('03-01-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (112, 'Pap smear cervix w HGSIL', 216, 413, to_date('18-09-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (113, 'Pyoderma NEC', 33, 400, to_date('13-01-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (114, 'Alcohol mental disor NOS', 86, 114, to_date('16-07-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (115, 'Lacrimal fistula', 192, 399, to_date('20-01-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (116, 'Trypanosomiasis NOS', 77, 481, to_date('19-04-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (117, 'Acute otitis externa NEC', 372, 206, to_date('26-04-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (118, 'Inj mlt head/neck vessel', 288, 210, to_date('03-12-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (119, 'Fracture six ribs-closed', 336, 4, to_date('18-02-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (120, 'Heat edema', 316, 361, to_date('27-09-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (121, 'Ocl mlt bi art w infrct', 150, 85, to_date('27-02-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (122, 'Poison-fibrinolysis agnt', 493, 433, to_date('06-04-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (123, 'Mening in oth fungal dis', 428, 478, to_date('26-05-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (124, 'Cardiorespirat probl NEC', 134, 148, to_date('23-10-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (125, 'Ac rheumatic myocarditis', 45, 418, to_date('17-03-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (126, 'Psychogenic disorder NEC', 226, 191, to_date('04-05-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (127, 'Auditory recruitment', 453, 31, to_date('02-01-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (128, 'Pectus carinatum', 58, 153, to_date('17-12-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (129, 'Iatrogen CV infarc/hmrhg', 387, 50, to_date('08-06-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (130, 'Mening in oth fungal dis', 31, 133, to_date('27-10-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (131, 'Ob pyemic embol-postpart', 375, 342, to_date('23-04-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (132, 'Psychogenic gu dis NOS', 497, 294, to_date('10-04-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (133, 'Psychogenic gu dis NOS', 67, 188, to_date('06-12-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (134, 'Pelv deform NOS-antepart', 438, 339, to_date('26-04-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (135, 'Gross hematuria', 460, 27, to_date('23-02-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (136, 'Open wound of ear NOS', 73, 156, to_date('05-12-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (137, 'Eustachian tube dis NEC', 440, 302, to_date('11-09-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (138, 'Cl skul base fx-mod coma', 85, 61, to_date('14-01-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (139, 'Ocl art NOS w infrct', 220, 16, to_date('17-11-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (140, 'Second iritis, noninfec', 326, 233, to_date('02-06-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (141, 'Juv osteochondros spine', 452, 359, to_date('23-06-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (142, 'Unsp ds conjuc viruses', 358, 307, to_date('16-06-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (143, 'Malposition NEC-antepart', 285, 273, to_date('05-02-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (144, 'Abn amnion NEC aff NB', 293, 4, to_date('28-11-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (145, 'C1-c4 fx-op/cen cord syn', 353, 321, to_date('18-07-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (146, 'Loose body-forearm', 424, 110, to_date('12-01-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (147, 'Pyoderma NEC', 453, 323, to_date('22-10-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (148, 'Late eff nerve inj NEC', 73, 335, to_date('02-08-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (149, 'Prim TB pleur-exam unkn', 283, 479, to_date('09-06-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (150, 'Cerebral hem at birth', 449, 235, to_date('10-02-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (151, 'Breast prosth malfunc', 396, 241, to_date('26-03-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (152, 'Pyoderma NEC', 80, 491, to_date('23-10-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (153, 'Compl lab/deliv NEC-unsp', 207, 66, to_date('22-05-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (154, 'TB of ureter-micro dx', 99, 307, to_date('14-09-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (155, 'Neonatal neutropenia', 2, 250, to_date('20-04-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (156, 'Underweight', 305, 298, to_date('11-03-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (157, 'Face/brow present-unspec', 99, 69, to_date('02-05-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (158, 'Vaccination for Td-DT', 108, 445, to_date('16-12-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (159, 'Trypanosomiasis NOS', 28, 485, to_date('01-04-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (160, 'Stat obj w sub fall NEC', 408, 247, to_date('09-06-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (161, 'Cord prolapse-antepartum', 187, 120, to_date('28-01-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (162, 'Quadrplg c1-c4, complete', 172, 36, to_date('19-12-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (163, 'Twin gest-dich/diamniotc', 97, 299, to_date('18-10-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (164, 'Comp lab/deliv NEC-deliv', 49, 432, to_date('08-02-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (165, 'Thoracoabd aortc ectasia', 258, 256, to_date('02-07-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (166, 'Mal neo lymph-intrapelv', 379, 190, to_date('11-05-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (167, 'Essen hyperten-delivered', 312, 21, to_date('09-01-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (168, 'Comp lab/deliv NEC-deliv', 311, 413, to_date('25-06-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (169, 'Cough variant asthma', 437, 58, to_date('07-02-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (170, 'Mal neo descend colon', 422, 55, to_date('14-11-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (171, 'Cl skl w oth fx-mod coma', 74, 46, to_date('02-02-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (172, 'Acc poison-shellfish', 402, 15, to_date('23-03-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (173, 'Erosion NOS', 362, 86, to_date('24-11-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (174, 'Cl skul base fx-mod coma', 26, 303, to_date('18-01-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (175, 'Idiopth lym interst pneu', 32, 489, to_date('12-07-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (176, 'Heat effect NOS', 443, 9, to_date('10-11-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (177, 'Hemarthrosis-l/leg', 296, 342, to_date('24-11-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (178, 'Chr angle-clos glaucoma', 430, 67, to_date('28-04-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (179, 'Other pulmonary insuff', 346, 323, to_date('28-02-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (180, 'Periostitis-unspec', 291, 219, to_date('03-04-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (181, 'Nephritis NOS', 256, 250, to_date('19-09-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (182, 'Varic vein leg-postpart', 493, 342, to_date('18-02-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (183, 'Ac DVT/embl up ext', 292, 472, to_date('14-09-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (184, 'Sezarys disease inguin', 203, 270, to_date('17-08-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (185, 'Abn pelv tis obstr-antep', 409, 210, to_date('21-07-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (186, 'Eustachian tube dis NEC', 232, 334, to_date('12-10-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (187, 'Fire in bldg-fumes NOS', 407, 154, to_date('08-06-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (188, 'GI injury NEC-open', 140, 171, to_date('06-02-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (189, 'Drug psy dis w hallucin', 4, 267, to_date('07-08-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (190, 'Edema in preg-delivered', 121, 164, to_date('02-10-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (191, 'Helminth arthrit-forearm', 113, 48, to_date('04-12-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (192, 'Hereditary spherocytosis', 309, 256, to_date('09-12-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (193, 'Vestibular neuronitis', 319, 266, to_date('15-09-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (194, 'Acc poisn-tranquilzr NOS', 91, 176, to_date('22-07-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (195, 'Poison-vasodilator NEC', 185, 48, to_date('10-05-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (196, 'Lichen nitidus', 268, 24, to_date('16-06-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (197, 'Malignant neo larynx NEC', 342, 449, to_date('13-06-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (198, 'Disorders of eyelid NEC', 149, 275, to_date('22-02-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (199, 'Second iritis, noninfec', 264, 377, to_date('04-06-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (200, 'Shigella infection NEC', 218, 351, to_date('12-05-2021', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (201, 'Dermatophyt scalp/beard', 401, 225, to_date('07-06-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (202, 'Acq pyloric stenosis', 222, 203, to_date('09-04-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (203, 'Idiopth lym interst pneu', 210, 110, to_date('20-02-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (204, 'Sprain rotator cuff', 483, 287, to_date('18-02-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (205, 'Foreign body anus/rectum', 492, 374, to_date('12-02-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (206, 'TB of kidney-exam unkn', 93, 381, to_date('10-09-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (207, 'Unil femoral hern w gang', 273, 295, to_date('16-08-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (208, 'Subendo infarct, initial', 131, 162, to_date('25-10-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (209, 'Sleep apnea NOS', 467, 103, to_date('11-09-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (210, 'Traffic acc NOS-driver', 482, 285, to_date('04-11-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (211, 'Hereditary spherocytosis', 421, 492, to_date('28-09-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (212, 'Trigeminal neuralgia', 110, 242, to_date('13-11-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (213, 'Hemangioma intracranial', 282, 428, to_date('26-02-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (214, 'Toxic effect cadmium', 94, 480, to_date('12-06-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (215, 'Crushing injury foot', 201, 233, to_date('14-06-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (216, 'Streptobacillary fever', 65, 45, to_date('23-07-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (217, 'Orchitis in oth disease', 92, 407, to_date('25-01-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (218, 'Unc behav neo testis', 88, 83, to_date('05-09-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (219, 'Twin gest-dich/diamniotc', 132, 293, to_date('20-01-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (220, 'Cl skl fx NEC-proln coma', 396, 465, to_date('03-12-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (221, 'Injury trunk nerve NOS', 159, 350, to_date('21-11-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (222, 'Cong anom of aorta NOS', 21, 218, to_date('16-02-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (223, 'Cumltv trma-repetv impct', 164, 305, to_date('14-02-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (224, 'Opn skl/oth fx-deep coma', 410, 498, to_date('20-05-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (225, 'Juv osteochondros spine', 324, 485, to_date('11-08-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (226, 'Sprain rotator cuff', 304, 205, to_date('09-04-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (227, 'Malfun neuro device/graf', 435, 360, to_date('02-02-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (228, 'Acc pois-solid/liq NEC', 62, 224, to_date('15-08-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (229, 'Toxoplasmosis site NEC', 309, 377, to_date('28-05-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (230, 'Second iritis, noninfec', 323, 90, to_date('08-04-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (231, 'Yoga', 449, 179, to_date('23-02-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (232, 'Alcoh dep NEC/NOS-unspec', 423, 127, to_date('27-02-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (233, 'Coccidioidomycosis NOS', 145, 164, to_date('16-05-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (234, 'Craniorachischisis', 223, 225, to_date('21-09-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (235, 'Unsat cerv cytlogy smear', 66, 213, to_date('25-01-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (236, 'Hereditary spherocytosis', 195, 425, to_date('07-05-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (237, 'Acc d/t storm/flood NOS', 411, 235, to_date('03-01-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (238, 'Eustachian tube dis NEC', 147, 330, to_date('16-02-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (239, 'Clothing fire-bldg NEC', 10, 55, to_date('02-09-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (240, 'Keratoconjunctivitis NOS', 308, 312, to_date('07-06-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (241, 'Poisoning-tetanus vaccin', 429, 366, to_date('02-04-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (242, '1st deg burn head NOS', 146, 295, to_date('06-04-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (243, 'Margin zone lym head', 11, 315, to_date('18-05-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (244, 'Instrmnt fail in surgery', 253, 116, to_date('10-12-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (245, 'Mycobacterial dis NEC', 123, 185, to_date('07-03-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (246, 'Dysplasia of cervix NOS', 416, 396, to_date('16-06-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (247, 'Bursal cyst NEC', 70, 325, to_date('04-01-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (248, 'Equatorial staphyloma', 78, 421, to_date('10-03-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (249, 'Pyoderma NEC', 238, 63, to_date('14-03-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (250, 'Placenta previa-deliver', 363, 262, to_date('11-03-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (251, 'Ocl art NOS w infrct', 73, 58, to_date('13-12-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (252, 'Second hypertension NEC', 9, 295, to_date('13-06-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (253, 'Fx base femoral nck-open', 499, 187, to_date('05-01-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (254, 'Blood vessel injury NOS', 432, 218, to_date('27-08-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (255, 'Explosive personality', 118, 300, to_date('13-05-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (256, 'Cardiac arrest', 292, 151, to_date('28-04-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (257, 'Spotting-delivered', 270, 149, to_date('23-08-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (258, 'Deep vein thromb-antepar', 427, 14, to_date('03-09-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (259, 'DMII ophth uncntrld', 99, 410, to_date('25-06-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (260, 'Oth off-road mv-st car', 44, 473, to_date('18-08-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (261, 'Yoga', 453, 477, to_date('10-03-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (262, 'Psychogenic disorder NEC', 4, 266, to_date('08-11-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (263, 'Essen hyperten-delivered', 179, 229, to_date('08-08-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (264, 'Spotting-delivered', 311, 460, to_date('20-09-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (265, 'Cl skul base fx-mod coma', 363, 423, to_date('22-09-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (266, 'Stat obj w sub fall NEC', 233, 310, to_date('08-10-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (267, 'Cerebral hem at birth', 153, 374, to_date('05-08-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (268, 'Nonpsychot brain syn NOS', 347, 243, to_date('06-04-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (269, 'Battering by child', 399, 171, to_date('03-09-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (270, 'Gastrostomy comp - mech', 406, 427, to_date('23-12-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (271, 'Screen-iron defic anemia', 411, 244, to_date('25-04-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (272, 'Abn chromosomal analysis', 10, 252, to_date('17-11-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (273, 'Gouty tophi of ear', 462, 175, to_date('08-08-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (274, 'RR acc w derail-employee', 247, 105, to_date('21-03-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (275, 'Placent polyp-del w p/p', 62, 432, to_date('20-03-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (276, 'Inj int mammary art/vein', 494, 14, to_date('19-01-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (277, 'Opn skl/oth fx-deep coma', 379, 256, to_date('14-02-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (278, 'Cutan leishmanias asian', 204, 390, to_date('01-07-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (279, 'Bacteria dis carrier NEC', 166, 139, to_date('06-11-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (280, 'Brach plexus inj-birth', 232, 106, to_date('05-03-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (281, 'Screen-iron defic anemia', 266, 484, to_date('07-06-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (282, 'Surgical convalescence', 220, 160, to_date('22-10-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (283, 'Toxic effect cadmium', 335, 314, to_date('06-09-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (284, 'Hemangioma intracranial', 219, 137, to_date('24-09-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (285, 'Acq hemolytic anemia NOS', 392, 262, to_date('19-02-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (286, 'Pectus carinatum', 488, 345, to_date('14-01-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (287, 'Isolated explosive dis', 149, 430, to_date('06-01-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (288, 'Paral polio NEC-type 1', 240, 50, to_date('04-10-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (289, 'Externl cause status NEC', 124, 389, to_date('05-09-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (290, 'Other pulmonary insuff', 167, 345, to_date('07-03-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (291, 'Acc poison-soap products', 409, 187, to_date('02-12-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (292, 'Pois-sedative/hypnot NEC', 302, 101, to_date('25-11-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (293, 'Sezarys disease inguin', 37, 397, to_date('08-11-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (294, 'Acc poison-shellfish', 392, 370, to_date('06-03-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (295, 'Sprain of foot NEC', 293, 340, to_date('05-05-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (296, 'Prim angle clos w/o dmg', 358, 181, to_date('24-06-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (297, 'Screen-diabetes mellitus', 114, 149, to_date('21-10-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (298, 'Diseases of nail NEC', 344, 207, to_date('12-03-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (299, 'Pyoderma NEC', 422, 374, to_date('08-04-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (300, 'Acc d/t storm/flood NOS', 479, 500, to_date('13-01-2004', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (301, 'Hx-hodgkins disease', 272, 235, to_date('06-06-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (302, 'Dysplasia of cervix NOS', 104, 93, to_date('12-06-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (303, 'Abn auditory percept NOS', 52, 230, to_date('09-07-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (304, 'Varicella complicat NOS', 366, 382, to_date('09-10-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (305, 'Deep vein thromb-antepar', 318, 210, to_date('13-04-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (306, 'Mv coll w ped-ped cycl', 232, 387, to_date('24-05-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (307, 'Inflam/tox neuropthy NOS', 4, 120, to_date('11-03-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (308, 'Orchitis in oth disease', 107, 174, to_date('02-09-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (309, 'Unstable lie-delivered', 78, 347, to_date('20-06-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (310, 'Cornea transplant status', 369, 23, to_date('04-03-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (311, 'Lacrimal fistula', 175, 243, to_date('11-02-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (312, 'Vac-dis combinations NOS', 51, 447, to_date('17-02-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (313, 'Hx-prostatic malignancy', 236, 141, to_date('17-02-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (314, 'Hemarthrosis-l/leg', 422, 114, to_date('20-02-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (315, 'Opn skl/oth fx-deep coma', 10, 481, to_date('07-08-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (316, 'Benign hyp ht dis w hf', 297, 166, to_date('22-05-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (317, 'Lt-date w/mal 1500-1749g', 369, 231, to_date('08-01-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (318, 'Obstr eustach tube NOS', 157, 151, to_date('12-12-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (319, 'Diplegia of upper limbs', 78, 495, to_date('17-06-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (320, 'Heat effect NOS', 280, 478, to_date('13-05-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (321, 'NB intraven hem NOS', 6, 84, to_date('25-05-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (322, 'Acute respiratry failure', 443, 140, to_date('05-06-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (323, 'Abdmnal mass rt upr quad', 397, 265, to_date('11-03-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (324, 'Contusion of upper arm', 32, 475, to_date('24-07-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (325, 'Oth spcf hypoglycemia', 219, 391, to_date('24-04-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (326, '2nd deg burn abdomn wall', 254, 358, to_date('15-04-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (327, 'Abn pelv tis obstr-antep', 301, 63, to_date('14-12-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (328, 'Alcoh dep NEC/NOS-unspec', 392, 4, to_date('03-11-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (329, 'Injury oculomotor nerve', 32, 87, to_date('03-10-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (330, 'Stat obj w sub fall NEC', 234, 252, to_date('20-03-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (331, 'Alcohol mental disor NOS', 499, 29, to_date('19-09-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (332, 'Spinal muscl atrophy NEC', 62, 149, to_date('18-12-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (333, 'Chr uterine subinvolutn', 228, 170, to_date('25-02-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (334, 'Tox eff lead compnd NOS', 88, 207, to_date('21-10-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (335, 'Shyness disorder-child', 396, 347, to_date('17-09-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (336, 'Cl lumbar fx w cord inj', 382, 144, to_date('20-07-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (337, 'RR acc w derail-pedest', 141, 172, to_date('16-01-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (338, 'Dis mitochondrial metab', 184, 128, to_date('08-05-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (339, 'Polio osteopathy-hand', 72, 484, to_date('01-11-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (340, 'Acute respiratry failure', 306, 280, to_date('06-08-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (341, 'Ab mammogram NOS', 22, 180, to_date('12-12-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (342, 'Derang lat meniscus NOS', 358, 5, to_date('01-07-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (343, 'Eustachian tube dis NEC', 462, 63, to_date('13-08-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (344, 'Toxic shock syndrome', 114, 246, to_date('10-01-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (345, 'Sezarys disease inguin', 172, 28, to_date('03-09-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (346, 'Hodg nodul sclero mult', 456, 32, to_date('13-04-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (347, 'Inj nerve pelv/leg NOS', 450, 496, to_date('01-04-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (348, 'Trypanosomiasis NOS', 480, 485, to_date('13-11-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (349, 'Hx-malig skin melanoma', 162, 160, to_date('03-03-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (350, 'Abdmnal mass rt upr quad', 55, 285, to_date('09-12-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (351, 'Gonorrhea-delivered', 203, 127, to_date('27-05-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (352, 'Histoplasmosis NOS', 119, 257, to_date('11-09-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (353, 'Common truncus', 146, 45, to_date('01-02-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (354, 'Subarach hem-brief coma', 328, 493, to_date('16-09-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (355, 'Affectiv personality NOS', 149, 136, to_date('13-03-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (356, 'Siderosis', 495, 319, to_date('23-04-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (357, 'Schistosoma mansoni', 422, 74, to_date('10-02-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (358, 'Unsp ds conjuc viruses', 272, 212, to_date('28-05-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (359, 'Essen hyperten-delivered', 382, 87, to_date('19-04-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (360, 'Benign hyp ht dis w hf', 230, 377, to_date('25-01-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (361, 'Malignant neo larynx NEC', 225, 231, to_date('11-03-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (362, 'Acute respiratry failure', 401, 489, to_date('28-01-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (363, 'Abdmnal mass rt upr quad', 458, 293, to_date('27-04-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (364, 'Crushing injury foot', 190, 393, to_date('05-03-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (365, 'Open wound of foot', 408, 231, to_date('12-08-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (366, 'Acquired hemophilia', 227, 320, to_date('09-05-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (367, 'Esotropia NOS', 58, 295, to_date('03-07-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (368, 'Affectiv personality NOS', 4, 79, to_date('07-12-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (369, 'Ob pyemic embol-postpart', 497, 128, to_date('24-11-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (370, 'Rhinosporidiosis', 205, 59, to_date('26-02-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (371, 'Fx tibia NOS-open', 190, 71, to_date('23-10-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (372, 'Chondromalacia patellae', 466, 211, to_date('07-06-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (373, 'Sparganosis', 171, 399, to_date('07-02-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (374, 'Inf mcr rst qn flr nt ml', 225, 64, to_date('21-01-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (375, 'Gonorrhea-delivered', 416, 261, to_date('19-10-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (376, 'Crbl art ocl NOS w infrc', 216, 366, to_date('19-01-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (377, 'Injury trunk nerve NOS', 283, 17, to_date('16-09-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (378, '3rd brn w loss-head mult', 262, 437, to_date('26-08-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (379, 'Activity NEC', 411, 402, to_date('07-12-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (380, 'Takayasus disease', 144, 356, to_date('06-04-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (381, 'Meningococcal meningitis', 192, 338, to_date('13-08-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (382, 'Acc poison-soap products', 454, 149, to_date('23-04-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (383, 'Ac embolism veins NEC', 137, 144, to_date('03-10-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (384, 'Crys arthrop NOS-forearm', 484, 75, to_date('16-06-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (385, 'Screen neop-nervous syst', 491, 374, to_date('12-07-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (386, 'Dysplasia of cervix NOS', 190, 409, to_date('09-04-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (387, 'Pelv deform NOS-antepart', 92, 258, to_date('17-03-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (388, 'Mv board/alight-pers NEC', 59, 62, to_date('23-11-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (389, 'Malig neuroendo ca NOS', 459, 396, to_date('10-07-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (390, 'Face/brow present-unspec', 81, 97, to_date('19-05-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (391, 'Cord prolapse-antepartum', 28, 472, to_date('18-06-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (392, 'Great vein anomaly NOS', 120, 163, to_date('26-03-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (393, 'Complete edentulism NOS', 77, 489, to_date('25-12-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (394, 'Cns TB NEC-exam unkn', 59, 229, to_date('18-02-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (395, 'Effect reduced temp NEC', 330, 492, to_date('09-03-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (396, 'Thoracoabd aortc ectasia', 64, 233, to_date('24-01-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (397, 'Male genetc test dis car', 48, 453, to_date('28-07-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (398, 'Pectus carinatum', 418, 244, to_date('09-04-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (399, 'Ocl mlt bi art w infrct', 294, 325, to_date('06-11-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (400, 'Salivary gland atrophy', 477, 417, to_date('18-06-2009', 'dd-mm-yyyy'));
commit;
prompt 400 records committed...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (401, 'RR acc w derail-employee', 249, 476, to_date('20-09-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (402, 'RR acc w derail-employee', 183, 36, to_date('21-07-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (403, 'Dysplasia of cervix NOS', 235, 189, to_date('01-03-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (404, 'Low bladder compliance', 24, 222, to_date('06-03-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (405, 'Teething syndrome', 170, 170, to_date('02-03-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (406, 'Twin-mate lb-hosp w/o cs', 109, 402, to_date('18-11-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (407, 'Idiopth lym interst pneu', 302, 485, to_date('06-05-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (408, 'Leg ab w metab dis-comp', 142, 92, to_date('10-12-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (409, 'Mv n-traf NEC-anim rider', 346, 387, to_date('01-12-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (410, 'Splenic sequestration', 95, 320, to_date('08-12-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (411, 'Injury trunk nerve NOS', 267, 9, to_date('07-11-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (412, 'Obstr eustach tube NOS', 500, 323, to_date('15-12-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (413, 'Alcoh induce sleep disor', 98, 249, to_date('09-05-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (414, 'Bacteria dis carrier NEC', 263, 270, to_date('22-07-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (415, 'T7-t12 fx-op/com crd les', 185, 487, to_date('02-03-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (416, 'Subendo infarct, initial', 467, 159, to_date('28-01-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (417, 'Excess attrition-general', 488, 63, to_date('10-10-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (418, 'Inf mcr rst qn flr nt ml', 71, 26, to_date('27-11-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (419, 'Cutan leishmanias asian', 399, 359, to_date('21-09-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (420, 'Equatorial staphyloma', 214, 206, to_date('25-04-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (421, 'Monteggias fx-open', 457, 353, to_date('17-04-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (422, 'Compl lab/deliv NEC-unsp', 380, 52, to_date('16-09-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (423, 'Open wound of foot', 141, 328, to_date('20-11-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (424, 'Motor neuron disease NEC', 403, 170, to_date('15-12-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (425, 'Irradiation cystitis', 246, 472, to_date('08-08-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (426, 'Comp-oth vasc dev/graft', 66, 136, to_date('19-04-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (427, 'Oth spcf hypoglycemia', 406, 269, to_date('10-12-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (428, 'Foreign body anus/rectum', 134, 106, to_date('16-06-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (429, 'Hemangioma intracranial', 403, 102, to_date('28-09-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (430, 'Coccidioidomycosis NOS', 1, 37, to_date('09-06-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (431, 'TB sp crd absc-exam unkn', 357, 102, to_date('10-05-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (432, 'Ovarian hyperfunc NEC', 27, 134, to_date('01-01-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (433, 'Refractive amblyopia', 23, 462, to_date('08-12-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (434, 'Quadrplg c1-c4, complete', 18, 496, to_date('01-03-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (435, 'Lordosis in oth dis', 422, 303, to_date('08-03-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (436, 'Ocl mlt bi art w infrct', 268, 114, to_date('16-06-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (437, 'Compl heart transplant', 230, 367, to_date('07-08-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (438, 'Oth spcf hypoglycemia', 319, 249, to_date('01-08-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (439, 'Prim angle clos w/o dmg', 445, 150, to_date('27-01-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (440, 'Chr pulmonary embolism', 253, 198, to_date('22-08-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (441, 'Sprain sacrospinatus', 447, 107, to_date('09-09-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (442, 'Ankylosis-mult joints', 139, 100, to_date('17-02-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (443, 'Venous tributary occlus', 350, 274, to_date('10-01-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (444, 'Breech del/extrac aff NB', 140, 211, to_date('25-12-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (445, 'T7-t12 fx-op/ant crd syn', 162, 313, to_date('21-09-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (446, 'Irradiation cystitis', 164, 168, to_date('04-04-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (447, '2nd deg burn abdomn wall', 427, 413, to_date('03-02-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (448, 'Vac-dis combinations NOS', 337, 89, to_date('16-10-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (449, 'Blister hand', 346, 141, to_date('24-03-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (450, 'Anatomical narrow angle', 492, 182, to_date('16-09-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (451, 'Splenic sequestration', 344, 199, to_date('20-01-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (452, 'Rhabdomyolysis', 282, 437, to_date('06-01-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (453, 'Monoarthritis NOS-shlder', 406, 137, to_date('24-04-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (454, 'Recur depr psych-severe', 136, 127, to_date('14-07-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (455, 'Oil/essence pneumonitis', 101, 499, to_date('13-11-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (456, 'Cns TB NEC-exam unkn', 460, 401, to_date('06-01-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (457, 'Clothing fire-bldg NEC', 83, 170, to_date('11-01-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (458, 'Mv coll w ped-ped cycl', 500, 424, to_date('07-07-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (459, 'Monoarthritis NOS-shlder', 46, 432, to_date('01-03-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (460, 'Acq hemolytic anemia NOS', 118, 349, to_date('23-03-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (461, 'Stat obj w sub fall NEC', 110, 275, to_date('11-11-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (462, 'Psychogenic disorder NEC', 335, 454, to_date('14-02-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (463, 'Ac rheumatic myocarditis', 355, 25, to_date('25-07-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (464, 'Ankylosis-lower/leg', 421, 1, to_date('15-03-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (465, 'Pulmon TB NEC-micro dx', 321, 302, to_date('20-12-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (466, 'Acc poisn-tranquilzr NOS', 443, 340, to_date('24-07-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (467, 'Burning bedclothes', 151, 289, to_date('10-10-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (468, 'Acc poisn-tranquilzr NOS', 425, 44, to_date('13-04-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (469, 'Foreign body in stomach', 427, 331, to_date('06-08-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (470, 'Nodular lymphoma abdom', 399, 21, to_date('12-07-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (471, 'Cumltv trma-repetv impct', 399, 297, to_date('13-07-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (472, 'Unil femoral hern w gang', 202, 35, to_date('24-12-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (473, 'Acquired hemophilia', 3, 62, to_date('05-09-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (474, 'Cornea transplant status', 129, 195, to_date('21-05-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (475, 'Cough variant asthma', 301, 257, to_date('20-10-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (476, 'Subarachnoid hem-no coma', 439, 335, to_date('09-02-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (477, 'Nephritis NOS', 286, 184, to_date('09-12-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (478, 'Oth spcf hypoglycemia', 156, 208, to_date('26-03-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (479, 'Sleep apnea NOS', 264, 179, to_date('08-10-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (480, 'Aftercare path fx hip', 185, 324, to_date('14-02-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (481, 'Hemangioma retina', 16, 213, to_date('25-07-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (482, 'Toxoplasmosis site NEC', 471, 295, to_date('17-08-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (483, 'Malig neo parathyroid', 23, 283, to_date('01-06-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (484, 'Brain condition NOS', 29, 167, to_date('27-12-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (485, 'Unsat cerv cytlogy smear', 128, 313, to_date('24-07-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (486, 'BMI 33.0-33.9,adult', 370, 81, to_date('17-07-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (487, 'Klinefelters syndrome', 19, 194, to_date('03-03-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (488, 'DMI ophth nt st uncntrld', 422, 467, to_date('18-08-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (489, 'Anphylct react milk prod', 274, 235, to_date('06-01-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (490, 'Fx gr tuberos humer-open', 230, 163, to_date('04-03-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (491, 'Cardiorespirat probl NEC', 184, 267, to_date('23-09-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (492, 'Derang lat meniscus NOS', 389, 269, to_date('04-07-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (493, 'DMII ophth uncntrld', 296, 315, to_date('13-06-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (494, 'Injury arm vessels NEC', 347, 439, to_date('19-03-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (495, 'TB of joint NEC-no exam', 142, 153, to_date('20-09-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (496, 'Acq finger deformity NEC', 241, 490, to_date('09-06-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (497, 'Acc poisn-alcohol bevrag', 237, 284, to_date('15-12-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (498, 'Mucositis d/t drugs NEC', 297, 14, to_date('01-09-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (499, 'Burn NOS scapula', 354, 462, to_date('24-12-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (500, 'Unsat cerv cytlogy smear', 371, 471, to_date('15-05-2021', 'dd-mm-yyyy'));
commit;
prompt 500 records committed...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (501, 'Plicated tongue', 168, 205, to_date('04-05-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (502, 'Multiple sclerosis', 202, 461, to_date('27-12-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (503, 'Cornea transplant status', 390, 264, to_date('11-06-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (504, '3rd deg burn nose', 156, 420, to_date('25-10-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (505, 'Acc poisn-tranquilzr NOS', 279, 453, to_date('24-12-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (506, 'Sprain sacrospinatus', 113, 472, to_date('26-05-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (507, 'Hx of myeloid leukemia', 472, 63, to_date('03-02-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (508, 'Second hypertension NEC', 437, 94, to_date('04-09-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (509, 'Hx-malig skin melanoma', 148, 421, to_date('28-09-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (510, 'Toxic gastroenteritis', 130, 88, to_date('28-05-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (511, 'Nonpsychot brain syn NOS', 438, 60, to_date('02-12-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (512, 'Rhabdomyolysis', 43, 271, to_date('21-05-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (513, 'Drug psy dis w hallucin', 413, 169, to_date('02-11-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (514, 'Heat edema', 383, 477, to_date('17-08-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (515, 'Hemarthrosis-l/leg', 399, 478, to_date('21-07-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (516, 'Teething syndrome', 171, 480, to_date('18-02-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (517, 'Aggres periodontitis,loc', 177, 90, to_date('10-12-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (518, 'Subendo infarct, initial', 324, 91, to_date('06-03-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (519, 'Talipes valgus', 156, 440, to_date('27-07-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (520, 'Spondylopathy in oth dis', 97, 459, to_date('02-09-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (521, 'Anphylct react milk prod', 15, 187, to_date('13-03-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (522, 'Schistosoma mansoni', 228, 307, to_date('18-11-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (523, 'Talipes equinovarus', 183, 400, to_date('13-02-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (524, 'C1-c4 spin cord inj NOS', 55, 200, to_date('01-05-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (525, 'Diplegia of upper limbs', 196, 92, to_date('08-07-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (526, 'Infection of kidney NOS', 142, 455, to_date('12-04-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (527, 'TB of kidney-exam unkn', 313, 288, to_date('13-01-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (528, 'Explosive personality', 497, 187, to_date('07-10-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (529, 'Congen limb anomaly NOS', 445, 47, to_date('23-11-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (530, 'Cong valgus foot def NEC', 177, 9, to_date('15-05-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (531, 'Auditory recruitment', 99, 57, to_date('09-08-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (532, 'Activity NEC', 100, 54, to_date('19-11-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (533, 'Other pulmonary insuff', 19, 4, to_date('12-11-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (534, 'Fx tibia NOS-open', 188, 18, to_date('15-03-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (535, 'Fail induct NOS-antepart', 118, 278, to_date('10-09-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (536, 'Cardiac arrest', 124, 119, to_date('28-12-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (537, 'Monteggias fx-open', 354, 95, to_date('04-05-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (538, 'Monoarthritis NOS-shlder', 279, 251, to_date('17-02-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (539, 'Cl lumbar fx w cord inj', 288, 20, to_date('08-11-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (540, 'Coccidioidomycosis NOS', 329, 328, to_date('26-09-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (541, 'Fx upper humerus NEC-opn', 314, 159, to_date('25-12-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (542, 'Cardiogenic shock', 390, 98, to_date('25-11-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (543, 'Persistent fetal circ', 145, 227, to_date('13-04-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (544, 'Tox eff lead compnd NOS', 372, 378, to_date('07-09-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (545, 'Craniorachischisis', 463, 443, to_date('10-10-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (546, 'Prophylactic isolation', 230, 108, to_date('13-03-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (547, 'Ac DVT/embl up ext', 498, 98, to_date('28-04-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (548, 'Congen limb anomaly NOS', 260, 36, to_date('06-01-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (549, 'Takayasus disease', 478, 58, to_date('28-04-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (550, 'Open wound of ear NOS', 347, 433, to_date('20-06-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (551, 'Angio intes w hmrhg', 231, 15, to_date('27-09-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (552, '3rd deg burn nose', 97, 349, to_date('27-09-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (553, 'Erosion NOS', 449, 436, to_date('25-08-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (554, 'Mv board/alight-pers NEC', 29, 94, to_date('18-06-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (555, 'Siderosis', 18, 483, to_date('23-09-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (556, 'C1-c4 fx-op/cen cord syn', 229, 124, to_date('04-02-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (557, 'Infection of kidney NOS', 368, 349, to_date('10-06-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (558, 'Cardiorespirat probl NEC', 245, 313, to_date('21-05-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (559, 'C1-c4 fx-op/cen cord syn', 361, 323, to_date('03-02-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (560, 'Syphil acoustic neuritis', 65, 439, to_date('02-01-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (561, 'Breast prosth malfunc', 234, 332, to_date('23-05-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (562, 'Vaccination for Td-DT', 23, 449, to_date('10-12-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (563, 'Abn pelv tis obstr-antep', 110, 105, to_date('22-01-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (564, 'Open wound of ear NOS', 465, 400, to_date('09-11-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (565, 'Malign neopl ovary', 214, 256, to_date('20-03-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (566, 'Brain neoplasm NOS', 81, 149, to_date('16-10-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (567, 'Talipes equinovarus', 164, 408, to_date('05-04-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (568, 'Talipes equinovarus', 399, 197, to_date('24-01-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (569, 'Acc poisn-alcohol bevrag', 57, 127, to_date('11-01-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (570, 'Essen hyperten-delivered', 390, 22, to_date('10-03-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (571, 'Renal & ureteral dis NOS', 321, 15, to_date('02-01-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (572, 'Oth mono leuk w rmsion', 69, 75, to_date('10-06-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (573, 'Sec DM hpros nt st uncnr', 41, 144, to_date('09-04-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (574, 'Twin gest-dich/diamniotc', 418, 280, to_date('23-10-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (575, 'Cornea transplant status', 415, 154, to_date('09-06-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (576, 'Anomalous av excitation', 498, 315, to_date('25-06-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (577, 'Dis calcium metablsm NEC', 169, 81, to_date('21-02-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (578, 'GI injury NEC-open', 391, 498, to_date('06-03-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (579, 'Macular degeneration NOS', 328, 477, to_date('16-12-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (580, 'Bacteria dis carrier NEC', 294, 160, to_date('15-10-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (581, 'Septicemia in labor-unsp', 386, 380, to_date('04-03-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (582, 'Central hearing loss', 85, 6, to_date('07-04-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (583, 'Psychogen musculskel dis', 51, 178, to_date('08-09-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (584, 'Inj mlt head/neck vessel', 76, 260, to_date('18-03-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (585, 'Talipes valgus', 252, 45, to_date('12-07-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (586, 'Orchitis in oth disease', 427, 197, to_date('08-11-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (587, 'Inflam/tox neuropthy NOS', 305, 165, to_date('18-06-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (588, 'Loose body-forearm', 34, 318, to_date('05-11-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (589, 'Insect bite shld/arm-inf', 314, 27, to_date('01-01-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (590, 'Explosive personality', 35, 294, to_date('17-11-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (591, 'Quadrplg c1-c4, complete', 112, 178, to_date('18-02-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (592, 'Posterior disloc hip-opn', 446, 220, to_date('01-12-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (593, 'Craniorachischisis', 178, 79, to_date('25-05-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (594, 'Periostitis-unspec', 332, 20, to_date('21-07-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (595, 'Anphylct react milk prod', 351, 237, to_date('05-09-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (596, 'Obstruct labor NOS-deliv', 281, 430, to_date('25-01-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (597, 'Subarachnoid hem-no coma', 431, 395, to_date('21-06-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (598, 'TB brain abscess-cult dx', 233, 287, to_date('01-08-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (599, 'Fetal malnutr 1750-1999g', 17, 413, to_date('12-05-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (600, 'Periostitis-unspec', 463, 301, to_date('13-06-2008', 'dd-mm-yyyy'));
commit;
prompt 600 records committed...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (601, 'Intestin parasitism NOS', 368, 324, to_date('01-10-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (602, 'Cl skull vlt fx-brf coma', 21, 33, to_date('15-08-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (603, 'Prune belly syndrome', 417, 364, to_date('09-09-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (604, 'Cnsl victim child abuse', 196, 477, to_date('06-09-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (605, 'Disl metatarsal NOS-open', 67, 156, to_date('22-01-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (606, 'Anaplastic lymph pelvic', 96, 120, to_date('16-07-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (607, 'Part resolv traum catar', 260, 372, to_date('02-03-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (608, 'Hx of myeloid leukemia', 53, 201, to_date('19-04-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (609, '3rd deg burn nose', 415, 325, to_date('03-10-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (610, 'Intestin parasitism NOS', 285, 289, to_date('09-08-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (611, 'Thromboangiit obliterans', 291, 361, to_date('28-06-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (612, 'Solitary cyst of breast', 83, 301, to_date('16-07-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (613, 'Joint symptom NEC-hand', 243, 293, to_date('11-12-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (614, 'Hpt B chrn coma wo dlta', 2, 216, to_date('02-06-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (615, 'Poisoning-tetanus vaccin', 419, 477, to_date('27-01-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (616, 'Papilledema w decr press', 83, 17, to_date('06-02-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (617, 'Oth dermatitis solar rad', 186, 322, to_date('24-05-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (618, 'Lt-date w/mal 1500-1749g', 411, 138, to_date('12-09-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (619, 'Anphylct react milk prod', 449, 403, to_date('20-04-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (620, 'Crushing injury foot', 185, 44, to_date('22-03-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (621, 'Mech loosening pros jt', 173, 408, to_date('11-03-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (622, 'Hypervitaminosis d', 79, 38, to_date('28-01-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (623, 'Undet circ-fall residenc', 118, 352, to_date('18-10-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (624, 'Mycobacterial dis NEC', 326, 489, to_date('02-01-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (625, 'Opn brain inj-deep coma', 410, 12, to_date('15-04-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (626, 'Genital prolapse NEC', 151, 109, to_date('11-11-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (627, 'Sleep apnea NOS', 56, 260, to_date('10-01-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (628, 'Chr maxillary sinusitis', 50, 488, to_date('01-10-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (629, 'Hx of emotional abuse', 276, 412, to_date('08-12-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (630, 'Cardiogenic shock', 69, 194, to_date('08-01-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (631, 'Vaginal hematoma', 37, 282, to_date('19-04-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (632, 'Iatrogen CV infarc/hmrhg', 478, 238, to_date('14-11-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (633, 'Oil/essence pneumonitis', 3, 483, to_date('02-06-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (634, 'Ankylosis-mult joints', 355, 493, to_date('04-01-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (635, 'Psychogen musculskel dis', 174, 314, to_date('09-01-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (636, 'Oth ob surg compl-postpa', 416, 61, to_date('25-07-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (637, 'Visceral aneurysm NEC', 73, 38, to_date('23-04-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (638, 'Disorders of eyelid NEC', 7, 409, to_date('21-01-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (639, 'Mv-train coll-anim rid', 442, 339, to_date('04-06-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (640, 'Hx-hodgkins disease', 180, 276, to_date('20-03-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (641, 'Brain condition NOS', 440, 499, to_date('03-07-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (642, 'Periostitis-unspec', 391, 413, to_date('16-04-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (643, 'Cns TB NEC-exam unkn', 310, 346, to_date('17-03-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (644, '3rd deg burn nose', 386, 116, to_date('08-10-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (645, 'Comp lab/deliv NEC-deliv', 459, 13, to_date('14-03-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (646, 'Dermatophytosis of groin', 193, 143, to_date('01-06-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (647, 'Chr iridocyclitis NOS', 438, 130, to_date('01-08-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (648, 'Act lymp leuk in relapse', 424, 470, to_date('21-03-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (649, 'Idiopth lym interst pneu', 334, 258, to_date('06-07-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (650, 'Laundry', 247, 104, to_date('03-11-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (651, 'T7-t12 fx-op/com crd les', 342, 23, to_date('02-01-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (652, 'Mal neo lymph node NOS', 408, 279, to_date('22-07-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (653, 'Breast engorge-delivered', 212, 16, to_date('28-09-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (654, 'Teething syndrome', 468, 135, to_date('05-03-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (655, 'Recur depr psych-severe', 379, 286, to_date('23-03-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (656, 'Leg ab w metab dis-comp', 35, 37, to_date('14-02-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (657, 'Fx base femoral nck-open', 447, 462, to_date('01-02-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (658, 'Juv osteochondros spine', 392, 491, to_date('25-09-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (659, 'Family dsrpt-estrangmemt', 186, 410, to_date('15-07-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (660, 'Dis mitochondrial metab', 64, 321, to_date('24-12-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (661, 'DMI ophth nt st uncntrld', 480, 471, to_date('03-01-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (662, 'Sec hyprprthyrd nonrenal', 106, 92, to_date('26-03-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (663, 'TB of thyroid-cult dx', 337, 284, to_date('10-08-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (664, 'Chr maxillary sinusitis', 48, 152, to_date('05-11-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (665, 'Vestibular neuronitis', 168, 120, to_date('21-01-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (666, 'Mental problems NEC', 293, 133, to_date('11-06-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (667, 'Sec hyprprthyrd nonrenal', 70, 368, to_date('15-05-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (668, 'Spleen disease NOS', 57, 72, to_date('28-05-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (669, 'TB of thyroid-cult dx', 399, 129, to_date('26-01-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (670, 'Compl lab/deliv NEC-unsp', 327, 164, to_date('06-09-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (671, 'Mening in oth fungal dis', 69, 252, to_date('23-01-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (672, 'Acq hemolytic anemia NOS', 458, 206, to_date('25-04-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (673, 'Poison-vasodilator NEC', 5, 416, to_date('27-07-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (674, 'Postcatheter forgn body', 132, 117, to_date('24-09-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (675, 'Papilledema w decr press', 321, 53, to_date('27-11-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (676, 'Coccidioidomycosis NOS', 406, 469, to_date('13-11-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (677, 'Oth spcf hypoglycemia', 211, 227, to_date('06-12-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (678, 'Glaucomatous flecks', 161, 167, to_date('18-06-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (679, 'Gonorrhea-delivered', 186, 100, to_date('27-05-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (680, 'Eustachian tube dis NEC', 472, 364, to_date('18-03-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (681, 'Idiopth lym interst pneu', 199, 449, to_date('13-09-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (682, 'Monoarthritis NOS-unspec', 199, 427, to_date('11-01-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (683, 'TB sp crd absc-exam unkn', 188, 220, to_date('01-01-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (684, 'Acq total absnc pancreas', 17, 323, to_date('04-05-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (685, 'Malposition NEC-antepart', 133, 305, to_date('11-12-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (686, 'Multiple sclerosis', 172, 498, to_date('09-10-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (687, 'Toxoplasma pneumonitis', 398, 424, to_date('11-03-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (688, 'Common truncus', 76, 175, to_date('25-05-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (689, 'Monteggias fx-open', 443, 285, to_date('28-08-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (690, 'No medical serv in home', 79, 346, to_date('10-01-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (691, 'Sparganosis', 130, 264, to_date('04-04-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (692, 'Cellulitis of arm', 300, 177, to_date('24-04-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (693, 'Second iritis, noninfec', 477, 149, to_date('11-03-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (694, 'Toxoplasma pneumonitis', 39, 309, to_date('23-09-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (695, 'NB intraven hem,grade ii', 388, 384, to_date('27-03-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (696, 'Trichomonal prostatitis', 412, 75, to_date('14-05-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (697, 'Cnsl victim child abuse', 317, 190, to_date('12-11-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (698, 'Sec DM hpros nt st uncnr', 410, 490, to_date('08-03-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (699, 'Benign parxysmal vertigo', 191, 142, to_date('15-05-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (700, 'Glaucomatous flecks', 141, 422, to_date('21-03-2020', 'dd-mm-yyyy'));
commit;
prompt 700 records committed...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (701, 'Pneumonia e coli', 296, 238, to_date('04-12-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (702, 'Primary carnitine defncy', 368, 268, to_date('11-06-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (703, 'Late eff nerve inj NEC', 147, 52, to_date('11-12-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (704, 'Unc behav neo testis', 46, 389, to_date('14-04-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (705, 'Lupus erythematosus', 318, 302, to_date('25-01-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (706, 'Bacteria dis carrier NEC', 435, 130, to_date('12-10-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (707, 'Postop shock, other', 322, 163, to_date('01-02-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (708, 'Conjunctival concretions', 166, 319, to_date('22-11-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (709, 'Open wound of hand', 480, 414, to_date('19-04-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (710, 'Acc poisn-alcohol bevrag', 499, 135, to_date('09-05-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (711, 'Isolated explosive dis', 159, 18, to_date('20-09-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (712, 'Request expert evidence', 495, 493, to_date('15-07-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (713, 'Female infertility NOS', 10, 498, to_date('11-10-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (714, 'Uterine endometriosis', 65, 249, to_date('25-08-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (715, 'GI injury NEC-open', 361, 297, to_date('18-01-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (716, 'Pneumonia due to SARS', 404, 492, to_date('02-01-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (717, 'Sleep apnea NOS', 361, 481, to_date('23-01-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (718, '3rd burn w loss-forearm', 459, 94, to_date('27-01-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (719, 'Chr membranoprolif nephr', 385, 409, to_date('27-01-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (720, 'Anphylct react milk prod', 306, 331, to_date('10-04-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (721, 'Breast engorge-delivered', 486, 285, to_date('02-12-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (722, 'Alcoh dep NEC/NOS-unspec', 19, 211, to_date('14-01-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (723, 'Unsp ds conjuc viruses', 197, 404, to_date('21-07-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (724, 'Splenic sequestration', 170, 193, to_date('21-05-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (725, 'Exudat cyst pars plana', 376, 378, to_date('18-04-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (726, 'Ankylosis-mult joints', 72, 479, to_date('17-05-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (727, 'Injury arm vessels NEC', 1, 5, to_date('05-05-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (728, 'Reentrant mv coll-driver', 385, 350, to_date('02-01-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (729, 'Streptobacillary fever', 481, 357, to_date('20-09-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (730, 'Aftercare path fx hip', 268, 383, to_date('11-07-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (731, 'Gross hematuria', 289, 187, to_date('04-09-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (732, 'Subarach hem-brief coma', 189, 63, to_date('21-03-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (733, 'Hx of myeloid leukemia', 219, 469, to_date('08-08-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (734, 'Helminth arthrit-forearm', 361, 341, to_date('11-12-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (735, 'Late eff environment acc', 177, 412, to_date('06-11-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (736, 'Oth spcf hypoglycemia', 223, 356, to_date('18-12-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (737, 'Spinal cord injury NOS', 485, 350, to_date('06-07-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (738, 'Comp lab/deliv NEC-deliv', 479, 283, to_date('22-07-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (739, 'Toxic effect antimony', 68, 427, to_date('06-03-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (740, 'Corneal disorder NEC', 85, 192, to_date('19-12-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (741, 'Chr stom ulc w hem-obstr', 188, 131, to_date('10-10-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (742, 'Hx of myeloid leukemia', 220, 27, to_date('19-12-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (743, 'Dis mitochondrial metab', 114, 192, to_date('23-04-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (744, 'Conjunctival concretions', 322, 76, to_date('22-10-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (745, 'Mucositis d/t drugs NEC', 243, 276, to_date('04-08-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (746, 'Abn pelv tis obstr-antep', 103, 324, to_date('05-06-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (747, 'Obstr eustach tube NOS', 148, 106, to_date('13-07-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (748, 'Thoracoabd aortc ectasia', 338, 157, to_date('18-11-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (749, 'T7-t12 fx-op/ant crd syn', 103, 191, to_date('10-11-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (750, '50-59% bdy brn/3 deg NOS', 10, 410, to_date('27-09-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (751, 'Traffic acc NOS-driver', 491, 499, to_date('14-01-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (752, 'Posterior disloc hip-opn', 241, 459, to_date('05-08-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (753, 'Periostitis-unspec', 113, 470, to_date('25-04-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (754, 'TB of ureter-micro dx', 368, 282, to_date('06-06-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (755, 'Strep sore throat', 404, 361, to_date('16-04-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (756, 'One eye-moderate/oth-NOS', 45, 189, to_date('12-02-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (757, 'Myelitis cause NEC', 124, 100, to_date('02-02-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (758, 'Blister hand', 77, 113, to_date('05-01-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (759, 'Opn cort contus-brf coma', 490, 52, to_date('11-03-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (760, 'Laundry', 371, 116, to_date('21-07-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (761, 'Prune belly syndrome', 425, 421, to_date('05-08-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (762, 'Hodg nodul sclero mult', 101, 139, to_date('12-04-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (763, 'Comp-oth vasc dev/graft', 322, 388, to_date('18-06-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (764, 'Other pulmonary insuff', 71, 197, to_date('18-10-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (765, 'Infection of kidney NOS', 133, 139, to_date('15-10-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (766, 'Sleep apnea NOS', 285, 184, to_date('28-03-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (767, 'Periostitis-unspec', 444, 145, to_date('09-03-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (768, 'Acc poison-soap products', 408, 118, to_date('26-08-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (769, 'Hx-malig skin melanoma', 179, 29, to_date('17-05-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (770, 'Pressure ulcer, heel', 285, 88, to_date('26-11-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (771, 'Male genetc test dis car', 227, 106, to_date('28-10-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (772, '1st deg burn head NOS', 497, 389, to_date('04-04-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (773, 'Chr membranoprolif nephr', 168, 41, to_date('08-10-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (774, 'Oth coll mov obj-per NEC', 398, 169, to_date('25-07-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (775, 'Referral-no exam/treat', 251, 341, to_date('23-10-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (776, 'Congen limb anomaly NOS', 148, 215, to_date('12-12-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (777, 'Fx base femoral nck-open', 469, 321, to_date('26-01-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (778, 'Oth coll mov obj-per NEC', 10, 166, to_date('04-05-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (779, 'Venous tributary occlus', 403, 71, to_date('07-01-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (780, 'Clothing fire-bldg NEC', 77, 34, to_date('18-08-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (781, 'Inj mlt head/neck vessel', 191, 303, to_date('23-06-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (782, 'Dis calcium metablsm NEC', 317, 421, to_date('27-08-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (783, 'Coccidioidomycosis NOS', 313, 292, to_date('02-10-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (784, 'One eye-moderate/oth-NOS', 166, 181, to_date('01-10-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (785, 'Fall-occ unpower aircraf', 28, 453, to_date('08-04-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (786, 'Syphil acoustic neuritis', 79, 252, to_date('06-01-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (787, 'Fx base femoral nck-open', 466, 120, to_date('08-05-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (788, 'Obsrv NB suspc resp cond', 365, 172, to_date('05-09-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (789, 'Deep 3rd deg burn foot', 205, 436, to_date('14-05-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (790, 'Effect reduced temp NEC', 481, 349, to_date('23-08-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (791, 'Cns disorder NOS', 288, 261, to_date('13-02-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (792, 'Cl skul fx NEC-deep coma', 96, 8, to_date('13-03-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (793, 'Obstr eustach tube NOS', 290, 496, to_date('26-10-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (794, 'Compl heart transplant', 158, 239, to_date('23-10-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (795, 'Unc behav neo placenta', 468, 348, to_date('26-01-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (796, 'Lupus erythematosus', 174, 271, to_date('28-11-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (797, 'Postcatheter forgn body', 291, 345, to_date('25-06-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (798, 'Genital prolapse NEC', 130, 135, to_date('28-02-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (799, 'Request expert evidence', 125, 210, to_date('13-07-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (800, 'Syphil acoustic neuritis', 424, 371, to_date('12-10-2010', 'dd-mm-yyyy'));
commit;
prompt 800 records committed...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (801, 'Fetal malnutr 1750-1999g', 436, 323, to_date('01-06-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (802, 'Affectiv personality NOS', 215, 393, to_date('06-02-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (803, 'Late eff nerve inj NEC', 428, 119, to_date('28-12-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (804, 'Part resolv traum catar', 484, 58, to_date('08-03-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (805, 'Hemangioma retina', 118, 288, to_date('17-10-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (806, 'Placent polyp-del w p/p', 262, 99, to_date('13-06-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (807, 'Prim TB pleur-exam unkn', 99, 483, to_date('24-12-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (808, 'Great vein anomaly NOS', 164, 126, to_date('14-12-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (809, 'Anomalous av excitation', 241, 196, to_date('28-04-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (810, 'Inj nerve pelv/leg NOS', 9, 223, to_date('18-09-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (811, 'Jt contracture-ankle', 238, 441, to_date('25-08-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (812, 'Histoplasmosis NOS', 208, 247, to_date('15-01-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (813, 'Anatomical narrow angle', 21, 180, to_date('21-06-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (814, 'Brach plexus inj-birth', 446, 151, to_date('25-05-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (815, 'Injury arm vessels NEC', 127, 68, to_date('09-07-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (816, 'Klinefelters syndrome', 68, 354, to_date('09-11-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (817, 'Lt-date w/mal 1500-1749g', 440, 8, to_date('13-07-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (818, 'Fx upper humerus NEC-opn', 225, 39, to_date('13-07-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (819, 'Spinal muscl atrophy NEC', 259, 324, to_date('01-04-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (820, 'Fx tibia NOS-open', 406, 271, to_date('15-11-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (821, 'Bursal cyst NEC', 484, 417, to_date('17-01-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (822, 'Chr membranoprolif nephr', 130, 387, to_date('26-01-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (823, 'Injury trunk nerve NOS', 250, 377, to_date('23-07-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (824, 'Breech del/extrac aff NB', 246, 367, to_date('06-08-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (825, 'Fracture six ribs-closed', 478, 368, to_date('22-10-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (826, 'Ice hockey', 306, 16, to_date('19-11-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (827, 'Cl skl w oth fx-mod coma', 250, 480, to_date('03-02-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (828, 'Cellulitis, toe NOS', 40, 94, to_date('17-08-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (829, 'Brain condition NOS', 416, 290, to_date('06-01-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (830, 'Asympt varicose veins', 426, 92, to_date('13-11-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (831, 'Hyperem w metab dis-unsp', 222, 81, to_date('01-06-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (832, 'Brach plexus inj-birth', 370, 383, to_date('28-03-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (833, 'Pressure ulcer, heel', 50, 434, to_date('05-09-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (834, 'Ice hockey', 236, 481, to_date('08-01-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (835, 'Open wound of foot', 32, 361, to_date('08-05-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (836, 'Fx c1 vertebra-closed', 391, 57, to_date('15-02-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (837, 'Retain FB NEC', 467, 263, to_date('26-03-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (838, 'Dermatophytosis of groin', 430, 52, to_date('11-05-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (839, 'Oth dermatitis solar rad', 452, 56, to_date('17-08-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (840, 'Hx-prostatic malignancy', 112, 485, to_date('04-03-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (841, 'Acute pericarditis NEC', 12, 254, to_date('21-09-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (842, 'Act lymp leuk in relapse', 144, 146, to_date('09-11-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (843, 'Epidem hem conjunctivit', 364, 232, to_date('19-06-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (844, 'Affectiv personality NOS', 485, 95, to_date('13-08-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (845, 'Tox eff lead compnd NOS', 280, 94, to_date('03-06-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (846, 'Esotropia NOS', 142, 111, to_date('02-02-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (847, 'Superfic foreign bdy NEC', 130, 455, to_date('02-05-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (848, 'Orchitis in oth disease', 457, 283, to_date('07-09-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (849, 'Cl skul base fx-mod coma', 126, 361, to_date('17-03-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (850, 'Vomit of pg NOS-antepart', 156, 340, to_date('12-06-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (851, 'Solitary cyst of breast', 308, 313, to_date('16-02-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (852, 'TB sp crd absc-exam unkn', 208, 389, to_date('14-08-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (853, 'Mal neo lymph-intrapelv', 416, 343, to_date('28-08-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (854, 'Cl skull fx NEC w/o coma', 488, 262, to_date('15-03-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (855, 'Fx base femoral nck-open', 333, 258, to_date('07-12-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (856, 'Sprain rotator cuff', 430, 413, to_date('23-08-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (857, 'Oth spcf hypoglycemia', 363, 103, to_date('16-09-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (858, 'Effect reduced temp NEC', 278, 10, to_date('17-12-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (859, 'Talipes valgus', 315, 247, to_date('05-10-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (860, 'Periostitis-unspec', 281, 164, to_date('24-04-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (861, 'Toxoplasmosis site NEC', 456, 451, to_date('18-01-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (862, 'T7-t12 fx-op/ant crd syn', 103, 428, to_date('16-11-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (863, 'Mv board/alight-pers NEC', 436, 174, to_date('15-02-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (864, 'Loose body-forearm', 2, 110, to_date('17-04-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (865, 'Paral polio NEC-type 1', 143, 443, to_date('08-07-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (866, 'Acq hemolytic anemia NOS', 126, 99, to_date('25-11-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (867, 'Inj int mammary art/vein', 98, 476, to_date('26-03-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (868, 'Inj internl jugular vein', 405, 458, to_date('26-06-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (869, 'Anatomical narrow angle', 153, 142, to_date('23-06-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (870, 'Anomalous av excitation', 233, 42, to_date('02-10-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (871, 'Dis mitochondrial metab', 445, 344, to_date('26-09-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (872, 'Asympt varicose veins', 55, 130, to_date('16-04-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (873, 'RR acc w derail-pedest', 404, 199, to_date('06-05-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (874, 'Coccidioidomycosis NOS', 495, 282, to_date('18-01-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (875, 'Klinefelters syndrome', 242, 342, to_date('03-11-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (876, 'Hx of emotional abuse', 328, 128, to_date('01-06-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (877, 'Pois-sedative/hypnot NEC', 76, 282, to_date('02-10-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (878, 'C1-c4 spin cord inj NOS', 383, 481, to_date('26-06-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (879, 'Pressure ulcer, heel', 115, 297, to_date('25-08-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (880, 'Helminth arthrit-forearm', 14, 138, to_date('13-01-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (881, 'Anomalies of uterus NEC', 184, 166, to_date('08-03-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (882, 'Leg abor w pelv inf-unsp', 65, 448, to_date('22-09-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (883, 'Subarachnoid hem-no coma', 354, 336, to_date('27-02-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (884, 'Spondylopathy in oth dis', 105, 415, to_date('12-07-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (885, 'Loss control mv-pers NOS', 477, 487, to_date('13-12-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (886, 'Ocl mlt bi art w infrct', 427, 487, to_date('13-11-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (887, 'Plicated tongue', 440, 239, to_date('06-04-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (888, 'Exudat cyst pars plana', 333, 247, to_date('23-06-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (889, 'Gouty tophi of ear', 26, 209, to_date('21-04-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (890, 'Fire in bldg-fumes NOS', 131, 265, to_date('23-07-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (891, 'Foreign body anus/rectum', 256, 86, to_date('17-12-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (892, 'Postop shock, other', 382, 111, to_date('06-05-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (893, '1st deg burn head NOS', 251, 203, to_date('20-05-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (894, 'Quadrplg c1-c4, complete', 273, 148, to_date('04-03-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (895, 'Asympt varicose veins', 402, 492, to_date('18-05-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (896, 'Fx c1 vertebra-closed', 350, 374, to_date('02-12-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (897, 'Disl metatarsal NOS-open', 33, 460, to_date('03-03-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (898, 'Pap smear cervix w HGSIL', 469, 70, to_date('04-04-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (899, 'Deep 3rd burn trunk NEC', 254, 480, to_date('28-03-2021', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (900, 'Low bladder compliance', 14, 356, to_date('26-02-2003', 'dd-mm-yyyy'));
commit;
prompt 900 records committed...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (901, 'Chr iridocyclitis NOS', 204, 446, to_date('09-08-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (902, 'Lupus erythematosus', 369, 386, to_date('02-01-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (903, 'Tox eff lead compnd NOS', 246, 150, to_date('17-01-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (904, 'Fx base femoral nck-open', 296, 118, to_date('01-07-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (905, 'Acute respiratry failure', 25, 364, to_date('26-03-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (906, 'Cl skl w oth fx-mod coma', 226, 349, to_date('14-05-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (907, 'Fail induct NOS-antepart', 318, 391, to_date('03-01-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (908, 'Vaginal hematoma', 51, 288, to_date('18-11-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (909, 'Anphylct react milk prod', 18, 40, to_date('09-10-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (910, 'Referral-no exam/treat', 207, 464, to_date('05-05-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (911, 'Female infertility NOS', 72, 103, to_date('07-07-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (912, 'Lacrimal fistula', 144, 499, to_date('08-02-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (913, 'Ovarian hyperfunc NEC', 454, 342, to_date('18-12-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (914, 'Bursal cyst NEC', 120, 347, to_date('19-04-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (915, 'Acute pericarditis NEC', 8, 51, to_date('05-01-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (916, 'Crbl art ocl NOS w infrc', 44, 437, to_date('16-03-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (917, 'Deep 3rd burn trunk NEC', 214, 44, to_date('17-05-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (918, 'Screen neop-nervous syst', 151, 210, to_date('16-02-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (919, 'Exudat cyst pars plana', 375, 307, to_date('28-09-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (920, 'Cnsl victim child abuse', 165, 291, to_date('09-03-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (921, 'Opn brain inj-deep coma', 164, 56, to_date('19-09-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (922, 'Vaccination for Td-DT', 139, 129, to_date('06-06-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (923, 'Vrnt mgrn wo ntr mgr NEC', 355, 411, to_date('28-01-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (924, 'Multiple sclerosis', 187, 203, to_date('12-04-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (925, 'Cellulitis of arm', 235, 84, to_date('07-08-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (926, 'Subarach hem-brief coma', 316, 128, to_date('21-10-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (927, 'Aggres periodontitis,loc', 79, 182, to_date('25-02-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (928, 'Comp-oth vasc dev/graft', 332, 319, to_date('03-01-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (929, 'Epidem hem conjunctivit', 327, 260, to_date('07-01-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (930, 'Strep sore throat', 8, 45, to_date('23-06-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (931, 'Reentrant mv coll-driver', 43, 88, to_date('04-12-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (932, 'Cl skull vlt fx-brf coma', 162, 80, to_date('01-07-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (933, 'Fail induct NOS-antepart', 334, 398, to_date('07-03-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (934, 'Conjunctival concretions', 32, 490, to_date('04-05-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (935, 'Angio intes w hmrhg', 190, 153, to_date('28-04-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (936, 'Loose body-forearm', 233, 56, to_date('17-06-2017', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (937, 'Asympt varicose veins', 75, 10, to_date('26-09-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (938, 'Ca in situ fem gen NEC', 231, 332, to_date('11-12-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (939, 'Alcohol mental disor NOS', 307, 4, to_date('03-09-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (940, '3rd deg burn nose', 394, 414, to_date('27-07-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (941, 'Lifting machine accident', 167, 457, to_date('28-01-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (942, 'Oth spcf hypoglycemia', 423, 80, to_date('17-02-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (943, 'Stat obj w sub fall NEC', 124, 243, to_date('15-05-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (944, 'Hypopotassemia', 143, 271, to_date('12-06-2006', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (945, 'Takayasus disease', 481, 244, to_date('15-11-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (946, 'DMII ophth uncntrld', 471, 8, to_date('16-02-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (947, 'Genetic anomaly leukocyt', 400, 58, to_date('03-04-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (948, 'Injury ovarian artery', 249, 461, to_date('19-12-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (949, 'Dermatophyt scalp/beard', 97, 454, to_date('14-10-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (950, 'Bacteria dis carrier NEC', 221, 283, to_date('16-06-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (951, 'Open wound of foot', 48, 70, to_date('09-10-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (952, 'Tox eff lead compnd NOS', 259, 141, to_date('18-05-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (953, 'Prim prg TB NEC-oth test', 228, 363, to_date('05-12-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (954, 'Cl skl w oth fx-mod coma', 422, 189, to_date('14-04-2011', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (955, 'Second hypertension NEC', 497, 252, to_date('02-10-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (956, 'Thromboangiit obliterans', 490, 97, to_date('25-06-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (957, 'Vaginal hematoma', 463, 290, to_date('22-02-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (958, 'Fire in bldg-fumes NOS', 368, 20, to_date('17-12-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (959, 'Disl metatarsal NOS-open', 327, 26, to_date('25-09-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (960, 'Foreign body anus/rectum', 239, 69, to_date('05-06-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (961, 'Heat effect NOS', 378, 328, to_date('26-12-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (962, 'Ab mammogram NOS', 137, 406, to_date('03-05-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (963, 'Teething syndrome', 339, 102, to_date('05-10-2005', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (964, 'Injury trunk nerve NOS', 495, 18, to_date('23-09-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (965, 'Adv eff analgesic NOS', 158, 396, to_date('26-03-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (966, 'Affectiv personality NOS', 66, 334, to_date('01-11-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (967, 'Acute otitis externa NEC', 15, 340, to_date('19-03-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (968, 'Ophthalmia nodosa', 11, 378, to_date('04-07-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (969, 'Opn brain inj-deep coma', 193, 30, to_date('02-04-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (970, 'Brain neoplasm NOS', 232, 273, to_date('22-05-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (971, 'Essen hyperten-delivered', 411, 230, to_date('20-09-2007', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (972, 'Rhabdomyolysis', 350, 291, to_date('20-06-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (973, 'One eye-moderate/oth-NOS', 110, 84, to_date('08-06-2013', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (974, 'Chr membranoprolif nephr', 189, 8, to_date('24-11-2018', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (975, 'Traffic acc NOS-driver', 21, 372, to_date('24-05-2003', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (976, 'Fall-occ unpower aircraf', 318, 379, to_date('27-08-2001', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (977, 'Breast prosth malfunc', 48, 471, to_date('03-09-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (978, 'Malfun neuro device/graf', 434, 390, to_date('23-12-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (979, 'Renal failure NOS', 74, 233, to_date('24-03-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (980, 'Open wound of foot', 381, 376, to_date('19-11-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (981, 'Monoarthritis NOS-unspec', 322, 10, to_date('11-09-2010', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (982, 'Mantle cell lymph multip', 427, 303, to_date('15-01-2000', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (983, 'Acute respiratry failure', 402, 95, to_date('16-11-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (984, 'Acute pericarditis NEC', 118, 159, to_date('03-10-2004', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (985, 'Attn rem surg dressing', 496, 190, to_date('01-08-2014', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (986, 'Fall-occ unpower aircraf', 388, 395, to_date('06-08-2012', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (987, 'Mal neo soft tis thorax', 150, 449, to_date('02-01-2015', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (988, 'Hyperem w metab dis-unsp', 415, 248, to_date('04-07-2020', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (989, 'Ophthalmia nodosa', 116, 49, to_date('24-04-2022', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (990, 'Dermatophyt scalp/beard', 119, 234, to_date('01-02-2016', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (991, 'Septicemia in labor-unsp', 232, 229, to_date('09-04-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (992, 'Crushing injury foot', 188, 116, to_date('08-01-2002', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (993, 'DMII ophth uncntrld', 101, 337, to_date('14-05-2008', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (994, 'Orchitis in oth disease', 174, 497, to_date('25-10-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (995, 'Tox eff lead compnd NOS', 415, 156, to_date('25-11-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (996, 'Surgical convalescence', 250, 189, to_date('03-08-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (997, 'Corneal disorder NEC', 169, 366, to_date('25-03-2009', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (998, 'Abn chromosomal analysis', 490, 314, to_date('26-10-2023', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (999, 'Mucositis d/t drugs NEC', 31, 374, to_date('08-05-2019', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (1000, 'Prim prg TB NEC-oth test', 286, 227, to_date('01-11-2000', 'dd-mm-yyyy'));
commit;
prompt 1000 records committed...
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (1001, 'test description', 55, 387, to_date('19-06-2024', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (1002, 'Sample treatment', 101, 201, to_date('28-06-2024 10:14:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (1003, 'test description', 55, 387, to_date('19-06-2024', 'dd-mm-yyyy'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (1004, 'Emergency Treatment', 9, 390, to_date('28-06-2024 18:00:43', 'dd-mm-yyyy hh24:mi:ss'));
insert into TREATMENT (treatmentid, description, patientid, doctorid, treatmentdate)
values (1005, 'Emergency Treatment', 9, 390, to_date('29-06-2024 22:20:09', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 1005 records loaded
prompt Loading MEDICATION_TREATMENT...
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (1, 1001);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (1, 1002);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (1, 1003);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (2, 1001);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (2, 1002);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (2, 1003);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (3, 175);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (3, 1002);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (3, 1003);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (4, 619);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (5, 1002);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (5, 1003);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (6, 185);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (6, 260);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (6, 681);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (6, 812);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (6, 1002);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (6, 1003);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (7, 612);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (7, 1002);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (7, 1003);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (11, 232);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (11, 389);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (11, 646);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (12, 732);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (13, 705);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (14, 665);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (18, 426);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (18, 587);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (18, 1004);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (18, 1005);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (19, 558);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (19, 1004);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (19, 1005);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (21, 620);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (24, 398);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (25, 346);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (25, 494);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (25, 765);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (27, 82);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (27, 610);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (27, 932);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (29, 213);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (29, 780);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (30, 630);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (32, 34);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (32, 215);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (35, 298);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (35, 536);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (35, 959);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (37, 912);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (40, 581);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (41, 515);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (42, 716);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (42, 980);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (43, 639);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (45, 28);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (45, 70);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (46, 300);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (46, 843);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (47, 90);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (48, 915);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (49, 937);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (50, 166);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (51, 470);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (52, 223);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (53, 554);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (53, 843);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (53, 1004);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (53, 1005);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (54, 601);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (55, 286);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (55, 436);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (55, 709);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (55, 1001);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (58, 657);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (59, 957);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (60, 739);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (60, 903);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (62, 157);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (64, 419);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (66, 742);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (67, 740);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (69, 399);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (70, 560);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (70, 587);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (70, 991);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (71, 487);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (72, 397);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (74, 122);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (74, 382);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (77, 888);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (78, 470);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (81, 344);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (82, 39);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (83, 401);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (83, 650);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (88, 995);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (89, 224);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (91, 960);
commit;
prompt 100 records committed...
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (92, 177);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (96, 830);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (100, 271);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (102, 866);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (103, 17);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (103, 292);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (107, 46);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (107, 415);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (109, 935);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (111, 84);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (111, 163);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (117, 60);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (119, 864);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (120, 105);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (120, 171);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (121, 130);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (122, 668);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (124, 703);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (128, 683);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (129, 13);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (133, 229);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (133, 455);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (133, 956);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (134, 467);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (137, 273);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (139, 208);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (139, 892);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (140, 939);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (141, 250);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (142, 511);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (145, 340);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (146, 481);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (146, 594);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (146, 635);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (148, 700);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (152, 304);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (152, 809);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (154, 656);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (157, 258);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (157, 373);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (157, 575);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (157, 718);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (159, 563);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (162, 14);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (162, 932);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (163, 29);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (165, 230);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (168, 682);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (168, 731);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (170, 604);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (172, 889);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (172, 966);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (173, 422);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (173, 681);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (173, 990);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (174, 58);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (175, 692);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (175, 754);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (175, 819);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (176, 349);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (177, 366);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (184, 913);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (186, 381);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (186, 598);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (186, 861);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (186, 911);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (188, 752);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (191, 655);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (191, 709);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (192, 881);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (195, 115);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (196, 949);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (198, 232);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (198, 737);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (199, 1004);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (199, 1005);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (202, 771);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (202, 888);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (203, 361);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (208, 265);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (208, 973);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (209, 865);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (210, 568);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (210, 918);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (212, 768);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (214, 183);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (214, 659);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (218, 1);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (222, 453);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (222, 458);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (222, 550);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (223, 268);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (223, 683);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (223, 1004);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (223, 1005);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (224, 888);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (226, 495);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (228, 704);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (229, 260);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (231, 263);
commit;
prompt 200 records committed...
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (231, 663);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (232, 989);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (233, 479);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (233, 559);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (236, 80);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (236, 87);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (237, 274);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (238, 184);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (238, 749);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (240, 640);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (241, 568);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (241, 645);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (242, 958);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (245, 418);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (247, 602);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (247, 665);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (251, 257);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (251, 730);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (251, 809);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (252, 578);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (254, 901);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (260, 512);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (262, 289);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (264, 376);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (267, 917);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (269, 422);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (271, 786);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (271, 868);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (274, 17);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (275, 434);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (275, 483);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (278, 512);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (279, 819);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (280, 58);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (280, 901);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (281, 148);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (281, 617);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (281, 859);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (284, 516);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (286, 388);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (288, 23);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (288, 958);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (294, 827);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (297, 716);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (298, 975);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (299, 242);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (300, 238);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (300, 938);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (304, 22);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (304, 610);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (304, 617);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (304, 703);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (307, 205);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (307, 238);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (308, 986);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (309, 388);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (311, 88);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (311, 987);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (312, 705);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (313, 350);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (314, 151);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (317, 4);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (317, 256);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (318, 62);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (318, 377);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (319, 12);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (319, 1004);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (319, 1005);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (320, 735);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (321, 830);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (322, 432);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (324, 157);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (325, 668);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (327, 47);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (328, 801);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (329, 783);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (329, 793);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (333, 301);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (334, 481);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (338, 627);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (339, 947);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (342, 387);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (345, 258);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (346, 890);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (346, 969);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (348, 928);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (349, 285);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (349, 876);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (349, 1004);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (349, 1005);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (352, 152);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (353, 318);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (353, 552);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (356, 480);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (359, 407);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (359, 1001);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (360, 89);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (360, 993);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (361, 377);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (361, 541);
commit;
prompt 300 records committed...
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (362, 102);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (363, 1000);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (367, 92);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (368, 95);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (368, 853);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (369, 436);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (370, 859);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (371, 942);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (372, 615);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (372, 879);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (376, 15);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (376, 823);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (377, 206);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (377, 429);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (378, 967);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (379, 531);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (379, 988);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (381, 901);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (383, 45);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (383, 581);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (386, 348);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (386, 455);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (387, 175);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (387, 315);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (389, 408);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (389, 464);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (389, 644);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (391, 528);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (391, 861);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (394, 324);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (395, 367);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (397, 641);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (398, 482);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (399, 242);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (399, 906);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (401, 375);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (401, 586);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (403, 323);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (404, 136);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (406, 360);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (406, 913);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (407, 29);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (411, 12);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (411, 244);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (411, 265);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (411, 405);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (412, 558);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (414, 725);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (416, 859);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (421, 577);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (421, 685);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (421, 985);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (422, 225);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (422, 700);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (424, 221);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (427, 369);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (428, 357);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (430, 122);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (430, 620);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (430, 883);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (431, 385);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (433, 726);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (435, 279);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (437, 711);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (438, 954);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (439, 31);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (439, 461);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (439, 659);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (441, 183);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (442, 13);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (443, 36);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (443, 295);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (444, 449);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (445, 476);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (446, 944);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (446, 954);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (446, 993);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (447, 393);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (450, 394);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (451, 997);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (452, 725);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (453, 185);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (453, 736);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (454, 368);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (454, 999);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (455, 222);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (455, 601);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (462, 646);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (463, 400);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (464, 776);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (465, 578);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (466, 690);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (470, 773);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (471, 796);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (472, 182);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (472, 790);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (473, 959);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (477, 82);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (477, 982);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (480, 313);
commit;
prompt 400 records committed...
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (481, 298);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (481, 704);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (482, 182);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (482, 701);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (484, 119);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (485, 832);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (487, 190);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (487, 657);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (488, 917);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (489, 406);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (489, 407);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (492, 284);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (496, 840);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (497, 554);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (498, 952);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (503, 649);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (507, 983);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (508, 347);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (508, 398);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (513, 381);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (517, 265);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (523, 425);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (525, 9);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (528, 166);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (529, 86);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (531, 313);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (531, 345);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (533, 330);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (533, 395);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (534, 182);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (534, 902);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (541, 249);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (542, 385);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (542, 920);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (543, 863);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (544, 99);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (547, 446);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (548, 444);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (554, 841);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (555, 232);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (555, 366);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (556, 766);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (557, 123);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (559, 868);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (560, 203);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (560, 526);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (561, 468);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (562, 556);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (562, 755);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (565, 918);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (566, 462);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (567, 52);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (568, 95);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (568, 171);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (571, 595);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (571, 850);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (572, 182);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (573, 742);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (578, 177);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (580, 865);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (581, 919);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (582, 292);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (583, 297);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (585, 165);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (586, 461);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (586, 543);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (586, 891);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (587, 399);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (587, 489);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (588, 221);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (590, 218);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (594, 167);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (596, 397);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (597, 248);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (598, 724);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (600, 983);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (601, 630);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (603, 757);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (608, 338);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (608, 949);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (611, 103);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (612, 880);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (614, 104);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (616, 317);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (617, 87);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (617, 301);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (617, 513);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (618, 786);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (619, 882);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (620, 720);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (621, 129);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (622, 935);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (623, 555);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (630, 292);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (630, 923);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (632, 959);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (633, 547);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (634, 312);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (635, 322);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (635, 402);
commit;
prompt 500 records committed...
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (635, 434);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (637, 477);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (638, 212);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (638, 630);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (639, 768);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (641, 418);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (642, 475);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (642, 481);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (647, 270);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (647, 553);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (649, 359);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (653, 462);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (655, 741);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (657, 873);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (657, 959);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (660, 375);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (660, 866);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (661, 538);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (662, 304);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (662, 436);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (664, 473);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (665, 332);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (665, 639);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (666, 158);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (668, 536);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (669, 29);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (669, 834);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (672, 596);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (672, 873);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (673, 156);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (673, 417);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (673, 629);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (676, 146);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (676, 742);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (678, 505);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (678, 660);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (678, 903);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (682, 162);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (682, 511);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (683, 362);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (684, 239);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (684, 790);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (684, 808);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (685, 308);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (685, 418);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (685, 818);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (686, 64);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (686, 294);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (687, 19);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (690, 235);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (690, 856);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (691, 154);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (694, 473);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (695, 724);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (697, 112);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (698, 37);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (698, 364);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (698, 416);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (699, 521);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (701, 843);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (702, 434);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (705, 179);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (707, 919);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (707, 944);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (708, 232);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (710, 499);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (712, 238);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (712, 309);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (713, 667);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (717, 585);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (717, 619);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (717, 834);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (718, 13);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (718, 490);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (718, 674);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (718, 907);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (719, 457);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (719, 703);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (720, 368);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (722, 690);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (723, 138);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (726, 291);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (726, 389);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (727, 229);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (728, 206);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (728, 659);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (729, 638);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (729, 666);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (730, 194);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (730, 586);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (731, 266);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (734, 155);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (736, 866);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (741, 248);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (744, 665);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (744, 776);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (748, 151);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (748, 787);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (751, 1004);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (751, 1005);
commit;
prompt 600 records committed...
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (756, 70);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (761, 182);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (762, 215);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (766, 265);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (767, 975);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (771, 600);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (771, 633);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (771, 711);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (773, 225);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (779, 96);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (779, 347);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (781, 558);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (785, 7);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (785, 430);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (786, 591);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (787, 37);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (790, 120);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (790, 714);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (791, 237);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (794, 272);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (794, 748);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (796, 619);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (796, 816);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (797, 34);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (797, 830);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (797, 888);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (798, 406);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (800, 12);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (800, 60);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (802, 94);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (803, 681);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (803, 713);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (804, 7);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (804, 942);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (805, 184);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (805, 465);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (806, 880);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (811, 987);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (812, 580);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (813, 110);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (813, 691);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (813, 993);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (814, 773);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (814, 992);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (815, 13);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (815, 615);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (816, 885);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (817, 689);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (819, 125);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (822, 239);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (822, 487);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (824, 509);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (827, 109);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (829, 1004);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (829, 1005);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (834, 623);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (838, 333);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (838, 721);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (839, 878);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (842, 662);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (844, 761);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (845, 197);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (846, 623);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (846, 845);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (848, 762);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (849, 83);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (849, 443);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (854, 547);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (858, 647);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (861, 472);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (862, 340);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (864, 129);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (865, 658);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (866, 214);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (869, 480);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (872, 174);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (873, 278);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (874, 796);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (875, 22);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (875, 784);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (876, 131);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (879, 254);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (881, 79);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (881, 702);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (881, 723);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (886, 708);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (888, 608);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (889, 995);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (891, 511);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (892, 301);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (892, 419);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (893, 339);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (895, 122);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (895, 776);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (895, 864);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (895, 891);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (896, 591);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (899, 494);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (901, 400);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (904, 310);
commit;
prompt 700 records committed...
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (904, 388);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (905, 745);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (906, 81);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (906, 127);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (910, 46);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (910, 933);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (915, 43);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (916, 259);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (916, 967);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (920, 196);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (921, 932);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (922, 738);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (924, 248);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (927, 80);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (928, 760);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (930, 166);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (930, 249);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (930, 484);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (933, 297);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (934, 195);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (934, 211);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (936, 186);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (939, 400);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (939, 892);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (940, 460);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (941, 881);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (941, 929);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (942, 544);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (942, 818);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (943, 114);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (945, 28);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (947, 656);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (950, 426);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (950, 799);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (954, 905);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (955, 117);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (960, 45);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (960, 654);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (960, 681);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (961, 896);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (962, 127);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (963, 174);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (963, 622);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (964, 550);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (966, 680);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (966, 811);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (966, 973);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (968, 610);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (971, 271);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (971, 445);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (972, 722);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (974, 177);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (974, 774);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (976, 86);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (979, 485);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (979, 936);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (980, 39);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (980, 493);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (980, 890);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (983, 111);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (986, 775);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (990, 137);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (991, 481);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (991, 830);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (993, 881);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (994, 201);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (999, 945);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (999, 970);
insert into MEDICATION_TREATMENT (medicationid, treatmentid)
values (1000, 899);
commit;
prompt 769 records loaded
prompt Enabling foreign key constraints for DOCTOR...
alter table DOCTOR enable constraint FK_DOCTOR_DEPARTMENT;
prompt Enabling foreign key constraints for ROOM...
alter table ROOM enable constraint FK_ROOM_DEPARTMENT;
prompt Enabling foreign key constraints for PATIENT...
alter table PATIENT enable constraint FK_PATIENT_ROOM;
prompt Enabling foreign key constraints for TREATMENT...
alter table TREATMENT enable constraint FK_TREATMENT_DOCTOR;
alter table TREATMENT enable constraint FK_TREATMENT_PATIENT;
prompt Enabling foreign key constraints for MEDICATION_TREATMENT...
alter table MEDICATION_TREATMENT enable constraint FK_MEDICATION_TREATMENT_TREATMENT;
alter table MEDICATION_TREATMENT enable constraint SYS_C008415;
prompt Enabling triggers for DEPARTMENT...
alter table DEPARTMENT enable all triggers;
prompt Enabling triggers for DOCTOR...
alter table DOCTOR enable all triggers;
prompt Enabling triggers for MEDICATION...
alter table MEDICATION enable all triggers;
prompt Enabling triggers for ROOM...
alter table ROOM enable all triggers;
prompt Enabling triggers for PATIENT...
alter table PATIENT enable all triggers;
prompt Enabling triggers for TREATMENT...
alter table TREATMENT enable all triggers;
prompt Enabling triggers for MEDICATION_TREATMENT...
alter table MEDICATION_TREATMENT enable all triggers;

set feedback on
set define on
prompt Done
