drop database Github;
create database Github;
\c github;

drop table if exists branch cascade;
drop table if exists company cascade;
drop table if exists contains cascade;
drop table if exists developer cascade;
drop table if exists employs cascade;
drop table if exists file cascade;
drop table if exists holds cascade;
drop table if exists project cascade;
drop table if exists repository cascade;
drop table if exists version cascade;



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
E_user_ID int not null,
E_Company_ID int not null,
Salary numeric(10,2) not null
--,PRIMARY KEY(E_user_ID)
);

create table Repository(
RID int,
Remote_RID int,
Owns int,
Hours int,
PRIMARY KEY (RID));

create table Branch(
BID int,
B_RID int,
Time_Stamp timestamp with time zone not null,
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
COntains_FID int,
PRIMARY KEY (Contains_VID,Contains_V_rem_repo_ID,contains_fid)); --- different from createStatements here

create table File(
FID int,
file_name varchar(30) not null,
type varchar(10),
file_contains text,
file_size int not null,
PRIMARY KEY(FID)
);

--- ### Inserting ###

INSERT into Holds values
(1,1,1,1,1),
(2,1,2,1,1),
(1,1,3,1,2),
(1,4,1,1,1),
(2,4,2,1,1),
(1,5,1,1,1),
(2,5,2,1,1),
(4,5,4,1,1),
(1,6,1,1,1),
(2,6,2,1,1),
(3,6,5,1,1),
(1,2,1,2,1),
(2,2,3,2,1),
(1,7,1,2,1),
(1,7,2,2,2),
(2,7,3,2,1),
(4,7,4,2,1),
(1,8,1,2,1),
(2,8,3,2,1),
(3,8,5,2,1),
(1,3,1,3,1),
(1,9,1,3,1),
(2,9,2,3,1),
(3,9,3,3,1),
(1,10,1,3,1),
(2,10,4,3,1),
(4,10,5,3,1),
(1,11,1,11,1),
(2,11,2,11,1),
(4,11,4,11,1),
(1,12,1,11,1),
(2,12,2,11,1),
(3,12,3,11,1),
(4,12,4,11,1),
(5,12,5,11,1),
(1,4,3,1,1);

INSERT into Contains values
(1,1,1),
(1,1,2),
(1,1,4),
(2,1,1),
(2,1,2),
(2,1,5),
(3,1,1),
(3,1,3),
(3,1,4),
(4,1,1),
(4,1,3),
(4,1,5),
(5,1,1),
(5,1,2),
(1,2,6),
(1,2,7),
(1,2,9),
(2,2,6),
(2,2,8),
(2,2,9),
(3,2,6),
(3,2,7),
(3,2,10),
(4,2,6),
(4,2,8),
(4,2,10),
(5,2,6),
(5,2,9),
(1,3,11),
(1,3,12),
(1,3,14),
(2,3,11),
(2,3,12),
(2,3,15),
(3,3,11),
(3,3,13),
(3,3,14),
(4,3,11),
(4,3,13),
(4,3,15),
(5,3,1),
(5,3,15),
(1,11,16),
(1,11,17),
(2,11,16),
(2,11,18),
(3,11,16),
(3,11,19),
(4,11,16),
(4,11,20),
(5,11,16),
(5,11,21);

INSERT into File values
(1,'read','md','file_desc1',100),
(2,'sub','c','file_desc2',500),
(3,'sub','c','file_desc3',540),
(4,'subh','h','file_desc4',300),
(5,'subh','h','file_desc5',310),
(6,'read','md','file_desc6',120),
(7,'solve','py','file_desc7',600),
(8,'solve','py','file_desc8',610),
(9,'test','py','file_desc9',450),
(10,'test','py','file_desc10',410),
(11,'read','md','file_desc11',150),
(12,'ddl','sql','file_desc12',300),
(13,'ddl','sql','file_desc13',350),
(14,'dml','sql','file_desc14',700),
(15,'dml','sql','file_desc15',750),
(16,'read','md','file_desc16',70),
(17,'report','doc','file_desc17',500),
(18,'report','doc','file_desc18',550),
(19,'report','doc','file_desc19',570),
(20,'report','doc','file_desc20',600),
(21,'report','doc','file_desc21',620);

INSERT into Project values
(1,'proj_desc_1',50,1),
(2,'proj_desc_2',40,2),
(3,'proj_desc_3',60,2),
(11,'proj_desc_4',70,null);

insert into company values
(1,'Comp_desc1','loc1'),
(2,'Comp_desc2','loc2');

