create or replace procedure sp_up_member(
	id_ member.id%type,
	pwd_ member.pwd%type,
	name_ member.name%type,
	rtval out char
)
is
begin
	update member set pwd = pwd_, name = name_
	where id = id_;

	if sql%found then
		rtval := 'SUCCESS' ;
		commit;
	else
		rtval := 'FAIL : NOT FOUND ID' ;
	end if;

	exception
		when others then
			begin
				rollback;
				rtval := 'FAIL : TOO MUCH VALUE' ;
			end;
end;
/
