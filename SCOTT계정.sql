
 ----------[SELECT��]----------
SELECT DISTINCT job
FROM emp;
--DISTINCT �ߺ��� ���� �÷��� 2�� �̻��̸� AND �������� ó��
SELECT DISTINCT ename, job, deptno
FROM emp;

SELECT DISTINCT job, deptno
FROM emp;
--WHERE�� ���� ����
SELECT ename, sal
FROM emp
WHERE sal >= 3000;

SELECT ename, sal,job
FROM emp;

SELECT ename, sal,job
FROM emp
WHERE job ='SALESMAN'; --�����ʹ� ��ҹ��ڸ� �����Ѵ�

SELECT ename, sal,job
FROM emp
WHERE job ='SALESMAN' AND sal >=1500;

SELECT ename, sal,job
FROM emp
WHERE job !='SALESMAN' AND sal >=1500;

--�÷��� BETWEEN a AND b   -> �÷��� >= a AND �÷��� <= b
SELECT ename, sal, job
FROM emp
WHERE sal BETWEEN 1500 AND 3000;

--IN������ OR�� ����� �Ͱ� ����
--�÷��� IN (��1, ��2) -> �÷��� = ��1 OR �÷��� = ��2 �� ����.
SELECT ename,sal, job
FROM emp
WHERE job IN ('SALESMAN','CLERK');
--Į��2�� ����� IN�����ڴ� ()�� ���μ� ó���Ѵ�.
SELECT ename, sal, job, deptno
FROM emp
WHERE (job,deptno) IN (('CLERK',20),('SALESMAN',30) );
SELECT ename, sal, job, deptno
FROM emp
WHERE job = 'CLERK' AND deptno = 20 OR job = 'SALESMAN' AND deptno = 30
ORDER BY deptno;

--Like������
--S�� �����ϴ� ������ �˻�
SELECT ename FROM emp WHERE ename LIKE 'S%';
--S�� ������ ������ �˻�
SELECT ename FROM emp WHERE ename LIKE '%S';
--AR�� ���� ������ �˻�
SELECT ename FROM emp WHERE ename LIKE '%AR%';
--3��° ���ڰ� A�� ������ �˻�
SELECT ename FROM emp WHERE ename LIKE '__A%';

SELECT ename FROM emp WHERE ename LIKE '__A%' AND NOT ename LIKE 'A%';

--IS NULL������
SELECT ename, job, comm
FROM emp
WHERE comm IS NOT NULL ;

--����
SELECT empno �����ȣ, ename �̸�,job ��å,sal ����
FROM emp
WHERE job = 'MANAGER' AND sal BETWEEN 2500 AND 3000;

SELECT empno �����ȣ, ename �̸�,job ��å,sal ����, dname �μ���
FROM emp,dept
WHERE emp.deptno = dept.deptno AND job = 'MANAGER' AND sal BETWEEN 2500 AND 3000;

SELECT ename, deptno, sal, job
FROM emp
WHERE deptno = 30 AND  sal >= 1500 AND NOT job LIKE ('SALESMAN');

SELECT *
FROM emp
WHERE deptno IN(20,30) AND NOT sal >= 2000
ORDER BY deptno;

SELECT *
FROM emp
WHERE deptno NOT IN(20,30) AND NOT sal >= 2000;

SELECT *
FROM emp
WHERE comm is not null AND comm != 0 AND sal >= 1500;
--���� ��

--ORDER BY
SELECT ename, sal
FROM emp
ORDER BY  sal DESC; --DESC �������� ����

SELECT ename, job, deptno
FROM emp
ORDER BY  job, deptno; --JOB���� ���� ������ JOB�� �ߺ��Ǵ� �����ʹ� DEPTNO�� ����

SELECT ename, sal 
FROM emp
WHERE sal >= 1500
ORDER BY ename;

SELECT ename, sal
FROM emp e
WHERE e.sal >= 1500
ORDER BY e.deptno;

