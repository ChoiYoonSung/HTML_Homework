--
--연봉 12000 이상, last name, salary 검색
SELECT LAST_NAME lastName, SALARY Salary
FROM EMPLOYEES
WHERE SALARY >= 12000
ORDER BY 2, 1;

--사원번호 176인 사람의 last name 과 부서번호 조회
SELECT LAST_NAME 이름, DEPARTMENT_ID 부서번호
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176;

--연봉 5000 ~ 12000 last name /salary
select last_name, salary
from employees
where salary>=5000 and salary <=12000
order by salary, last_name;














