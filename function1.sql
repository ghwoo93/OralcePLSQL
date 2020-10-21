create or replace function getsum(num1 in number, num2 number)
--반환타입 정의
	return number
is
	--변수 선언(자리수 지정 가능 및 ; 넣어야 함
	hap number;
begin
	hap:=0;
	for k in num1 .. num2 loop
		hap := hap +k;
	end loop;
	--값 반환
	return hap;
end;
/