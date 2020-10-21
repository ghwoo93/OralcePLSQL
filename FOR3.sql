BEGIN
	FOR I IN 1 .. 9 LOOP
		FOR J IN 2 .. 9 LOOP
			DBMS_OUTPUT.PUT( J ||' * '|| I || ' = '|| J*I || '  '); 
		END LOOP;
		DBMS_OUTPUT.NEW_LINE;
	END LOOP;
END;
/