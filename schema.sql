-- DDL Generated from https:/databasediagram.com

CREATE TABLE Organization (
  Id varchar(50) PRIMARY KEY,
  Name varchar(100),
  URL varchar(100),
  EmailAddress varchar(200),
  Contact varchar(100),
  Logo varchar(200),
  Address text,
  City varchar(100),
  Country varchar(100),
  GoogleLocation varchar(200),
  IsActive bool
);

CREATE TABLE User_Primary_Info (
  Id varchar(50) PRIMARY KEY,
  FirstName varchar(200),
  LastName varchar(200),
  EmailAddress varchar(200),
  ContactNumber varchar(25),
  Password bytea,
  Locate varchar(150),
  PasswordLastUpdatedAt timestamp,
  PreferredLang varchar(10),
  CreatedAt timestamp
);

CREATE TABLE User_Work_Info (
  Id varchar(50) PRIMARY KEY,
  OrgId varchar(50) REFERENCES Organization(Id),
  UserId varchar(50) REFERENCES User_Primary_Info(Id),
  DepartmentId varchar(50),
  EmployeeID varchar(50),
  Location varchar(150),
  DesignationId varchar(50),
  RoleId varchar(50),
  EmploymentTypeId varchar(50),
  DateOfJoining date,
  DateofExit date,
  ReportingManager varchar(50),
  Status varchar(50),
  IsActive bool
);

CREATE TABLE User_Personal_Details (
  Id varchar(50) PRIMARY KEY,
  UserId varchar(50) REFERENCES User_Primary_Info(Id),
  DateOfBirth Date,
  Age int,
  GenderId varchar(50),
  MaritalStatusId varchar(50),
  AboutMe text
);

CREATE TABLE MaritalStatus (
  Id varchar(50) PRIMARY KEY,
  OrgId varchar(50),
  MaritalStatus varchar(50),
  CreatedBy varchar(50),
  CreatedDate timestamp
);

CREATE TABLE Gender (
  Id varchar(50) PRIMARY KEY,
  OrgId varchar(50),
  Gender varchar(50),
  CreatedBy varchar(50),
  CreatedDate timestamp
);

CREATE TABLE EmploymentType (
  Id varchar(50) PRIMARY KEY,
  OrgId varchar(50) NOT NULL,
  Type jsonb NOT NULL,
  CreatedBy varchar(50),
  CreatedDate timestamp
);

CREATE TABLE Department (
  Id varchar(50) PRIMARY KEY,
  OrgId varchar(50),
  Department jsonb NOT NULL,
  CreatedBy varchar(50),
  CreatedDate timestamp
);

CREATE TABLE Role (
  Id varchar(50) PRIMARY KEY,
  OrgId varchar(50),
  Name varchar(250),
  Permission jsonb,
  Type varchar(20),
  IsActive bool
);

CREATE TABLE User_Role_Map (
  Id varchar(50) PRIMARY KEY,
  RoleId varchar(50) REFERENCES Role(Id),
  UserId varchar(50) REFERENCES User_Primary_Info(Id),
  Date date
);

CREATE TABLE Designation (
  Id varchar(50) PRIMARY KEY,
  OrgId varchar(50) REFERENCES Organization(Id),
  Designation jsonb NOT NULL,
  CreatedBy varchar(50),
  CreatedDate timestamp
);

CREATE TABLE User_Designation_Map (
  Id varchar(50) PRIMARY KEY,
  UserId varchar(50),
  DesignationId varchar(50)
);

CREATE TABLE Emotion (
  Id varchar(50) PRIMARY KEY,
  Name varchar(100),
  IsAtive bool
);

CREATE TABLE User_Emotion_Map (
  Id varchar(50) PRIMARY KEY,
  EmotionId varchar(50) REFERENCES Emotion(Id),
  Date date,
  UserId varchar(50) REFERENCES User_Primary_Info(Id)
);

