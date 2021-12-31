drop database github;
create database github;

\c github

create table Company(
Company_ID int ,
Company_Description varchar(200),
Location varchar(200),
PRIMARY KEY (Company_ID));

create table Project(
P_RID int,
Description varchar(200),
Progress_Bar int,
P_Company_ID int,
PRIMARY KEY (P_RID));

create table Developer(
User_ID int,
Password varchar(30) not null,
PRIMARY KEY (User_ID));

create table Employs(
E_user_ID int,
E_Company_ID int,
Salary numeric(10,2) not null,
PRIMARY KEY(E_user_ID));

create table Repository(
RID int,
Remote_RID int,
Owns int,
Hours int,
PRIMARY KEY (RID));

create table Branch(
BID int,
B_RID int,
Timestamp time not null,
parent_BID int,
parent_B_RID int, 
PRIMARY KEY(BID,B_RID));

create table Holds(
BID int,
B_RID int,
VID int,
V_rem_repo_ID int,
Rank int,
PRIMARY KEY(BID,B_RID,VID,V_rem_repo_ID)
);

create table Version(
VID int,
V_rem_repo_ID int,
V_User_ID int,
PRIMARY KEY (VID, V_rem_repo_ID));

create table Contains(
Contains_VID int,
Contains_V_rem_repo_ID int,
Contains_FID int,
PRIMARY KEY (Contains_VID,Contains_V_rem_repo_ID,Contains_FID));

create table File(
FID int,
file_name varchar(30) not null,
type varchar(10),
file_contains text,
file_size int not null,
PRIMARY KEY(FID)
);

