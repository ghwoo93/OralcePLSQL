--문제
SELECT first_name||' '||last_name "성 명", commission_pct, salary
FROM employees
where commission_pct IS NOT NULL AND salary >=5000 AND 
    last_name LIKE('S%');
    
desc employees;

SELECT first_name||' '||last_name "성 명", commission_pct, salary
FROM employees
where commission_pct IS NOT NULL AND salary >=5000 AND 
    last_name LIKE('_a%');
    
SELECT first_name||' '||last_name "성 명", phone_number, hire_date
FROM employees
WHERE  phone_number LIKE('011%');

SELECT department_id, MAX(salary) MAX 
FROM employees
GROUP BY department_id
ORDER BY MAX DESC;

SELECT department_id, AVG(salary) AVG 
FROM employees
WHERE salary >3000 and commission_pct IS NULL
GROUP BY department_id
ORDER BY AVG DESC;

SELECT job_id, AVG(salary) avg, department_id
FROM employees
WHERE salary >=3000
GROUP BY job_id, department_id
HAVING AVG(salary) >= 3500
ORDER BY job_id DESC;
--문제 끝
SELECT * FROM jobs;
SELECT * FROM departments;
--표준 sql식
SELECT employee_id, last_name, salary, d.department_id, department_name, 
e.job_id,job_title, city
FROM employees e JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
JOIN locations l ON l.location_id = d.location_id;

SELECT employee_id, last_name, salary, d.department_id, department_name, 
e.job_id,job_title, city
FROM employees e , departments d , jobs j , locations l
WHERE e.department_id = d.department_id AND 
    e.job_id = j.job_id AND l.location_id = d.location_id;
    
--문제
SELECT last_name ||' ' || first_name, salary,  department_name, city, c.country_id,
country_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON l.location_id = d.location_id
JOIN countries c ON l.country_id = c.country_id;

SELECT * FROM employees;

SELECT last_name ||' ' || first_name, salary, hire_date
FROM employees
WHERE department_id IS NULL;

SELECT d.department_id, department_name, city,country_name
FROM employees e RIGHT OUTER JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
WHERE employee_id IS NULL;

SELECT first_name, salary ,hire_date, department_name, city
FROM (SELECT T.*, ROWNUM R FROM(SELECT *
                            FROM employees e JOIN departments  d ON e. department_id = d.department_id
                            JOIN locations l ON d.location_id = l.location_id
                            ORDER BY hire_date DESC)T)
WHERE R BETWEEN 1 AND 5;
  
SELECT last_name || ' '|| first_name name , salary , department_name, city
FROM (SELECT T.*, ROWNUM R FROM(SELECT e.*, department_name,city
                            FROM employees e JOIN departments  d ON e. department_id = d.department_id
                            JOIN locations l ON d.location_id = l.location_id
                            ORDER BY salary DESC, last_name)T)
WHERE R BETWEEN 11 AND 20 AND salary >= 11000;

SELECT * FROM tab;

--문
select * from employees;
select last_name, rpad(substr(email,1,1),length(email),'*') email
, to_char(salary, '$999,999') salary, 
case when salary >= 10000 then '고액 연봉'
     when salary >= 5000 then '중간 연봉'
    else '보통 연봉'
    end  등급
, to_char(hire_date, 'yyyy"년"mm"월"dd"일"') hire_date
from employees
where substr(last_name,length(last_name),1) = 't'
order by last_name;

select last_name, email
from employees
where last_name like('%t');

select last_name
from employees;