insert into employs values
(1,1,1500),
(2,1,1400),
(3,1,1200),
(5,2,1700),
(6,2,1600),
(7,2,1900);

insert into Developer values
(1,'password1'),
(2,'password2'),
(3,'password3'),
(4,'password4'),
(5,'password5'),
(6,'password6'),
(7,'password7'),
(8,'password8');

insert into repository values
(1),
(2),
(3),
(11);

insert into repository values
(4,1,1,10),
(5,1,2,12),
(6,1,3,4),
(7,2,5,11),
(8,2,7,6),
(9,3,6,12),
(10,3,5,11),
(12,11,8,14);

insert into branch values
(1,	1,	'2021-10-21 04:05:06+05:30'),
(1,	4,	'2021-10-21 04:05:06+05:30'),
(1,	5,	'2021-10-21 04:05:06+05:30'),
(1,	6,	'2021-10-21 04:05:06+05:30'),
(1,	2,	'2021-10-21 01:01:01+05:30'),
(1,	7,	'2021-10-21 01:01:01+05:30'),
(1,	8,	'2021-10-21 01:01:01+05:30'),
(1,	3,	'2021-10-21 02:01:01+05:30'),
(1,	9,	'2021-10-21 02:01:01+05:30'),
(1,	10,	'2021-10-21 02:01:01+05:30'),
(1,	11,	'2021-10-21 03:00:59+05:30'),
(1,	12,	'2021-10-21 03:01:04+05:30');

insert into branch values
(2,	1,	'2021-10-21 04:05:07+05:30',	1,	1),
(3,	1,	'2021-10-21 04:05:08+05:30',	1,	1),
(4,	1,	'2021-10-21 04:05:09+05:30',	2,	1),
(2,	4,	'2021-10-21 04:05:07+05:30',	1,	4),
(2,	5,	'2021-10-21 04:05:07+05:30',	1,	5),
(4,	5,	'2021-10-21 04:05:09+05:30',	2,	5),
(2,	6,	'2021-10-21 04:05:07+05:30',	1,	6),
(3,	6,	'2021-10-21 04:05:08+05:30',	1,	6),
(2,	2,	'2021-10-21 01:01:02+05:30',	1,	2),
(3,	2,	'2021-10-21 01:01:03+05:30',	1,	2),
(4,	2,	'2021-10-21 01:01:04+05:30',	1,	2),
(2,	7,	'2021-10-21 01:01:02+05:30',	1,	7),
(4,	7,	'2021-10-21 01:01:04+05:30',	1,	7),
(2,	8,	'2021-10-21 01:01:02+05:30',	1,	8),
(3,	8,	'2021-10-21 01:01:03+05:30',	1,	8),
(2,	3,	'2021-10-21 02:01:02+05:30',	1,	3),
(3,	3,	'2021-10-21 02:01:03+05:30',	2,	3),
(4,	3,	'2021-10-21 02:01:04+05:30',	2,	3),
(2,	9,	'2021-10-21 02:01:02+05:30',	1,	9),
(3,	9,	'2021-10-21 02:01:03+05:30',	2,	9),
(2,	10,	'2021-10-21 02:01:02+05:30',	1,	10),
(4,	10,	'2021-10-21 02:01:04+05:30',	2,	10),
(2, 11, '2021-10-21 02:01:09+05:30',    1,  11),
(3,	11,	'2021-10-21 03:01:01+05:30',	2,	11),
(4,	11,	'2021-10-21 03:01:02+05:30',	1,	11),
(5,	11,	'2021-10-21 03:01:03+05:30',	4,	11),
(2,	12,	'2021-10-21 03:01:05+05:30',	1,	12),
(3,	12,	'2021-10-21 03:01:06+05:30',	2,	12),
(4,	12,	'2021-10-21 03:01:07+05:30',	1,	12),
(5,	12,	'2021-10-21 03:01:08+05:30',	4,	12);

insert into version values
(1,	1,	1),
(2,	1,	2),
(3,	1,	1),
(4,	1,	2),
(5,	1,	3),
(1,	2,	5),
(2,	2,	5),
(3,	2,	7),
(4,	2,	5),
(5,	2,	7),
(1,	3,	6),
(2,	3,	6),
(3,	3,	6),
(4,	3,	5),
(5,	3,	5),
(1,	11,	8),
(2,	11,	8),
(3,	11,	8),
(4,	11,	8),
(5,	11,	8);

--- ### Adding constraints ###

 

ALTER TABLE Developer add CHECK (LENGTH(Password)>=8);

