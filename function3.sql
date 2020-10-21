create or replace function getdate(d date)
	return varchar2
is
	
begin
	return to_char(d, 'yyyy-mm-dd');
end;
/