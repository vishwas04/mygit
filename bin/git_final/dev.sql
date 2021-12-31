\c github
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




create or replace function create_project(CmpID int, Description varchar(200))
returns int as $$
declare
    New_P_RID int;
begin
    IF (SELECT(CmpID) IN (SELECT Company_ID FROM Company)) THEN
        SELECT (MAX(RID)+1) into New_P_RID from Repository;
        INSERT INTO Repository values (New_P_RID);
        INSERT INTO Project values (New_P_RID, Description, 0,CmpID);
        INSERT INTO Branch values (1,New_P_RID,CURRENT_TIMESTAMP(0),null,null);
        RETURN New_P_RID;
    ELSE 
        RETURN -1;
    END IF;
end;
$$ language plpgsql;



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





create or replace function pull (devID int, RepoID int)
returns int as $$
declare
    Remote_Repo_ID int;
    c int;
    c1 int;
    t time;
begin
    t=CURRENT_TIMESTAMP(0);
    IF (SELECT (SELECT COUNT(*) FROM Repository where RID=RepoID and Owns=devID) >0 )  THEN
        SELECT Remote_RID into Remote_Repo_ID FROM Repository where RID=RepoID and Owns=devID;
        INSERT INTO Branch 
        select distinct h1.BID  ,RepoID as B_RID, t as timestamp ,h1.parent_BID,h1.parent_B_RID from (SELECT *  FROM branch WHERE b_rid=Remote_Repo_ID) h1, (Select  b.bid from (SELECT *  FROM Holds WHERE b_rid=Remote_Repo_ID) b,(SELECT vid  FROM Holds WHERE b_rid=Remote_Repo_ID EXCEPT SELECT vid  FROM Holds WHERE b_rid=RepoID) v where  v.vid=b.vid EXCEPT select BID from branch where B_rid=RepoID) h2  where h1.bid=h2.bid;
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
    t time;
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





-- select pull(3,6);

-- Select distinct b.bid,b.b_rid,b.timestamp,b.parent_BID,b.parent_B_RID from holds h,branch b where h.b_rid=1 and b.b_rid=1 and h.bid=b.bid
--         UNION
--         Select distinct b.bid,b.b_rid,b.timestamp,b.parent_BID,b.parent_B_RID from holds h,branch b where h.b_rid=6 and b.b_rid=6 and h.bid=b.bid;


-- Select  * from (SELECT *  FROM Holds WHERE b_rid=9) b,(SELECT vid  FROM Holds WHERE b_rid=9 EXCEPT SELECT vid  FROM Holds WHERE b_rid=10) v where  v.vid=b.vid

-- -- Select  distinct b.bid,b.b_rid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=1) h,(SELECT *  FROM Holds WHERE b_rid=6) b where  h.bid!=b.bid

-- -- SELECT *
-- -- (
-- -- SELECT *  FROM Holds WHERE b_rid=1
-- -- UNION
-- -- SELECT *  FROM Holds WHERE b_rid=6) t1 


-- -- ; 



-- Select  * from (SELECT DISTINCT vid FROM
-- (SELECT vid  FROM Holds WHERE b_rid=1 INTERSECT SELECT vid  FROM Holds WHERE b_rid=6) t1) h,(SELECT *  FROM Holds WHERE b_rid=6) b h.;


-- SELECT DISTINCT vid FROM
-- (
-- SELECT *  FROM Holds WHERE b_rid=6
-- EXCEPT
-- SELECT *  FROM Holds WHERE b_rid=1 ) t1 ;



-- SELECT vid  
-- FROM Holds 
-- WHERE b_rid=6
-- EXCEPT
-- SELECT vid  
-- FROM Holds 
-- WHERE b_rid=1 ;



-- SELECT * FROM Holds
-- WHERE vid NOT IN 
-- (SELECT DISTINCT vid FROM
-- (
-- SELECT *  FROM Holds WHERE b_rid=1
-- INTERSECT
-- SELECT *  FROM Holds WHERE b_rid=6) t1) and  b_rid=6;



