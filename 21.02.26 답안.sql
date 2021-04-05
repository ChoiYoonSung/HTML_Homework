
--1번
SELECT ROUND(MAX(SALARY),0) AS maxSalary ,  --최대연봉
       MIN(SALARY) AS minSalary,            --최소연봉
       SUM(SALARY) AS sumSalary,            --연봉합계
       AVG(SALARY) AS avgSalary             --연봉평균
FROM EMPLOYEES
GROUP BY JOB_ID;


--2번
SELECT B.DEPARTMENT_NAME AS departmentName,                 --부서명
       B.LOCATION_ID AS locationId,                         --위치ID
       ROUND(COUNT(B.DEPARTMENT_ID),2) AS countEmployee,    --부서별사원총수
       ROUND(AVG(A.SALARY),2) AS avgSalary                  --부서별평균연봉
FROM EMPLOYEES A, DEPARTMENTS B
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY B.DEPARTMENT_NAME, B.LOCATION_ID;


--3번
SELECT EMPLOYEE_ID AS employeeId,   --사번
       HIRE_DATE AS hireDate        --고용날짜
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 
    (SELECT DEPARTMENT_ID
     FROM EMPLOYEES
     WHERE LAST_NAME = 'Zlotkey'
     );


--4번
CREATE OR REPLACE VIEW VW_EMPLOYEES
AS
SELECT EMPLOYEE_ID AS employeeId, SALARY as salary
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT *
FROM VW_EMPLOYEES;


--5번
SELECT LAST_NAME, FIRST_NAME
FROM EMPLOYEES A
WHERE NOT EXISTS (
            SELECT *
            FROM EMPLOYEES B
            WHERE A.EMPLOYEE_ID = B.MANAGER_ID
            )
;








create table mymember(
    mem_id varchar2(8) not null,  -- 회원ID
    mem_name varchar2(100) not null, -- 이름
    mem_tel varchar2(50) not null, -- 전화번호
    mem_addr varchar2(128),    -- 주소
    CONSTRAINT MYMEMBER_PK PRIMARY KEY (mem_id)
);


create table jdbc_board(
    board_no number not null,  -- 번호(자동증가)
    board_title varchar2(100) not null, -- 제목
    board_writer varchar2(50) not null, -- 작성자
    board_date date not null,   -- 작성날짜
    board_content clob,     -- 내용
    constraint pk_jdbc_board primary key (board_no)
);
create sequence board_seq
    start with 1   -- 시작번호
    increment by 1; -- 증가값
