create or replace function to_asterisk(str varchar2)
	return varchar2
is
	first varchar2(20);
begin
	first := rpad(substr(str,1,1),length(str),'*');
	return first;	
end;
/