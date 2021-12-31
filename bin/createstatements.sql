drop database github;
create database github;

\c github

create table Project(
P_RID int,
Description varchar(200),
Progress_Bar int,
P_Company_ID int,
PRIMARY KEY (P_RID));

create table Repository(
RID int,
Remote_RID int not null,
Owns int,
Hours int,
PRIMARY KEY (RID));


create table Company(
Company_ID int ,
Company_Description varchar(200),
Location varchar(200),
PRIMARY KEY (Company_ID));

create table Branch(
BID int,
B_RID int,
Timestamp time not null,
latest_VID int,
latest_V_BID int,
latest_V_B_RID int,
parent_BID int,
parent_B_RID int, 
PRIMARY KEY(BID,B_RID));

create table Employs(
E_user_ID int,
E_Company_ID int,
Salary numeric(10,2) not null,
PRIMARY KEY(E_user_ID));

create table Developer(
User_ID int,
Password varchar(30) not null,
PRIMARY KEY (User_ID));

create table Version(
VID int,
V_BID int,
V_B_RID int,
V_User_ID int,
PRIMARY KEY (VID,V_BID,V_B_RID));

create table Contains(
Contains_VID int,
Contains_V_BID int,
Contains_V_B_RID int,
COntains_FID int,
PRIMARY KEY (Contains_VID,Contains_V_BID,Contains_V_B_RID));

create table File(
FID int,
file_name varchar(30) not null,
type varchar(10),
file_contains text,
file_size int not null,
PRIMARY KEY(FID)
);

