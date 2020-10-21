CREATE OR REPLACE PROCEDURE SP_DEL_MEMBER
(
   ID_ member.id%TYPE,
   APPECTED OUT number
)
IS
BEGIN
   DELETE member
   WHERE id = ID_;

   IF SQL%FOUND THEN
      DBMS_OUTPUT.PUT_LINE(ID_ || '�� �����Ǿ����ϴ�.');
      APPECTED  := SQL%ROWCOUNT;
      COMMIT;
   ELSE
      DBMS_OUTPUT.PUT_LINE(ID_ || '�� �������� �ʽ��ϴ�.');
      APPECTED  := -1;
   END IF;

   EXCEPTION
   WHEN OTHERS THEN
   BEGIN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('�ڽ��� �����ϰ� �ִ� �����Դϴ�.');
      APPECTED  := -2;
   END;
END;
/