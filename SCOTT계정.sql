
 ----------[SELECT문]----------
SELECT DISTINCT job
FROM emp;
--DISTINCT 중복행 제거 컬럼이 2개 이상이면 AND 연산으로 처리
SELECT DISTINCT ename, job, deptno
FROM emp;

SELECT DISTINCT job, deptno
FROM emp;
--WHERE로 조건 지정
SELECT ename, sal
FROM emp
WHERE sal >= 3000;

SELECT ename, sal,job
FROM emp;

SELECT ename, sal,job
FROM emp
WHERE job ='SALESMAN'; --데이터는 대소문자를 구분한다

SELECT ename, sal,job
FROM emp
WHERE job ='SALESMAN' AND sal >=1500;

SELECT ename, sal,job
FROM emp
WHERE job !='SALESMAN' AND sal >=1500;

--컬럼명 BETWEEN a AND b   -> 컬럼명 >= a AND 컬럼명 <= b
SELECT ename, sal, job
FROM emp
WHERE sal BETWEEN 1500 AND 3000;

--IN연산자 OR로 연결된 것과 같다
--컬럼명 IN (값1, 값2) -> 컬럼명 = 값1 OR 컬럼명 = 값2 와 같다.
SELECT ename,sal, job
FROM emp
WHERE job IN ('SALESMAN','CLERK');
--칼럼2개 사용한 IN연산자는 ()로 감싸서 처리한다.
SELECT ename, sal, job, deptno
FROM emp
WHERE (job,deptno) IN (('CLERK',20),('SALESMAN',30) );
SELECT ename, sal, job, deptno
FROM emp
WHERE job = 'CLERK' AND deptno = 20 OR job = 'SALESMAN' AND deptno = 30
ORDER BY deptno;

--Like연산자
--S로 시작하는 데이터 검색
SELECT ename FROM emp WHERE ename LIKE 'S%';
--S로 끝나는 데이터 검색
SELECT ename FROM emp WHERE ename LIKE '%S';
--AR이 들어가는 데이터 검색
SELECT ename FROM emp WHERE ename LIKE '%AR%';
--3번째 글자가 A인 데이터 검색
SELECT ename FROM emp WHERE ename LIKE '__A%';

SELECT ename FROM emp WHERE ename LIKE '__A%' AND NOT ename LIKE 'A%';

--IS NULL연산자
SELECT ename, job, comm
FROM emp
WHERE comm IS NOT NULL ;

--문제
SELECT empno 사원번호, ename 이름,job 직책,sal 연봉
FROM emp
WHERE job = 'MANAGER' AND sal BETWEEN 2500 AND 3000;

SELECT empno 사원번호, ename 이름,job 직책,sal 연봉, dname 부서명
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
--문제 끝

--ORDER BY
SELECT ename, sal
FROM emp
ORDER BY  sal DESC; --DESC 내림차순 정렬

SELECT ename, job, deptno
FROM emp
ORDER BY  job, deptno; --JOB으로 먼저 정렬후 JOB이 중복되는 데이터는 DEPTNO로 정렬

SELECT ename, sal 
FROM emp
WHERE sal >= 1500
ORDER BY ename;

SELECT ename, sal
FROM emp e
WHERE e.sal >= 1500
ORDER BY e.deptno;

--문제
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

--문제 끝 --
--그룹함수 사용, group by
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

--문제
SELECT COUNT(*)
FROM emp
WHERE sal >=1000 AND ename LIKE('%S');

SELECT AVG(sal)
FROM emp
WHERE job = 'SALESMAN';
--문제 끝
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
--오라클식
SELECT empno, ename, sal, job, e.deptno, dname,loc
FROM emp e, dept d
where e.deptno = d.deptno;
--표준 sql 식 
SELECT empno, ename, sal, job, e.deptno, dname,loc
FROM emp e JOIN dept d ON e.deptno = d.deptno;

--OUTER JOIN 
--자식 기준 : INNER JOIN과 같다.
SELECT empno, ename, sal, job, e.deptno, dname,loc
FROM emp e LEFT OUTER JOIN dept d ON e.deptno = d.deptno;
--부모기준에서 해야 유의미한 의미가 있다
SELECT empno, ename, sal, job, d.deptno, dname,loc
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;
--충원이 안된 부서의 이름과 위치 그리고 부서 코드 조회
SELECT d.deptno, dname, loc
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno = d.deptno
WHERE empno is null;
--SELF JOIN
SELECT e.ename ||'의 매니저는' || m.ename ||' 입니다.' 조직도
FROM emp e JOIN emp m on e.mgr = m.empno;

