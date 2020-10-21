set serverout on
var result nvarchar2(10)
declare
	str nvarchar2(10) := 'JAVA';
begin
	if str = 'Java' then
	begin
		dbms_output.put_line('Java');
		:result :='Java';
	end;
	elsif str = 'JaVa' then
		dbms_output.put_line('JaVa');
		:result :='JaVa';
	else
		dbms_output.put_line('JAVA');
		:result :='JAVA';
	end if;
end;
/