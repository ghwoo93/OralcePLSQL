ACCEPT SNUM PROMPT '���۰� �Է�?'
ACCEPT ENUM PROMPT '���� �Է�?'

DECLARE
	HAP NUMBER ;
	START_NUM NUMBER := &SNUM;
	
BEGIN	
	IF (&SNUM >= &ENUM) THEN
		DBMS_OUTPUT.PUT_LINE('���۰��� ���ᰪ���� ũ�ų� ���ƿ�');
	ELSE
		HAP := 0;
		LOOP
			HAP := HAP + START_NUM;
			START_NUM := START_NUM +1;
			EXIT WHEN START_NUM > &ENUM ;
		END LOOP;
		DBMS_OUTPUT.PUT_LINE(&SNUM || '����' || &ENUM || '������ �� : '|| HAP);
	END IF;
END;
/