-- SELECT *  FROM Holds WHERE b_rid=1
-- UNION
-- SELECT vid  FROM Holds WHERE b_rid=6 EXCEPT SELECT vid  FROM Holds WHERE b_rid=1 ;

-- -- SELECT *  FROM Holds WHERE b_rid=1
-- -- UNION
-- Select  * from (SELECT *  FROM Holds WHERE b_rid=9) b,(SELECT vid  FROM Holds WHERE b_rid=9 EXCEPT SELECT vid  FROM Holds WHERE b_rid=10) v where  v.vid=b.vid
-- -- SELECT COUNT(*) into c1  FROM ((SELECT * FROM Branch ) INNER JOIN (SELECT * FROM Holds )) ON Branch.b_rid=Holds.b_rid;
--         -- SELECT COUNT(*) into c1  FROM ((SELECT * FROM Branch WHERE b_rid=Remote_Repo_ID) JOIN (SELECT * FROM Holds WHERE Holds.B_RID=Remote_Repo_ID )) t2;
--     --     SELECT  *
--     --  FROM Branch
--     --  LEFT JOIN Holds
--     --  ON Branch.b_rid = Holds.b_rid and Branch.b_rid =Remote_Repo_ID
--     -- (Select distinct b.bid,b.b_rid,b.timestamp,b.parent_BID,b.parent_B_RID from holds h,branch b where h.b_rid=Remote_Repo_ID and b.b_rid=Remote_Repo_ID and h.bid=b.bid
--     --     UNION
--     --     Select distinct b.bid,b.b_rid,b.timestamp,b.parent_BID,b.parent_B_RID from holds h,branch b where h.b_rid=RepoID and b.b_rid=RepoID and h.bid=b.bid)
--         select COUNT(*) into c1 FROM
--         SELECT *  
--         FROM Holds 
--         WHERE b_rid=1
--         MINUS
--         SELECT *
--         FROM Holds 
--         WHERE b_rid=6;


--         Select  b.bid,sim.rid,b.vid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=1) b,(SELECT vid  FROM Holds WHERE b_rid=1 EXCEPT SELECT vid  FROM Holds WHERE b_rid=7) v,(SELECT rid  FROM Repository WHERE rid=7) sim where  v.vid=b.vid
--         Select  b.bid,sim.rid,b.vid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=Remote_Repo_ID) b,(SELECT vid  FROM Holds WHERE b_rid=Remote_Repo_ID EXCEPT SELECT vid  FROM Holds WHERE b_rid=RepoID) v,(SELECT rid  FROM Repository WHERE rid=6) sim where  v.vid=b.vid;




--         Select  b.bid from (SELECT *  FROM Holds WHERE b_rid=1) b,(SELECT vid  FROM Holds WHERE b_rid=1 EXCEPT SELECT vid  FROM Holds WHERE b_rid=6) v,(SELECT rid  FROM Repository WHERE rid=6) sim where  v.vid=b.vid;

-- Select  b.bid from (SELECT *  FROM Holds WHERE b_rid=6) b,(SELECT vid  FROM Holds WHERE b_rid=6 EXCEPT SELECT vid  FROM Holds WHERE b_rid=4) v,(SELECT rid  FROM Repository WHERE rid=4) sim where  v.vid=b.vid
-- EXCEPT
-- select BID from branch where B_rid=4;

-- Select  b.bid,sim.rid,b.vid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=6) b,(SELECT vid  FROM Holds WHERE b_rid=6 EXCEPT SELECT vid  FROM Holds WHERE b_rid=4) v,(SELECT rid  FROM Repository WHERE rid=4) sim where  v.vid=b.vid


-- select distinct h1.BID ,4,'09:15:08',h1.parent_BID,h1.parent_B_RID,h2.bid from (SELECT *  FROM branch WHERE b_rid=6) h1, (Select  b.bid from (SELECT *  FROM Holds WHERE b_rid=6) b,(SELECT vid  FROM Holds WHERE b_rid=6 EXCEPT SELECT vid  FROM Holds WHERE b_rid=4) v,(SELECT rid  FROM Repository WHERE rid=4) sim where  v.vid=b.vid EXCEPT select BID from branch where B_rid=4) h2 , (select B_rid from branch where B_RID=4 ) h3 where h1.bid=h2.bid;

