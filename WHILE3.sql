DECLARE 
	K NUMBER :=1;
	J NUMBER := 2;
BEGIN
	WHILE K <= 9 LOOP
		WHILE J <=9 LOOP
			DBMS_OUTPUT.PUT( J || '*' || K || '=' || J*K || '  '); 
			J := J +1 ;
		END LOOP;
		K := K+1;
		J := 2;
		DBMS_OUTPUT.NEW_LINE;
	END LOOP;
END;
/
	