--����
SELECT *
FROM emp
ORDER BY sal DESC;

SELECT ename, deptno, sal, comm
FROM emp
WHERE job IN('SALESMAN') AND comm >=100
ORDER BY sal, ename ;

SELECT *
FROM emp
WHERE ename LIKE '%A%'
ORDER BY sal , deptno DESC;

--���� �� --
--�׷��Լ� ���, group by
SELECT MAX(sal), ename
FROM emp
WHERE sal = (SELECT MAX(sal) 
             FROM emp)
GROUP BY ename;

SELECT MAX(sal), deptno
FROM emp
GROUP BY deptno;

SELECT MIN(sal), deptno
FROM emp
GROUP BY deptno
HAVING MIN(sal) > 1000;

SELECT AVG(sal), deptno
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;

SELECT MIN(sal) M, deptno --5
FROM emp    --1
WHERE sal >=2000    --2
GROUP BY deptno     --3
HAVING MIN(sal) >= 2500    --4
ORDER BY M DESC;    --6

--����
SELECT COUNT(*)
FROM emp
WHERE sal >=1000 AND ename LIKE('%S');

SELECT AVG(sal)
FROM emp
WHERE job = 'SALESMAN';
--���� ��
SELECT deptno, MAX(sal), job
FROM emp
GROUP BY deptno, job;

SELECT * FROM dept;
--JOIN
SELECT * 
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT ename, dname, d.deptno, job
FROM emp e INNER JOIN dept d ON e.deptno = d.deptno;

SELECT ename, dname, d.deptno, job
FROM emp e INNER JOIN dept d ON e.deptno = d.deptno AND sal >= 3000;

SELECT dname, d.deptno, empno,ename
FROM dept d LEFT OUTER JOIN emp e ON d.deptno = e.deptno;

select empno, job, mgr
from emp;
 
SELECT * FROM emp;
SELECT * FROM dept;
--����Ŭ��
SELECT empno, ename, sal, job, e.deptno, dname,loc
FROM emp e, dept d
where e.deptno = d.deptno;
--ǥ�� sql �� 
SELECT empno, ename, sal, job, e.deptno, dname,loc
FROM emp e JOIN dept d ON e.deptno = d.deptno;

--OUTER JOIN 
--�ڽ� ���� : INNER JOIN�� ����.
SELECT empno, ename, sal, job, e.deptno, dname,loc
FROM emp e LEFT OUTER JOIN dept d ON e.deptno = d.deptno;
--�θ���ؿ��� �ؾ� ���ǹ��� �ǹ̰� �ִ�
SELECT empno, ename, sal, job, d.deptno, dname,loc
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;
--����� �ȵ� �μ��� �̸��� ��ġ �׸��� �μ� �ڵ� ��ȸ
SELECT d.deptno, dname, loc
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno
WHERE empno is null;
--SELF JOIN
SELECT e.ename ||'�� �Ŵ�����' || m.ename ||' �Դϴ�.' ������
FROM emp e JOIN emp m on e.mgr = m.empno;

SELECT t.* 
FROM (SELECT empno, ename, hiredate, deptno FROM emp) t;
SELECT ename, sal 
FROM emp
WHERE sal > = (SELECT AVG(sal) FROM emp);

--�μ��� �ְ� ����
SELECT ename, job, sal,deptno
FROM emp
where (sal,deptno) in (SELECT MIN(sal),deptno
                        FROM emp
                        GROUP BY deptno);

SELECT MIN(sal)
FROM emp;
SELECT *
FROM emp
WHERE sal >= (SELECT AVG(sal)
            FROM emp);
            
SELECT MAX(sal), job
FROM emp
GROUP BY job;

--�������� 
SELECT ename, sal ,job
FROM emp
WHERE (sal,job) IN(SELECT MAX(sal), job
                    FROM emp
                    GROUP BY job);

