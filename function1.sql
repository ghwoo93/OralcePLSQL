create or replace function getsum(num1 in number, num2 number)
--��ȯŸ�� ����
	return number
is
	--���� ����(�ڸ��� ���� ���� �� ; �־�� ��
	hap number;
begin
	hap:=0;
	for k in num1 .. num2 loop
		hap := hap +k;
	end loop;
	--�� ��ȯ
	return hap;
end;
/