
--1��
SELECT ROUND(MAX(SALARY),0) AS maxSalary ,  --�ִ뿬��
       MIN(SALARY) AS minSalary,            --�ּҿ���
       SUM(SALARY) AS sumSalary,            --�����հ�
       AVG(SALARY) AS avgSalary             --�������
FROM EMPLOYEES
GROUP BY JOB_ID;


--2��
SELECT B.DEPARTMENT_NAME AS departmentName,                 --�μ���
       B.LOCATION_ID AS locationId,                         --��ġID
       ROUND(COUNT(B.DEPARTMENT_ID),2) AS countEmployee,    --�μ�������Ѽ�
       ROUND(AVG(A.SALARY),2) AS avgSalary                  --�μ�����տ���
FROM EMPLOYEES A, DEPARTMENTS B
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY B.DEPARTMENT_NAME, B.LOCATION_ID;


--3��
SELECT EMPLOYEE_ID AS employeeId,   --���
       HIRE_DATE AS hireDate        --��볯¥
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 
    (SELECT DEPARTMENT_ID
     FROM EMPLOYEES
     WHERE LAST_NAME = 'Zlotkey'
     );


--4��
CREATE OR REPLACE VIEW VW_EMPLOYEES
AS
SELECT EMPLOYEE_ID AS employeeId, SALARY as salary
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT *
FROM VW_EMPLOYEES;


--5��
SELECT LAST_NAME, FIRST_NAME
FROM EMPLOYEES A
WHERE NOT EXISTS (
            SELECT *
            FROM EMPLOYEES B
            WHERE A.EMPLOYEE_ID = B.MANAGER_ID
            )
;








create table mymember(
    mem_id varchar2(8) not null,  -- ȸ��ID
    mem_name varchar2(100) not null, -- �̸�
    mem_tel varchar2(50) not null, -- ��ȭ��ȣ
    mem_addr varchar2(128),    -- �ּ�
    CONSTRAINT MYMEMBER_PK PRIMARY KEY (mem_id)
);


create table jdbc_board(
    board_no number not null,  -- ��ȣ(�ڵ�����)
    board_title varchar2(100) not null, -- ����
    board_writer varchar2(50) not null, -- �ۼ���
    board_date date not null,   -- �ۼ���¥
    board_content clob,     -- ����
    constraint pk_jdbc_board primary key (board_no)
);
create sequence board_seq
    start with 1   -- ���۹�ȣ
    increment by 1; -- ������
