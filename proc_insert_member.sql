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
		rtval := '�Է¼���';
		commit;
	end if;
	
	exception
		when others then
			rollback;
			rtval :='�Է½��� - �ߺ�Ű�� �Է°��� ũ��';
end;
/