ALTER TABLE Employs add constraint e_fk1 FOREIGN KEY (E_user_ID) REFERENCES Developer(User_ID) on DELETE CASCADE;
ALTER TABLE Employs add constraint e_fk2 FOREIGN KEY (E_Company_ID) REFERENCES Company(Company_ID) on DELETE CASCADE;

ALTER TABLE Project add constraint p_fk1 FOREIGN KEY (P_RID) REFERENCES Repository(RID) on DELETE SET NULL;
ALTER TABLE Project add constraint p_fk2 FOREIGN KEY (P_Company_ID) REFERENCES Company(Company_ID) on DELETE CASCADE;
ALTER TABLE Project add CHECK (Progress_Bar>=0);
ALTER TABLE Project add CHECK (Progress_Bar<=100);

ALTER TABLE Repository add constraint r_fk1 FOREIGN KEY (Remote_RID) REFERENCES Project(P_RID) on delete cascade;
ALTER TABLE Repository add constraint r_fk2 FOREIGN KEY (Owns) REFERENCES Developer(User_ID) on delete set null;
ALTER TABLE Repository add CHECK (hours>=0);

ALTER TABLE Branch add constraint b_fk1 FOREIGN KEY (B_RID) REFERENCES Repository(RID);
ALTER TABLE Branch add constraint b_fk2 FOREIGN KEY (parent_BID,parent_B_RID) REFERENCES Branch(BID,B_RID);

ALTER TABLE Holds add constraint h_fk1 FOREIGN KEY (BID,B_RID) REFERENCES Branch(BID,B_RID);
ALTER TABLE Holds add constraint h_fk2 FOREIGN KEY (VID,V_rem_repo_ID) REFERENCES Version(VID,V_rem_repo_ID);

ALTER TABLE Version add constraint v_fk1 FOREIGN KEY (V_User_ID) REFERENCES Developer(User_ID) ON DELETE SET NULL;

ALTER TABLE Contains add constraint c_fk1 FOREIGN KEY (Contains_VID,Contains_V_rem_repo_ID) REFERENCES Version(VID,V_rem_repo_ID);
ALTER TABLE Contains add constraint c_fk2 FOREIGN KEY (Contains_FID) REFERENCES File(FID);

ALTER TABLE File ALTER COLUMN type SET DEFAULT '.txt'; 



--- ### Transactions 1 ###
 
drop function if exists update_salary(empID int,cmpID int, newSalary int);
drop function if exists create_project(CmpID int, Description varchar(200));
drop function if exists create_branch(devID int, RepoID int, Parent_BranchID int);
drop function if exists Merge(Merge2_BID int, Merge1_BID int, RepoID int);
drop function if exists Commit(Create_NewVersion int, Commit_into_BID int, Commit_into_RepoID int, commit_file_name varchar(30), commit_file_type varchar(10), commit_file_contains text, commit_file_size int); 

---# function to update salary #
create or replace function update_salary(empID int,cmpID int, newSalary int)
returns int as $$
declare
    updated_val int;
begin
    UPDATE Employs
    SET Salary=newSalary
    WHERE E_user_ID=empID and E_Company_ID=cmpID;
    Select Salary into updated_val from Employs where E_user_ID=empID and E_Company_ID=cmpID;
    return updated_val;
end;
$$ language plpgsql;

---# function to create new project #
create or replace function create_project(CmpID int, Description varchar(200), empID int, empPassword varchar(30))
returns int as $$
declare
    New_P_RID int;
begin
    

    IF (SELECT(CmpID) IN (SELECT Company_ID FROM Company)) THEN

    SELECT (MAX(RID)+1) into New_P_RID from Repository;
        INSERT INTO Repository values (New_P_RID);
        INSERT INTO Project values (New_P_RID, Description, 0,CmpID);
        INSERT INTO Branch values (1,New_P_RID,CURRENT_TIMESTAMP(0),null,null);
        

        INSERT INTO Repository values (New_P_RID+1); -- inserting local repository for the individual developer.
            UPDATE Repository
                SET Owns=empID,remote_rid= New_P_RID, Hours=0 WHERE RID=New_P_RID+1; 
            INSERT INTO Branch values (1,New_P_RID+1,CURRENT_TIMESTAMP(0),null,null);

            RETURN New_P_RID; --returns remote repo ID
        

    ELSIF (SELECT(CmpID)=0) THEN
        IF (SELECT(empPassword) in (SELECT Password FROM Developer where User_ID=empID)) THEN
            SELECT (MAX(RID)+1) into New_P_RID from Repository;
            INSERT INTO Repository values (New_P_RID);
            INSERT INTO Project values (New_P_RID, Description, 0,null);
            INSERT INTO Branch values (1,New_P_RID,CURRENT_TIMESTAMP(0),null,null);

            INSERT INTO Repository values (New_P_RID+1); -- inserting local repository for the individual developer.
            UPDATE Repository
                SET Owns=empID,remote_rid= New_P_RID, Hours=0 WHERE RID=New_P_RID+1; 
            INSERT INTO Branch values (1,New_P_RID+1,CURRENT_TIMESTAMP(0),null,null);
            RETURN New_P_RID; --returns remote repo ID
        END IF;
        RAISE EXCEPTION 'Wrong UserID or Password' using hint = 'Enter Correct UserID or Password';
        RETURN -2;
    ELSE     
        RETURN -1;
    END IF;
