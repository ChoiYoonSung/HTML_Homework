--정규화
--복합기 관련 : 완전-불완전 - 제2정규화


--조인 정리
/*
카티젼프로덕트 : 모든 열과 행이 조합
내부조인 : 카티프로더트 결과에서 기본키 = 외래키 인 데이터
외부조인 : 한쪽의 모든 데이터를 출력(내부조인에서 파생됨)
셀프조인 : 하나의 테이블을 마치 여러개의 테이블처럼 조인
*/
--ANSI 표준
/*
CROSS JOIN : 카티젼프로덕트
INNER JOIN : 내부조인
OUTER JOIN : 외부조인
SELF JOIN : 셀프조인
NATURAL JOIN : 
*/
--집계함수 / 집계함수 이외 컬럼 GROUP BY절에 기술
/*
SUM : 합계
AVG : 평균
MIN : 최소
MAX : 최대
COUNT : 횟수
*/
--집계가 완료된 후에 집계함수 자체에 조건?
--HAVING

--JOB_ID별 최대,최소,평균,합계 연봉을 자연수로 포멧, 조회
SELECT A.JOB_ID       직원ID
    ,  MAX(B.MAX_SALARY)  최대연봉
    ,  MIN(B.MIN_SALARY)  최소연봉
    ,  ROUND(AVG(A.SALARY))  평균연봉
    ,  ROUND(SUM(A.SALARY))  연봉합계
FROM EMPLOYEES A, JOBS B
WHERE A.JOB_ID = B.JOB_ID
GROUP BY A.JOB_ID
ORDER BY 1;

--ANSI 표준
SELECT A.JOB_ID       직원ID
    ,  MAX(B.MAX_SALARY)  최대연봉
    ,  MIN(B.MIN_SALARY)  최소연봉
    ,  NVL((AVG(A.SALARY)),0)  평균연봉
    ,  NVL(ROUND(SUM(A.SALARY)),0)  연봉합계
FROM EMPLOYEES A LEFT OUTER JOIN JOBS B ON (A.JOB_ID = B.JOB_ID)
GROUP BY A.JOB_ID
ORDER BY 1;

--매니저의 사번 및 매니저 밑 사원들 중 최소연봉을 받는 사원의 연봉 조회
--연봉 6000 이상
SELECT MANAGER_ID 매니저사번
    ,  MIN(SALARY) 최소연봉
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING MIN(SALARY) >= 6000
ORDER BY MIN(SALARY) DESC;

SELECT A.MANAGER_ID 매니저사번
    ,  MIN(A.SALARY) 최소연봉
    ,  B.FIRST_NAME 성
    ,  B.LAST_NAME 이름
    ,  COUNT(A.EMPLOYEE_ID) 명
FROM EMPLOYEES A, EMPLOYEES B
WHERE A.MANAGER_ID = B.EMPLOYEE_ID 
AND A.MANAGER_ID IS NOT NULL
GROUP BY A.MANAGER_ID, B.FIRST_NAME, B.LAST_NAME
HAVING MIN(A.SALARY) >= 6000
ORDER BY MIN(A.SALARY) DESC;

--ANSI
SELECT A.MANAGER_ID
    ,  MIN(A.SALARY)
    ,  B.FIRST_NAME
    ,  B.LAST_NAME
FROM EMPLOYEES A INNER JOIN EMPLOYEES B ON A.MANAGER_ID = B.EMPLOYEE_ID 
WHERE A.MANAGER_ID IS NOT NULL
GROUP BY A.MANAGER_ID, B.FIRST_NAME, B.LAST_NAME
HAVING MIN(A.SALARY) >= 6000
ORDER BY MIN(A.SALARY) DESC;

--부서명, 위치ID, 각 부서 별 사원 총 수, 각 부서 별 평균 연봉
--평균 연봉 소수점 2자리 표현
SELECT A.DEPARTMENT_NAME 부서명
    ,  A.LOCATION_ID 위치ID
    ,  COUNT(B.EMPLOYEE_ID) 사원총수
    ,  ROUND(AVG(B.SALARY),2) 부서별평균연봉
FROM DEPARTMENTS A INNER JOIN EMPLOYEES B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY A.DEPARTMENT_NAME, A.LOCATION_ID
ORDER BY 1,2;

--서브쿼리(subquery)
--SQL 구문 안에 다른 SQL구문이 있는 것
--너무 많은 JOIN을 줄이기 위해
--괄호로 묶음
--연산자와 사용할 경우 오른쪽에 배치
--MAIN QUERY와 SUB QUERY 사이의 참조성 여부에 따라 연관, 비연관 서브쿼리로 구분
/*
SCALAR SUBQUERY : SELECT 절에 사용
INLINE VIEW : FROM절에 사용
NESTED SUBQUERY : WHERE  절에 사용
*/

--상품코드, 상품명, 거래처코드, 거래처명
--서브쿼리 이용
SELECT PROD_ID 상품코드
    ,  PROD_NAME 상품명
    ,  PROD_BUYER 거래처코드
    ,  (SELECT BUYER_NAME FROM BUYER WHERE BUYER_ID = PROD_BUYER) 거래처명
FROM PROD;

--회원ID(CART_MEMBEER) 회원명 주문번호 상품코드 수량
SELECT CART_MEMBER 회원ID
    ,  (SELECT MEM_NAME FROM MEMBER WHERE MEM_ID = CART_MEMBER) 회원명
    ,  CART_NO 주문번호
    ,  CART_PROD 상품코드
    ,  CART_QTY 수량
FROM CART
ORDER BY 1;

--입고일자(BUY_DATE) 상품코드(BUY_PROD), 상품명, 매입수량(BUY_QTY), 매입단가(BUY_COST)
SELECT BUY_DATE 입고일자
    ,  BUY_PROD 상품코드
    ,  (SELECT PROD_NAME FROM PROD WHERE PROD_ID = BUY_PROD) 상품명
    ,  BUY_QTY 매입수량
    ,  BUY_COST 매입단가
FROM BUYPROD;



--거래처코드 거래처명 상품분류코드 상품분류명
SELECT BUYER_ID 거래처코드
    ,  BUYER_NAME 거래처명
    ,  BUYER_LGU 상품분류코드
    ,  (
        SELECT LPROD_NM
        FROM LPROD
        WHERE LPROD_GU = BUYER_LGU
        ) 상품분류명
FROM BUYER;





