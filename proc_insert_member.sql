create or replace procedure sp_ins_member (
	id_ in member.id%type,
	pwd_  member.pwd%type,
	name_  member.name%type,
	rtval out nvarchar2
)
is	
begin
	insert into member(id,pwd,name) 
	values(id_, pwd_, name_);
	if sql%found then
		rtval := '입력성공';
		commit;
	end if;
	
	exception
		when others then
			rollback;
			rtval :='입력실패 - 중복키나 입력값이 크다';
end;
/