end;
$$ language plpgsql;


---# function to create branch #
create or replace function create_branch(devID int, RepoID int, Parent_BranchID int)
returns int as $$
declare
    New_Branch_ID int;
    Remote_Repo_ID int;
begin
    IF (SELECT((SELECT COUNT(*) FROM Repository where RID=RepoID and Owns=devID)>0)) THEN
        SELECT Remote_RID into Remote_Repo_ID FROM Repository where RID=RepoID and Owns=devID;
        SELECT (MAX(BID)+1) into New_Branch_ID from Branch where B_RID=Remote_Repo_ID;
        INSERT INTO Branch values (New_Branch_ID,Remote_Repo_ID,CURRENT_TIMESTAMP(0),Parent_BranchID,Remote_Repo_ID); 
        INSERT INTO Branch values (New_Branch_ID,RepoID,CURRENT_TIMESTAMP(0),Parent_BranchID,RepoID);
        RETURN New_Branch_ID;
    ELSE 
        RETURN -1;
    END IF;    
end;
$$ language plpgsql;


---# function to merge #
create or replace function Merge(Merge2_BID int, Merge1_BID int, RepoID int) ---# Merge Branch2 into branch1
returns int as $$
declare
    REM_RepoID integer;
    New_VID integer;
    MAX_RANK1 integer; -- max rank of latest VID of branch 1
    MAX_RANK2 integer; -- max rank of latest VID of branch 2
    B1_latest_VID integer;
    B2_latest_VID integer;
    Max_Size integer;
    rec RECORD;
begin
    IF (SELECT(Merge1_BID) NOT IN (SELECT BID FROM Branch WHERE B_RID=RepoID)) THEN
        RETURN -1;
    END IF;
    IF (SELECT(Merge2_BID) NOT IN (SELECT BID FROM Branch WHERE B_RID=RepoID)) THEN
        RETURN -1;
    END IF;
    SELECT Remote_RID into REM_RepoID FROM Repository where RID=RepoID;
    SELECT MAX(Rank) into MAX_RANK1 FROM Holds where BID=Merge1_BID and B_RID=RepoID;
    SELECT MAX(Rank) into MAX_RANK2 FROM Holds where BID=Merge2_BID and B_RID=RepoID;
    SELECT VID into B1_latest_VID FROM Holds where BID=Merge1_BID and B_RID=RepoID and rank=MAX_RANK1;
    SELECT VID into B2_latest_VID FROM Holds where BID=Merge2_BID and B_RID=RepoID and rank=MAX_RANK2;

    SELECT MAX(VID)+1 INTO New_VID from Version where V_rem_repo_ID=REM_RepoID;
    INSERT INTO Version values (New_VID,REM_RepoID,(SELECT Owns from Repository where RID=RepoID));
    INSERT INTO Holds values (Merge1_BID,RepoID,New_VID,REM_RepoID,(MAX_RANK1+1));

    CREATE table ALL_Files_to_be_merged AS (SELECT f.fid,f.file_name,f.file_contains,f.file_size,f.type from File f,Contains c where c.Contains_V_rem_repo_ID=REM_RepoID and (c.Contains_VID=B1_latest_VID or c.Contains_VID=B2_latest_VID) and f.FID=c.Contains_FID); 
    FOR rec in (SELECT DISTINCT file_name FROM ALL_Files_to_be_merged) LOOP
        SELECT MAX(file_size) into Max_Size from ALL_Files_to_be_merged where file_name=rec.file_name;
        INSERT INTO Contains values 
            (New_VID,REM_RepoID,(Select DISTINCT FID from ALL_Files_to_be_merged where file_name=rec.file_name and file_size=Max_Size));
        END LOOP;
    DROP table ALL_Files_to_be_merged;    
    return New_VID; --return version number the new commit creates.