SELECT t.* 
FROM (SELECT empno, ename, hiredate, deptno FROM emp) t;
SELECT ename, sal 
FROM emp
WHERE sal > = (SELECT AVG(sal) FROM emp);

--부서별 최고 연봉
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

--서브질의 
SELECT ename, sal ,job
FROM emp
WHERE (sal,job) IN(SELECT MAX(sal), job
                    FROM emp
                    GROUP BY job);

SELECT ename, sal, job, sal*1.5 "Increase Sal"
FROM emp
WHERE sal = (SELECT MIN(sal) FROM emp);
--IN 연산자 사용
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
SELECT 사원번호, 이름, 입사일 FROM vw_emp;
DESC VW_EMP;
CREATE OR REPLACE VIEW VW_EMP("사원번호","이름","직무","입사일","부서코드")
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
----------[VIEW 끝]----------

----------[INDEX]----------
select * from user_ind_columns; --※컬럼에 설정된 인덱스 보기
CREATE INDEX IDX_EMP ON emp(sal,comm,deptno);
DROP INDEX IDX_EMP;
----------[INDEX 끝]----------

--시스템 권한 확인하기 -> DDL과 관련된 권한은 시스템 권한 , ANY가 들어간 권한도 시스템 권한
SELECT * FROM SYSTEM_PRIVILEGE_MAP;
--테이블과 관련된 권한
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

----------[주요 내장함수]-----------
--문자 관련
select ename, sal, comm, nvl(comm,'-1') from emp
where nvl(comm,-1) = -1;

select lower('hello') from dual;
select ename, initcap(ename), job, lower(job) from emp;

select initcap('hello') from dual;
select initcap('HELLO') from dual;

select concat('HELLO', ' HI') from dual;
select concat(concat('HELLO', ' HI'), '!!!') from dual;

select length('헬로우') from dual;
select lengthb('헬로우') from dual;

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

--문 이름의 첫글자만 출력하기
select rpad(substr(ename,1,1),length(ename),'*')
from emp;
--문제 끝
select replace('HELLO WORLD', 'HELLO','JAVA') from dual;

select job, replace(job,'SALESMAN', 'SALESWOMEN') from emp;

select to_char(19.1547,'09.99') from dual;
select to_char(sysdate,'dy pm hh:mi') from dual;
select to_char(hiredate,'yyyy"년"mm"월"dd"일" dy') hiredate from emp;

select to_char(to_date('2020"년"09"월"24"일"'),'yyyy-mm-dd') from dual;
select to_number('100') + to_number('200') from dual;

select 'x'|| trim('   j  a  v  a    ')||'x' from dual;

--문 2020-9-1 부터 d-day 구하기
--100일
select to_char(to_date('2020-9-1')+100,'yyyy"년"mm"월"dd"일"') from dual;
select sysdate - to_date('2019-10-3')+1 from dual;
--날짜관련
select months_between(
to_date(to_char(sysdate,'yyyy-mm-dd')), 
to_date('2020-07-1')) 
from dual;

select add_months(sysdate,3) from dual;

--수학 관련
select round(3.545) from dual;
select floor(3.999999) from dual;
select ceil(3.1) from dual;
select power(2,3) from dual;
select sqrt(9) from dual;

set serverout on;

accept num prompt '숫자입력?'
declare
    str nvarchar2(50);
    not_number exception;
    PRAGMA EXCEPTION_init(not_number,-01722);
begin
    select decode(mod('&num',3),0,'나머지가 0', 1, '나머지가 1','나머지가 2') into str
    from dual;
    dbms_output.put_line(str);
    
    exception
    when not_number then
        dbms_output.put_line('숫자만 입력하세요');
end;
/

select ename, job, decode(job,'CLERK', '점원','SALESMAN', '영업사원', '기타') 직책
from emp;

select ename, job, 
                case job when 'CLERK' then '점원'
                         when 'SALESMAN' then '영업사원'
                         else '기타'
                         end  직책
from emp;
select ename, sal, 
                case when sal >= 3000 then '고액 연봉자'
                         when sal >= 2000 then '중간 연봉자'
                         else '소액 연봉자'
                         end  연봉레벨,job
from emp;