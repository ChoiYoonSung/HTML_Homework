--
--���� 12000 �̻�, last name, salary �˻�
SELECT LAST_NAME lastName, SALARY Salary
FROM EMPLOYEES
WHERE SALARY >= 12000
ORDER BY 2, 1;

--�����ȣ 176�� ����� last name �� �μ���ȣ ��ȸ
SELECT LAST_NAME �̸�, DEPARTMENT_ID �μ���ȣ
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176;

--���� 5000 ~ 12000 last name /salary
select last_name, salary
from employees
where salary>=5000 and salary <=12000
order by salary, last_name;