end;
$$ language plpgsql;



---# function to commit #
create or replace function Commit(Create_NewVersion int, Commit_into_BID int, Commit_into_RepoID int, commit_file_name varchar(30), commit_file_type varchar(10), commit_file_contains text, commit_file_size int) 
returns int as $$
declare
    latest_existing_version integer;
    New_Version integer;
    REM_RepoID integer;
    MAX_RANK1 integer default 0;
    New_FID integer;
begin
    SELECT Remote_RID into REM_RepoID FROM Repository where RID=Commit_into_RepoID;
    IF (Create_NewVersion=1) THEN -- create a new version
        SELECT MAX(VID)+1 INTO New_Version from Version where V_rem_repo_ID=REM_RepoID;
        --SELECT MAX(Rank) into MAX_RANK1 FROM Holds where BID=Commit_into_BID and B_RID=Commit_into_RepoID;
        IF (SELECT EXISTS(SELECT MAX(Rank) FROM Holds where BID=Commit_into_BID and B_RID=Commit_into_RepoID)) THEN
            SELECT MAX(Rank) into MAX_RANK1 FROM Holds where BID=Commit_into_BID and B_RID=Commit_into_RepoID;
        END IF;
        SELECT VID into latest_existing_version FROM Holds where BID=Commit_into_BID and B_RID=Commit_into_RepoID and rank=MAX_RANK1;
        INSERT INTO Version values (New_Version,REM_RepoID,(SELECT Owns from Repository where RID=Commit_into_RepoID));
        INSERT INTO Holds values (Commit_into_BID,Commit_into_RepoID,New_Version,REM_RepoID,(MAX_RANK1+1));
    
    ELSIF (Create_NewVersion=0) THEN -- add file to latest existing version.
        SELECT MAX(VID) INTO New_Version from Version where V_rem_repo_ID=REM_RepoID;
    ELSE -- if Create_NewVersion not either 1 or 0, return -1 indicating wrong input
        RETURN -1;
    END IF;

    SELECT MAX(FID)+1 INTO New_FID FROM File;
    INSERT INTO File values 
    (New_FID, commit_file_name, commit_file_type, commit_file_contains, commit_file_size);
    INSERT INTO Contains values (New_Version,REM_RepoID,New_FID);
    RETURN New_Version; --return version number of the commit.
end;
$$ language plpgsql;


--- ### DEV ###

drop function if exists create_developer (Pass character varying);

create or replace function create_developer(Pass character varying)
returns int as $$
declare
    dev int;
begin
    SELECT (MAX(User_ID)+1) into dev from Developer;
    INSERT INTO Developer(User_ID, Password)
    VALUES (dev, pass);
    return dev;
end;
$$ language plpgsql;




drop function if exists create_company (comp_des varchar,comp_loc varchar);

create or replace function create_company (comp_des varchar,comp_loc varchar)
returns int as $$
declare
    comp int;
begin
    SELECT (MAX(Company_ID)+1) into comp from Company;
    INSERT INTO Company (Company_ID, Company_Description ,Location)
    VALUES (comp, comp_des,comp_loc);
    return comp;
end;

$$ language plpgsql;




-- create or replace function create_project(CmpID int, Description varchar(200))
-- returns int as $$
-- declare
--     New_P_RID int;
-- begin
--     IF (SELECT(CmpID) IN (SELECT Company_ID FROM Company)) THEN
--         SELECT (MAX(RID)+1) into New_P_RID from Repository;
--         INSERT INTO Repository values (New_P_RID);
--         INSERT INTO Project values (New_P_RID, Description, 0,CmpID);
--         INSERT INTO Branch values (1,New_P_RID,CURRENT_TIMESTAMP(0),null,null);
--         RETURN New_P_RID;
--     ELSE 
--         RETURN -1;
--     END IF;
-- end;
-- $$ language plpgsql;



create or replace function recruiting (empid int , CmpID int , salary numeric(10,2))
returns int as $$
declare
    r int;
begin
    IF ((SELECT(CmpID) IN (SELECT Company_ID FROM Company))  and (SELECT(empid) IN (SELECT User_ID FROM Developer))  and  ((SELECT(empid) NOT IN (SELECT E_User_ID FROM Employs)) and  (SELECT(CmpID) NOT IN (SELECT E_Company_ID FROM Employs))) )  THEN
            INSERT INTO Employs values (empid,CmpID,salary);
            RETURN 1;
    ELSE 
        RETURN -1;
    END IF;
end;
$$ language plpgsql;




