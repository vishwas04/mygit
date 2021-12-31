\c github
drop function if exists update_salary(empID int,cmpID int, newSalary int);

---# fucntion to update salary #
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

---#select update_salary(1,1,1500);