CREATE TABLE User_Contact_Info (
  Id varchar(50) PRIMARY KEY,
  Userid varchar(50) REFERENCES User_Primary_Info(Id),
  Work_Phone_No int,
  Extension int,
  Personal_Mobile_No int,
  Emergency_Contact_No int,
  Personal_Email_Address varchar(200),
  Present_Address text,
  Permanent_Address text,
  CreatedDate timestamp,
  UpdatedDate timestamp
);

CREATE TABLE User_Work_Exp_Info (
  Id varchar(50) PRIMARY KEY,
  Userid varchar(50) REFERENCES User_Primary_Info(Id),
  Details jsonb,
  CreatedDate timestamp,
  UpdatedDate timestamp
);

CREATE TABLE User_Education_Det_Info (
  Id varchar(50) PRIMARY KEY,
  Userid varchar(50) REFERENCES User_Primary_Info(Id),
  Details jsonb,
  CreatedDate timestamp,
  UpdatedDate timestamp
);

CREATE TABLE M_RoleType (
  Id varchar(50) PRIMARY KEY,
  title varchar(50) NOT NULL
);

CREATE TABLE m_permission (
  Id int PRIMARY KEY,
  Permission varchar(50) NOT NULL
);

CREATE TABLE m_module (
  Id varchar(50) PRIMARY KEY,
  Module varchar(50) NOT NULL
);

CREATE TABLE holiday (
  Id varchar(50) NOT NULL PRIMARY KEY,
  OrgId varchar(50) REFERENCES Organization(Id),
  Name varchar(100) NOT NULL,
  Description text,
  Date date NOT NULL,
  Mandatory bool,
  ApplicableFor jsonb,
  CreatedBy varchar(50),
  CreatedDate timestamp
);

CREATE TABLE PasswordSetLog (
  Id varchar(50) NOT NULL PRIMARY KEY,
  RequestedAt timestamp NOT NULL,
  EmailTriggeredAt timestamp,
  EmailBounceBack bool,
  ResettedAt timestamp
);

CREATE TABLE Team (
  Id varchar(50) NOT NULL PRIMARY KEY,
  OrgId varchar(50) REFERENCES Organization(Id),
  ShortName varchar(200) NOT NULL,
  Name varchar(200) NOT NULL,
  Description text,
  technologies jsonb,
  CreatedBy varchar(50),
  CreatedDate timestamp
);

CREATE TABLE User_Team_Map (
  Id varchar(50) NOT NULL PRIMARY KEY,
  TeamId varchar(50) REFERENCES Team(Id),
  UserId varchar(50) REFERENCES User_Primary_Info(Id),
  Date timestamp
);

CREATE TABLE otp (
  Id varchar(50) NOT NULL PRIMARY KEY,
  UserId varchar(50) REFERENCES User_Primary_Info(Id),
  MobileNumber varchar(50),
  otp int,
  response varchar(250),
  status varchar(50),
  createddate timestamp
);

CREATE TABLE CheckInLog (
  Id varchar(50) NOT NULL PRIMARY KEY,
  UserId varchar(50) REFERENCES User_Primary_Info(Id),
  CheckIn date NOT NULL,
  CheckInTime varchar(20),
  CheckInMedium varchar(20),
  CheckOut date,
  CheckOutTime varchar(20),
  CheckOutMedium varchar(20),
  CreatedBy varchar(50),
  CreatedAt timestamp,
  UpdatedAt timestamp
);

CREATE TABLE AttendanceSetting (
  Id varchar(50) NOT NULL PRIMARY KEY,
  OrgId varchar(50) REFERENCES Organization(Id),
  Type varchar(50) NOT NULL,
  IsAutoApprovalEnabled bool,
  Description text,
  Settings jsonb,
  PrimaryApproverId varchar(50),
  Andor varchar(5) NOT NULL,
  SecondaryApproverId varchar(50),
  CreatedBy varchar(50),
  UpdatedBy varchar(50),
  CreatedAt timestamp,
  UpdatedAt timestamp
);