create or replace function create_branch(devID int, RepoID int, Parent_BranchID int)
returns int as $$
declare
    New_Branch_ID int;
    Remote_Repo_ID int;
begin
    IF ((SELECT COUNT(*) FROM Repository where RID=RepoID and Owns=devID)>0) THEN
        SELECT Remote_RID into Remote_Repo_ID FROM Repository where RID=RepoID and Owns=devID;
        SELECT (MAX(BID)+1) into New_Branch_ID from Branch where B_RID=Remote_Repo_ID;
        INSERT INTO Branch values (New_Branch_ID,Remote_Repo_ID,CURRENT_TIMESTAMP(0),Parent_BranchID,Remote_Repo_ID); 
        INSERT INTO Branch values (New_Branch_ID,RepoID,CURRENT_TIMESTAMP(0),Parent_BranchID,RepoID);
        RETURN New_Branch_ID;
    ELSE 
        RETURN -1;
    END IF;    
end;
$$ language plpgsql;;





--- ### Pull Push ###

create or replace function pull (devID int, RepoID int)
returns int as $$
declare
    Remote_Repo_ID int;
    c int;
    c1 int;
    t timestamp with time zone;
begin
    t=CURRENT_TIMESTAMP(0);
    IF (SELECT (SELECT COUNT(*) FROM Repository where RID=RepoID and Owns=devID) >0 )  THEN
        SELECT Remote_RID into Remote_Repo_ID FROM Repository where RID=RepoID and Owns=devID;
        INSERT INTO Branch 

        select distinct h1.BID  ,RepoID as B_RID, t as Time_Stamp ,h1.parent_BID,h1.parent_B_RID from (SELECT *  FROM branch WHERE b_rid=Remote_Repo_ID) h1, (Select  b.bid from (SELECT *  FROM Holds WHERE b_rid=Remote_Repo_ID) b,(SELECT vid  FROM Holds WHERE b_rid=Remote_Repo_ID EXCEPT SELECT vid  FROM Holds WHERE b_rid=RepoID) v where  v.vid=b.vid EXCEPT select BID from branch where B_rid=RepoID) h2  where h1.bid=h2.bid;
        INSERT INTO Holds (bid , b_rid , vid , v_rem_repo_id ,rank)
        Select  b.bid,RepoID as B_RID,b.vid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=Remote_Repo_ID) b,(SELECT vid  FROM Holds WHERE b_rid=Remote_Repo_ID EXCEPT SELECT vid  FROM Holds WHERE b_rid=RepoID) v where  v.vid=b.vid;
        return 1;
    ELSE 
        RETURN -1;
    END IF;
end;
$$ language plpgsql;





create or replace function push (devID int, RepoID int)
returns int as $$
declare
    Remote_Repo_ID int;
    c int;
    c1 int;
    t timestamp with time zone;
begin
    t=CURRENT_TIMESTAMP(0);
    IF (SELECT (SELECT COUNT(*) FROM Repository where RID=RepoID and Owns=devID) >0 )  THEN
        SELECT Remote_RID into Remote_Repo_ID FROM Repository where RID=RepoID and Owns=devID;
        INSERT INTO Holds (bid , b_rid , vid , v_rem_repo_id ,rank)
        Select  b.bid,Remote_Repo_ID as B_RID,b.vid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=RepoID) b,(SELECT vid  FROM Holds WHERE b_rid=RepoID EXCEPT SELECT vid  FROM Holds WHERE b_rid=Remote_Repo_ID) v where  v.vid=b.vid;
        return 1;
    ELSE 
        RETURN -1;
    END IF;
end;
$$ language plpgsql;


--- ### Analysis
drop function if exists sq1_main(r_rid int);
drop function if exists sq2_main(r_rid int);
drop function if exists sq3_main(r_rid int);
drop function if exists sq4_main(ty varchar);
drop function if exists sq5_main(c_id int);


--- ### Task 1: user who makes the most versions in a project###

create or replace function sq1_main(r_rid int)
returns int
language plpgsql
as
$$
declare 
	ans integer;
	maxi integer;
begin
	create table temp0 as
	select v_user_id,count(v_user_id) as cnt
	from version
	where v_rem_repo_id = r_rid
	group by v_user_id;
	
	select max(cnt)
	into maxi
	from temp0;

	select
		v_user_id
	into ans
	from temp0
	where
		cnt = maxi;
		
	drop table temp0;
	return ans;
end;
$$;

--- ### Task 2: Version belonging to most branches in a project ###

