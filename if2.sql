set serverout on
accept p_num prompt 'INPUT NUMBER?'

declare
	num number := &p_num;
begin
	dbms_output.put_line('NUMBER IS:' || num);
	if mod(num,2) =0 then
		dbms_output.put_line( num || 'IS EVEN');
	else
		dbms_output.put_line( num || 'IS ODD');
	end if;
end;
/