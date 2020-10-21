accept kor_ prompt '국어점수?'
accept eng_ prompt '영어점수?'
accept math_ prompt '수학점수?'

declare
	kor number(3) := &kor_;
	eng number(3) := &eng_;
	math number(3);
	average number(5,2);
begin
	dbms_output.put_line('성적 출력하기');
	math := &math_;
	average := (kor+eng+math) / 3 ;
	if average >= 90 then
		dbms_output.put_line('A학점');
	elsif average >=80 then
		dbms_output.put_line('B학점');
	elsif average >=70 then
		dbms_output.put_line('C학점');
	elsif average >=60 then
		dbms_output.put_line('D학점');
	else 
		dbms_output.put_line('F학점');
	end if;
	dbms_output.put_line('평균 : '|| average );
end;
/