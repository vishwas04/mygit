create or replace function pull (devID int, RepoID int)
returns int as $$
declare
    Remote_Repo_ID int;
    c int;
    c1 int;
    t time;
begin
    t='09:15:08';
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
    t='09:15:08';
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