-- a=1
-- b=6

-- select distinct h1.BID  ,4 as B_RID,'09:15:08' as timestamp ,h1.parent_BID,h1.parent_B_RID from (SELECT *  FROM branch WHERE b_rid=6) h1, (Select  b.bid from (SELECT *  FROM Holds WHERE b_rid=6) b,(SELECT vid  FROM Holds WHERE b_rid=6 EXCEPT SELECT vid  FROM Holds WHERE b_rid=4) v where  v.vid=b.vid EXCEPT select BID from branch where B_rid=4) h2  where h1.bid=h2.bid;
-- Select  b.bid,4 as B_RID,b.vid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=6) b,(SELECT vid  FROM Holds WHERE b_rid=6 EXCEPT SELECT vid  FROM Holds WHERE b_rid=4) v,(SELECT rid  FROM Repository WHERE rid=4) sim where  v.vid=b.vid



-- SELECT COUNT(*) into c  FROM ((SELECT * FROM Branch WHERE b_rid=Remote_Repo_ID) UNION (SELECT * FROM Branch WHERE b_rid=RepoID)) t1;
--         -- INSERT INTO Holds (bid , b_rid , vid , v_rem_repo_id ,rank)

--         Select  b.bid,sim.rid,b.vid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=Remote_Repo_ID) b,(SELECT vid  FROM Holds WHERE b_rid=Remote_Repo_ID EXCEPT SELECT vid  FROM Holds WHERE b_rid=RepoID) v,(SELECT rid  FROM Repository WHERE rid=RepoID) sim where  v.vid=b.vid;
        
-- select * from version where v_rem_repo_id = 1;

        -- select distinct h1.BID  ,5 as B_RID, '09:15:08' as timestamp ,h1.parent_BID,h1.parent_B_RID from (SELECT *  FROM branch WHERE b_rid=1) h1, (Select  b.bid from (SELECT *  FROM Holds WHERE b_rid=1) b,(SELECT vid  FROM Holds WHERE b_rid=1 EXCEPT SELECT vid  FROM Holds WHERE b_rid=5) v where  v.vid=b.vid EXCEPT select BID from branch where B_rid=5) h2  where h1.bid=h2.bid;

        -- Select  b.bid,5 as B_RID,b.vid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=1) b,(SELECT vid  FROM Holds WHERE b_rid=1 EXCEPT SELECT vid  FROM Holds WHERE b_rid=5) v,(SELECT rid  FROM Repository WHERE rid=5) sim where  v.vid=b.vid;


-- Select  b.bid,1 as B_RID,b.vid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=5) b,(SELECT vid  FROM Holds WHERE b_rid=5 EXCEPT SELECT vid  FROM Holds WHERE b_rid=1) v,(SELECT rid  FROM Repository WHERE rid=1) sim where  v.vid=b.vid;
-- Select  b.bid,Remote_Repo_ID as B_RID,b.vid,b.v_rem_repo_id,b.rank from (SELECT *  FROM Holds WHERE b_rid=RepoID) b,(SELECT vid  FROM Holds WHERE b_rid=RepoID EXCEPT SELECT vid  FROM Holds WHERE b_rid=Remote_Repo_ID) v,(SELECT rid  FROM Repository WHERE rid=Remote_Repo_ID) sim where  v.vid=b.vid;
-- select distinct h1.BID  ,RepoID as B_RID, t as timestamp ,h1.parent_BID,h1.parent_B_RID from (SELECT *  FROM branch WHERE b_rid=Remote_Repo_ID) h1, (Select  b.bid from (SELECT *  FROM Holds WHERE b_rid=Remote_Repo_ID) b,(SELECT vid  FROM Holds WHERE b_rid=Remote_Repo_ID EXCEPT SELECT vid  FROM Holds WHERE b_rid=RepoID) v where  v.vid=b.vid EXCEPT select BID from branch where B_rid=RepoID) h2  where h1.bid=h2.bid;
