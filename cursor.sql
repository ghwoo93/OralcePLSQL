set serverout on

accept deptno prompt '부서코드?'

declare 
	--커서 정의
	cursor mycursor is
	select ename,sal, dname, loc
	from emp e join dept d on e.deptno = d.deptno
	where e.deptno = &deptno;
	
	--변수 정의
	ename_ emp.ename%type;
	sal_ emp.sal%type;
	dname_ dept.dname%type;
	loc_ dept.loc%type;
begin
	--커서 오픈
	open mycursor;
	--fetch 하기
	fetch mycursor into ename_, sal_, dname_, loc_;
	while mycursor%found loop
		dbms_output.put_line( ename_|| ' : ' || sal_ || ' : '|| dname_|| ' : '|| loc_ );
		fetch mycursor into ename_, sal_, dname_, loc_;
	end loop;
	
	--커서 닫기
	close mycursor;
end;
/