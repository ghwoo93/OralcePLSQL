/*
	OUT 파라미터 값
		- 회원 : 1
		- 아이디 일치 비번 불일치 : 0
		- 아이디 불일치 : -1
*/
CREATE OR REPLACE PROCEDURE SP_ISMEMBER (
   	id_ member.id%TYPE,
	pwd_ member.pwd%type,
   	rtval out number
)
IS
	flag number(1);
BEGIN
	select count(*) into flag
	from member
	where id = id_ ;
	
	if flag = 0 then
		rtval := -1;
	else 
		select count(*) into flag
		from member
		where id = id_ and pwd = pwd_ ;
		if flag = 0 then
			rtval := 0;
		else
			rtval := 1;
		end if;	
	end if;
END;
/