CREATE TABLE CheckInApproval (
  CheckInLogId varchar(50) NOT NULL PRIMARY KEY,
  AttendanceSettingId varchar(50) REFERENCES AttendanceSetting(Id),
  PrimaryApproverID varchar(50),
  PrimaryApprovalStatus varchar(50),
  PrimaryApprovalDate timestamp,
  SecondaryApproverID varchar(50),
  SecondaryApprovalStatus varchar(50),
  SecondaryApprovalDate timestamp
);

CREATE TABLE Attendance (
  Id varchar(50) NOT NULL PRIMARY KEY,
  UserId varchar(50) REFERENCES User_Primary_Info(Id),
  FromDate timestamp,
  ToDate timestamp,
  Hours varchar(50),
  CreatedAt timestamp
);

CREATE TABLE LeaveType (
  Id varchar(50) NOT NULL PRIMARY KEY,
  OrgId varchar(50) REFERENCES Organization(Id),
  Name varchar(200) NOT NULL,
  Description text,
  Validity jsonb,
  IsReplicableNextYear bool,
  type varchar(50),
  creditschedule varchar(50),
  EmploymentType jsonb,
  GenderID jsonb,
  OfficeLocation jsonb,
  InitialCreditType varchar(100),
  InitialCredit int,
  Encash bool,
  EncashType varchar(100),
  EncashLimit varchar(200),
  EncashReleasePeriod bool,
  Carryforward bool,
  CarryForwardMaxlimit int,
  CarryForwardType varchar(200),
  CreatedAt varchar(50),
  CreatedBy varchar(50),
  UpdatedAt varchar(50),
  UpdatedBy varchar(50)
);

CREATE TABLE OfficeLocation (
  Id varchar(50) NOT NULL PRIMARY KEY,
  OrgId varchar(50) REFERENCES Organization(Id),
  Location varchar(250),
  Country varchar(250),
  State varchar(250),
  CreatedBy varchar(50),
  CreatedAt varchar(50),
  UpdatedBy varchar(50),
  UpdatedAt varchar(50)
);


INSERT INTO m_permission (id, permission) VALUES (1, 'read');
INSERT INTO m_permission (id, permission) VALUES (2, 'create');
INSERT INTO m_permission (id, permission) VALUES (3, 'edit');
INSERT INTO m_permission (id, permission) VALUES (4, 'delete');
INSERT INTO m_permission (id, permission) VALUES (5, 'full');
INSERT INTO m_permission (id, permission) VALUES (6, 'adduser');
INSERT INTO m_permission (id, permission) VALUES (7, 'removeuser');

CREATE UNIQUE INDEX Unique_IdOnPermission ON m_permission( id );


INSERT INTO m_module (id, module) VALUES (1, 'employee');
INSERT INTO m_module (id, module) VALUES (2, 'role');
INSERT INTO m_module (id, module) VALUES (3, 'department');
INSERT INTO m_module (id, module) VALUES (4, 'designation');
INSERT INTO m_module (id, module) VALUES (5, 'attendance');
INSERT INTO m_module (id, module) VALUES (6, 'leavetype');
INSERT INTO m_module (id, module) VALUES (7, 'holiday');
INSERT INTO m_module (id, module) VALUES (8, 'employmenttype');
INSERT INTO m_module (id, module) VALUES (9, 'team');

CREATE UNIQUE INDEX Unique_IdOnModule ON m_module( id );

CREATE UNIQUE INDEX Unique_IdOnUserWorkInfo ON user_work_info( id );
CREATE UNIQUE INDEX UniqueDesignationOrgID ON designation (orgid);

CREATE UNIQUE INDEX Unique_ValueOnHoliday ON holiday( orgid, name );
CREATE UNIQUE INDEX Unique_IdOnHoliday ON holiday( id );

INSERT INTO m_roletype (id, title) VALUES ('797spdmz7m0y', 'standard');
INSERT INTO m_roletype (id, title) VALUES ('qc7de6rck8wc', 'custom');

CREATE UNIQUE INDEX Unique_OrgIdOnRoleType ON designation( orgid );

CREATE UNIQUE INDEX Unique_OrgIdOnEmploymentType ON employmenttype( orgid );
CREATE UNIQUE INDEX Unique_OrgIdOnDepartment ON department( orgid );
