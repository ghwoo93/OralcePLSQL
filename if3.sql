accept kor_ prompt '��������?'
accept eng_ prompt '��������?'
accept math_ prompt '��������?'

declare
	kor number(3) := &kor_;
	eng number(3) := &eng_;
	math number(3);
	average number(5,2);
begin
	dbms_output.put_line('���� ����ϱ�');
	math := &math_;
	average := (kor+eng+math) / 3 ;
	if average >= 90 then
		dbms_output.put_line('A����');
	elsif average >=80 then
		dbms_output.put_line('B����');
	elsif average >=70 then
		dbms_output.put_line('C����');
	elsif average >=60 then
		dbms_output.put_line('D����');
	else 
		dbms_output.put_line('F����');
	end if;
	dbms_output.put_line('��� : '|| average );
end;
/