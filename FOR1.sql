ACCEPT SNUM PROMPT '���۰� �Է�?'
ACCEPT ENUM PROMPT '���� �Է�?'

DECLARE
	HAP NUMBER := 0 ;
BEGIN
	
	FOR I IN &SNUM .. &ENUM LOOP
		IF MOD(I,2) = 0 THEN
			HAP := HAP + I;
		END IF;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE (&SNUM || '���� '||&ENUM ||'���� ¦���� ��:'|| HAP);

END;
/