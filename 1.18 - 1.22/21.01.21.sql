--상품 테이블이 상품분류를 중복되지 않게 검색
SELECT *
FROM LPROD;

SELECT *
FROM PROD;

SELECT PROD_LGU AS 상품분류
FROM PROD;

SELECT DISTINCT PROD_LGU 상품분류 --DISTINCT 중복제거
FROM PROD;

--상품 테이블이 거래처코드를 중복되지 않게 검색하시오
SELECT *
FROM PROD;

SELECT DISTINCT PROD_BUYER 거래처
FROM PROD;

SELECT DISTINCT PROD_LGU 상품분류명, PROD_BUYER 거래처
FROM PROD;

--ASCENDING(오름차순, ASC) <-> DECENDING (내림차순, DESC)
--ORDER BY 절 사용
--alias 순서 지정 가능, DEFAULT는 ASC
--숫자, 날짜, 문자, NULL 등으로 표현 가능

--회원테이블에서 회원ID, 회원명, 생일, 마일리지 검색
SELECT MEM_ID, MEM_NAME, MEM_BIR, MEM_MILEAGE
FROM MEMBER
ORDER BY MEM_ID;

SELECT mem_id 회원, mem_name 이름
FROM MEMBER;

SELECT MEM_ID 회원ID, MEM_NAME 성명, MEM_BIR 생일, MEM_MILEAGE 마일리지
FROM MEMBER
ORDER BY 성명; --alias로 정렬 가능(성명, MEM_NAME)

SELECT MEM_ID, MEM_NAME, MEM_BIR, MEM_MILEAGE
FROM MEMBER 
ORDER BY 3; --검색하려는 컬럼의 순서로 정렬 가능(3번째, 생일)

SELECT MEM_ID, MEM_NAME, MEM_BIR, MEM_MILEAGE
FROM MEMBER 
ORDER BY MEM_MILEAGE, 1;
--1차로 회원마일리지(MEM_MILEAGE)로 오름차순 정렬한 후 정렬이 안된 값을 
--2차로 회원아이디(1, MEM_ID)로 오름차순 정렬

--상품테이블에서 1차로 상품분류로 오름차순 정렬 후 2차로 거래처코드로 내린차순 정렬
SELECT DISTINCT PROD_LGU 상품분류, PROD_BUYER 거래처
FROM PROD
ORDER BY 1, 2 DESC;

--상품 중 판매가가 170,000원인 상품 조회
SELECT *
FROM PROD
WHERE PROD_SALE = 170000; --특정 조건 조회하기 위해서 where절 사용

--상품 중 판매가가 170,000원이 아닌 상품 조회
SELECT *
FROM PROD
WHERE PROD_SALE != 170000
ORDER BY PROD_SALE;

--상품 중 판매가가 170,000원을 초과하는 상품 조회
SELECT *
FROM PROD
WHERE PROD_SALE > 170000
ORDER BY PROD_SALE;

--회원 중 76년도 1월 1일 이후에 태어난 회원을 검색
--주민등록번호 앞자리로 비교
--alias 회원id 히원 명 주민등록번호 앞자리

--실무에서 카멜 표기법을 주로 사용함(ex MEM_ID > memId)
SELECT MEM_ID 회원ID --memId
    , MEM_NAME 회원명 --memNae
    , MEM_REGNO1 주민등록번호_앞자리 --meRegno1
FROM MEMBER
WHERE MEM_REGNO1 > '760101' --문자열이기에 ''사용
ORDER BY MEM_REGNO1, MEM_NAME;

--논리연산자
--AND 조건 모두 참 / OR 조건 중 하나라도 참 /
--우선순위 : () NOT AND OR

--상품 중 상품분류가 P201(여성 캐쥬얼)이고 판매가가 170,000원인 상품 조회
select *
from prod;

SELECT *
FROM PROD
WHERE PROD_LGU = 'P201'
AND PROD_SALE = 170000;

--상품 중 상품분류가 P201이거나 판매가가 170,000원인 상품 조회
SELECT *
FROM PROD
WHERE PROD_LGU = 'P201'
OR PROD_SALE = 170000;

--상품 중 상품분류가 P201도 아니고 판매가가 170,000원도 아닌 상품 조회
SELECT *
FROM PROD
WHERE PROD_LGU != 'P201' AND PROD_SALE != 170000;

SELECT *
FROM PROD
WHERE NOT (PROD_LGU = 'P201' OR PROD_SALE = 170000);
--드모르간 정리

--상품 중 판매가가 300,000원 이상, 500,000원 이하인 상품 검색
--Alias 상품코드, 상품명, 판매가
SELECT PROD_ID 상품코드, PROD_NAME 상품명, PROD_SALE 판매가
FROM PROD
WHERE PROD_SALE >= 300000 OR PROD_SALE <= 500000;

--







