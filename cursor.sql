set serverout on

accept deptno prompt '�μ��ڵ�?'

declare 
	--Ŀ�� ����
	cursor mycursor is
	select ename,sal, dname, loc
	from emp e join dept d on e.deptno = d.deptno
	where e.deptno = &deptno;
	
	--���� ����
	ename_ emp.ename%type;
	sal_ emp.sal%type;
	dname_ dept.dname%type;
	loc_ dept.loc%type;
begin
	--Ŀ�� ����
	open mycursor;
	--fetch �ϱ�
	fetch mycursor into ename_, sal_, dname_, loc_;
	while mycursor%found loop
		dbms_output.put_line( ename_|| ' : ' || sal_ || ' : '|| dname_|| ' : '|| loc_ );
		fetch mycursor into ename_, sal_, dname_, loc_;
	end loop;
	
	--Ŀ�� �ݱ�
	close mycursor;
end;
/