create or replace function sq2_main(r_rid int)
returns int
language plpgsql
as
$$
declare 
	ans integer;
	maxi integer;
begin
	create table temp0 as
	select vid,count(vid) as cnt
	from holds
	where v_rem_repo_id = r_rid
	group by vid;

	select max(cnt)
	into maxi
	from temp0;

	select vid
	into ans
	from temp0
	where cnt = maxi;

	return ans;
end;
$$;


--- ### Task 3: File belonging to most versions in a project ###

create or replace function sq3_main(r_rid int)
returns int
language plpgsql
as
$$
declare 
	ans integer;
	maxi integer;
begin
	create table temp0 as
	select contains_fid,count(contains_fid) as cnt
	from contains
	where contains_v_rem_repo_id = r_rid
	group by contains_fid;

	select max(cnt)
	into maxi
	from temp0;

	select contains_fid
	into ans
	from temp0
	where cnt = maxi;
	drop table temp0;
	return ans;
end;
$$;

--- select sq3_main(1);

--- ### Task 4: Average size of a file with a specified type###

create or replace function sq4_main(ty varchar)
returns float
language plpgsql
as
$$
declare 
	ans float;
begin
	select avg(file_size)
	into ans
	from file
	where type = ty;

	return ans;
end;
$$;


--- select sq4_main('py');


--- ### Task 5: Average salary of a company ###

create or replace function sq5_main(c_id int)
returns float
language plpgsql
as
$$
declare 
	ans float;
begin
	select avg(salary)
	into ans
	from employs
	where e_company_id = c_id;

	return ans;
end;
$$;
	
-- Complex Queries

drop function if exists n_hrs_emp(e_id int);
drop function if exists q1_main(r_rid int);
drop function if exists q2_main(r_rid int);
drop function if exists q3_main(r_rid int);
drop function if exists n_hrs_project(r_rid int);
drop function if exists n_hrs_left_project(r_rid int);
drop function if exists q4_main(c_id int);
drop function if exists repo_size(repo_id int);
drop function if exists q5_main();



---### Task 1: Find the total cost of a project with remote repo id (creation of a function) ###

--- main idea: n_hrs_emp() finds the total hours the employee works across all projects 

--- q1_main() uses n_hrs_emp() and calculates the cost of employing an employee for this project as

--- hr_in_this_proj*total_salary/total_hrs_across_all_proj
--- Then a summation of this value is done for all employees across the project

create or replace function n_hrs_emp(e_id int)
	returns int
	language plpgsql
	as
$$
declare
	ans integer;
begin
	with temp0 as(
	select hours
	from repository
	where
	owns = e_id)
	select sum(hours)
	into ans
	from temp0;

	return ans;
end;
$$;

--- q1_main() computes the overall cost of the project 
--- Accepts project_id(as remote_repo_id),
--- returns total cost of the project


create or replace function q1_main(r_rid int)

returns float
language plpgsql
as
$$
declare
	ans float;
begin
	with temp0 as(
	
	select 
		owns,hours,salary
	from 
		repository,employs
	where 
		remote_rid = r_rid and e_user_id = owns)
		
	select 
		sum(salary*hours/n_hrs_emp(owns))
	into 
		ans
	from 
		temp0;

return ans;
end;
$$;

--- ### Task 2: To find the total space for the project ###

--- Relations used: Contains, file

create or replace function q2_main(r_rid int)

returns int
language plpgsql
as
$$
declare
	ans int;
begin
	with temp0 as(
	select distinct contains_fid 
	from contains
	where contains_v_rem_repo_id = r_rid),
	
	temp1 as(
	select file_size,fid
	from temp0,file
	where fid = contains_fid)
	
	select 
		sum(file_size)
	into ans
	from 
		temp1;

	return ans;
end;
$$;

--- select q2_main(1);

--- ### Task 3: Estimated cost for completing the project ###


create or replace function q3_main(r_rid int)
returns float
language plpgsql
as
$$
declare
	till_cost integer;
	till_perci integer;
	ans integer;
begin

	select q1_main(r_rid)
	into till_cost;
	
	select progress_bar
	into till_perci
	from project
	where p_rid = r_rid;

	ans = (100-till_perci)/till_perci*till_cost;
	return ans;
end;
$$;

--- select q3_main(1);


--- ### Task 4:Project which requires least number of man hours to complete ###

create or replace function n_hrs_project(r_rid int)
returns int
language plpgsql
as
$$
declare
	ans float;
begin
	select sum(hours)
	into ans
	from repository
	where remote_rid = r_rid;

	return ans;
end;
$$;




