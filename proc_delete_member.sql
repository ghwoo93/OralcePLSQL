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
      DBMS_OUTPUT.PUT_LINE(ID_ || '가 삭제되었습니다.');
      APPECTED  := SQL%ROWCOUNT;
      COMMIT;
   ELSE
      DBMS_OUTPUT.PUT_LINE(ID_ || '가 존재하지 않습니다.');
      APPECTED  := -1;
   END IF;

   EXCEPTION
   WHEN OTHERS THEN
   BEGIN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('자식이 참조하고 있는 정보입니다.');
      APPECTED  := -2;
   END;
END;
/