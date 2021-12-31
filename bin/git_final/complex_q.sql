drop function n_hrs_emp(e_id int);
drop function q1_main(r_rid int);
drop function q2_main(r_rid int);
drop function q3_main(r_rid int);
drop function n_hrs_project(r_rid int);
drop function n_hrs_left_project(r_rid int);
drop function q4_main(c_id int);
drop function repo_size(repo_id int);
drop function q5_main();



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

select 'n_hrs_emp created';
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

select 'q1_main function created';

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

select 'q2_main function created';

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


select 'q3_main function created';
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


select 'n_hrs_project function created';


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

select 'n_hrs_left_project function created';

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

select 'q4_main function created';

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
		b_rid = repo_id),
	--- temp1
	temp1 as(
	select distinct vid,v_rem_repo_id
	from holds
	natural join
	temp0),
	--- temp2
	temp2 as(
	select distinct contains_fid as fid
	from contains,temp1
	where vid = contains_vid and contains_v_rem_repo_id = v_rem_repo_id)

	select sum(file_size)
	into ans
	from file
	natural join
	temp2;

	return ans;
end;
$$;

--- select repo_size(2);

select 'repo_size function created';

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

select 'q5_main function created';
	
	
	
	
	

	
	
	
	 
	 



