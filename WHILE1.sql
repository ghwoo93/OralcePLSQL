DECLARE
	HAP NUMBER := 0;
	K NUMBER := 1;
BEGIN
	WHILE K<=10 LOOP
		HAP := HAP + K ;
		K := K + 1 ;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE( '1���� 10���� ������ : '|| HAP);
END;
/