create or replace function n_hrs_left_project(r_rid int)
returns float
language plpgsql
as
$$
declare
	n_hrs_p float;
	proj_perci float;
	ans float;
begin
	select progress_bar
	into proj_perci
	from project
	where p_rid = r_rid;
	
	select n_hrs_project(r_rid)
	into n_hrs_p;
	
	ans = (100-proj_perci)/proj_perci*n_hrs_p;

	return ans;
end;
$$;


create or replace function q4_main(c_id int)
returns int
language plpgsql
as
$$

declare	
	ans integer;
	min_hrs float;
begin
	
	select min(n_hrs_left_project(p_rid))
	into min_hrs
	from project
	where p_company_id = c_id;
	
	select 
		p_rid
	into 
		ans
	from 
		project
	where 
		n_hrs_left_project(p_rid) = min_hrs and 
		p_company_id = c_id;


	return ans;
end;
$$;

--- select q4_main(2);


--- ### Task 5: Largest local repo across all projects ###

--- Main idea: i  ) identify branches in the repo
---		    ii ) identify all versions in thos branches
---            iii) identify all files in those versions and find their total size
---			iv) using the above 3 steps, find the size of all repos and find the largest of them



create or replace function repo_size(repo_id int)
returns int
language plpgsql
as
$$
declare
	ans integer;
	rem_repo integer;
begin
		
	with temp0 as(
	select 
		bid,b_rid
	from 
		branch
	where
		b_rid = repo_id)---,
	--- temp1
	---temp1 as(
	select distinct vid,v_rem_repo_id
	from holds
	natural join
	temp0;---),
	--- temp2
	with temp2 as(
	select distinct contains_fid as fid
	from contains,temp1
	where vid = contains_vid and contains_v_rem_repo_id = v_rem_repo_id)

	select sum(file_size)
	---into ans
	from file
	natural join
	temp2;

	return ans;
end;
$$;

--- select repo_size(2);


create or replace function q5_main()
returns int
language plpgsql
as
$$
declare
	ans integer;
	maxi integer;
begin
	select max(repo_size(rid))
	into maxi
	from repository;

	select rid
	into ans
	from repository
	where repo_size(rid) = maxi;

	return ans;
end;
$$;


--- ### Triggers ###


CREATE OR replace function add_user_to_company()
RETURNS Trigger
language plpgsql
AS $$
declare
	comp_id int ;
begin
	-- SELECT column_name(s)
	-- FROM table_name
	-- WHERE EXISTS
	-- (SELECT column_name FROM table_name WHERE condition);
	IF (new.remote_rid IS NOT NULL) THEN
		Select Project.P_Company_ID into comp_id from Project where Project.P_RID=new.remote_rid;
		
		IF (NOT EXISTS(SELECT * FROM Employs WHERE E_Company_ID=comp_id AND E_user_ID=new.Owns)) THEN
				INSERT INTO EMPLOYS VALUES(new.Owns,comp_id,0);
				RAISE notice 'added %',comp_id;
		END IF;
	END IF;
	return new;
END;
$$;

	
create Trigger tri_add_user_to_company
AFTER INSERT
on repository
for each row
execute procedure add_user_to_company();





--- ### Privilages ###

DROP USER IF EXISTS Company_User;
DROP USER IF EXISTS Developer_User;
DROP USER IF EXISTS Viewer;

CREATE USER Company_User;
CREATE USER Developer_User;
CREATE USER Viewer;



---# Company_User permissions#
GRANT SELECT ON ALL TABLES IN SCHEMA public TO Company_User;
REVOKE SELECT (Password) ON Developer FROM Company_User;
GRANT INSERT ON Project,Employs,Repository  TO Company_User;
GRANT UPDATE (Company_Description,Location) ON company TO Company_User;
GRANT UPDATE (Description,progress_bar) ON project TO Company_User;
GRANT UPDATE (salary) ON employs TO Company_User;
GRANT DELETE ON Project, Employs,Repository TO Company_User;

---# Developer_User permissions#
GRANT SELECT ON ALL TABLES IN SCHEMA public TO Developer_User;
GRANT INSERT,UPDATE ON Repository,Branch,Holds,Version,Contains,File TO Developer_User;
GRANT DELETE ON Repository,Branch,Holds,Version,Contains,File TO Developer_User;

---# Viewer permissions#
GRANT SELECT ON ALL TABLES IN SCHEMA public TO Viewer;
REVOKE SELECT (Password) ON Developer FROM Viewer;
REVOKE SELECT (file_contains) ON File FROM Viewer;


