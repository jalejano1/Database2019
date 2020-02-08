create or replace procedure PR_Q3
authid current_user
is 
    Email_Address varchar2(50);
begin 
    update Broker
    set Email_Address = replace(Email_Address, charindex('@', Email_address), LEN(Email_address) - charindex(Email_address,'@')), '@example.com')
    where Email_Address like '%@usa.com';
end PR_Q3;
/
show errors;


select * from Broker;