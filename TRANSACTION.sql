BEGIN
	--�����۾�
	UPDATE MEMBER SET NAME='���浿' WHERE ID = 'KIM1';
	--���� �۾�
	DELETE MEMBER WHERE ID ='KIM2';
	--�Է��۾�: ���� �߻�
	INSERT INTO MEMBER(ID,NAME) VALUES( 'KIM4', '���浿4');
	
	COMMIT;

	DBMS_OUTPUT.PUT_LINE('�Ϸ��� �۾�(Ʈ�����)�� ���� �߾��');
	
	EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;	
		DBMS_OUTPUT.PUT_LINE('��� �۾��� ��� �Ǿ���� :' || SQLERRM);
	
END;
/