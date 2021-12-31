\c github
drop function if exists create_company (comp_id int,comp_des varchar,comp_loc varchar);

create or replace function create_company (comp_id int,comp_des varchar,comp_loc varchar)
returns int as $$
declare
    updated_val int;
begin
    INSERT INTO Company (Company_ID, Company_Description ,Location)
    VALUES (comp_id, comp_des,comp_loc);
    return updated_val;
end;

$$ language plpgsql;


