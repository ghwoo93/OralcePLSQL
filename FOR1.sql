ACCEPT SNUM PROMPT '시작값 입력?'
ACCEPT ENUM PROMPT '끝값 입력?'

DECLARE
	HAP NUMBER := 0 ;
BEGIN
	
	FOR I IN &SNUM .. &ENUM LOOP
		IF MOD(I,2) = 0 THEN
			HAP := HAP + I;
		END IF;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE (&SNUM || '부터 '||&ENUM ||'까지 짝수의 합:'|| HAP);

END;
/