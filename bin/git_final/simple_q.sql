

drop function sq1_main(r_rid int);
drop function sq2_main(r_rid int);
drop function sq3_main(r_rid int);
drop function sq4_main(ty varchar);
drop function sq5_main(c_id int);


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

	drop table temp0;
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
	