SELECT ename, sal, job, sal*1.5 "Increase Sal"
FROM emp
WHERE sal = (SELECT MIN(sal) FROM emp);
--IN ������ ���
SELECT sal, ename, job
FROM emp
WHERE sal IN((SELECT MIN(sal) FROM emp),(SELECT MAX(sal) FROM emp))
ORDER BY sal;

SELECT ename,sal, deptno, hiredate
FROM emp
WHERE sal <= (SELECT avg(sal) FROM emp);

SELECT ename,sal, deptno, hiredate
FROM emp
WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY deptno)
ORDER BY deptno;

SELECT ename,sal, e.deptno,dname,hiredate
FROM emp e JOIN dept d ON e.deptno = d. deptno
WHERE sal IN (SELECT MAX(sal) FROM emp GROUP BY deptno)
ORDER BY deptno;

SELECT E.* , ROWNUM
FROM (SELECT * FROM emp ORDER BY empno) e;

SELECT * 
FROM emp
ORDER BY sal DESC;

SELECT * 
FROM (SELECT * 
    FROM emp
    ORDER BY sal DESC)
WHERE ROWNUM <=5
ORDER BY sal DESC;

SELECT *  
FROM (  Select a.* ,rownum num
        FROM (Select * from emp order by saL desc) a
    )  
WHERE num between 1 and 3;

SELECT *
FROM (SELECT T.*,ROWNUM R FROM(
                SELECT * FROM emp ORDER BY hiredate)T)
WHERE R BETWEEN 1 AND 3;

SELECT ename, sal, job, deptno, dname
FROM (SELECT T.*,ROWNUM R 
      FROM(SELECT e.*, dname 
           FROM emp e JOIN dept d ON e.deptno = d.deptno
           WHERE e.deptno = 30 
           ORDER BY sal DESC)T )
WHERE R BETWEEN 1 AND 3;

SELECT *
FROM (SELECT T.*, ROWNUM R FROM(SELECT *
                                FROM emp
                                ORDER BY sal DESC)T)
WHERE R BETWEEN 6 AND 10;

SELECT ename, sal, deptno, dname, hiredate
FROM (SELECT T.*, ROWNUM R FROM(SELECT e.*, dname
                                FROM emp e JOIN dept d ON e.deptno = d.deptno
                                ORDER BY sal DESC)T)
WHERE R BETWEEN 6 AND 10;   

DESC emp;

----------[VIEW]----------
CREATE VIEW VW_EMP
AS
SELECT empno,ename,job,hiredate,deptno 
FROM emp;

SELECT * FROM tab;
DESC vw_emp;
SELECT * FROM vw_emp;
SELECT �����ȣ, �̸�, �Ի��� FROM vw_emp;
DESC VW_EMP;
CREATE OR REPLACE VIEW VW_EMP("�����ȣ","�̸�","����","�Ի���","�μ��ڵ�")
AS
SELECT EMPNO, ENAME,JOB,HIREDATE,DEPTNO
FROM EMP;

DROP VIEW vw_emp;
SELECT * FROM tab;

CREATE OR REPLACE VIEW VW_EMP_DEPT
AS
SELECT empno, ename, job, dname
FROM emp e JOIN dept d ON e.deptno = d.deptno
ORDER BY ename
WITH READ ONLY;

SELECT * FROM vw_emp_dept;
DESC user_views;
SELECT VIEW_NAME,TEXT,READ_ONLY FROM USER_VIEWS;
----------[VIEW ��]----------

----------[INDEX]----------
select * from user_ind_columns; --���÷��� ������ �ε��� ����
CREATE INDEX IDX_EMP ON emp(sal,comm,deptno);
DROP INDEX IDX_EMP;
----------[INDEX ��]----------

--�ý��� ���� Ȯ���ϱ� -> DDL�� ���õ� ������ �ý��� ���� , ANY�� �� ���ѵ� �ý��� ����
SELECT * FROM SYSTEM_PRIVILEGE_MAP;
--���̺�� ���õ� ����
SELECT * FROM TABLE_PRIVILEGE_MAP;

----------[PL/SQL]-----------
DESC DEPT;
VAR dept_name varchar2(14);
VAR dept_loc varchar2(13);

DECLARE
    dept_no dept.deptno%TYPE :=40;
BEGIN
    SELECT dname, loc INTO :dept_name, :dept_loc
    FROM dept
    WHERE deptno = dept_no;
END;
/
PRINT dept_name;
PRINT dept_loc;
PRINT dept_name dept_loc;
SELECT :dept_name, :dept_loc FROM dual;

set serverout on;
show serverout;

----------[�ֿ� �����Լ�]-----------
--���� ����
select ename, sal, comm, nvl(comm,'-1') from emp
where nvl(comm,-1) = -1;

select lower('hello') from dual;
select ename, initcap(ename), job, lower(job) from emp;

select initcap('hello') from dual;
select initcap('HELLO') from dual;

select concat('HELLO', ' HI') from dual;
select concat(concat('HELLO', ' HI'), '!!!') from dual;

select length('��ο�') from dual;
select lengthb('��ο�') from dual;

select lpad('1',2,'0' ) from dual;
select lpad(job,length(job)+1,'*' ) from emp;
select rpad('HELLO',10,'123' ) from dual;
select job, length(job),rpad(job,length(job)+2,'-' )
from emp;

select instr('JAVA','Va') from dual;
select ename from emp 
where lower(ename) like '%s%';
select ename from emp 
where instr(lower(ename),'s') != 0 ;

select substr('abcd',2,3) from dual;

--�� �̸��� ù���ڸ� ����ϱ�
select rpad(substr(ename,1,1),length(ename),'*')
from emp;
--���� ��
select replace('HELLO WORLD', 'HELLO','JAVA') from dual;

select job, replace(job,'SALESMAN', 'SALESWOMEN') from emp;

select to_char(19.1547,'09.99') from dual;
select to_char(sysdate,'dy pm hh:mi') from dual;
select to_char(hiredate,'yyyy"��"mm"��"dd"��" dy') hiredate from emp;

select to_char(to_date('2020"��"09"��"24"��"'),'yyyy-mm-dd') from dual;
select to_number('100') + to_number('200') from dual;

select 'x'|| trim('   j  a  v  a    ')||'x' from dual;

--�� 2020-9-1 ���� d-day ���ϱ�
--100��
select to_char(to_date('2020-9-1')+100,'yyyy"��"mm"��"dd"��"') from dual;
select sysdate - to_date('2019-10-3')+1 from dual;
--��¥����
select months_between(
to_date(to_char(sysdate,'yyyy-mm-dd')), 
to_date('2020-07-1')) 
from dual;

select add_months(sysdate,3) from dual;

--���� ����
select round(3.545) from dual;
select floor(3.999999) from dual;
select ceil(3.1) from dual;
select power(2,3) from dual;
select sqrt(9) from dual;

set serverout on;

accept num prompt '�����Է�?'
declare
    str nvarchar2(50);
    not_number exception;
    PRAGMA EXCEPTION_init(not_number,-01722);
begin
    select decode(mod('&num',3),0,'�������� 0', 1, '�������� 1','�������� 2') into str
    from dual;
    dbms_output.put_line(str);
    
    exception
    when not_number then
        dbms_output.put_line('���ڸ� �Է��ϼ���');
end;
/

select ename, job, decode(job,'CLERK', '����','SALESMAN', '�������', '��Ÿ') ��å
from emp;

select ename, job, 
                case job when 'CLERK' then '����'
                         when 'SALESMAN' then '�������'
                         else '��Ÿ'
                         end  ��å
from emp;
select ename, sal, 
                case when sal >= 3000 then '��� ������'
                         when sal >= 2000 then '�߰� ������'
                         else '�Ҿ� ������'
                         end  ��������,job
from emp;