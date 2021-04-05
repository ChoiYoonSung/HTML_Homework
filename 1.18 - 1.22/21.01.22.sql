--2021.01.22
--상품 중 판매가 150,000 or 170000 or 330000 상품 조회
SELECT *
FROM PROD
WHERE PROD_SALE = 150000 or PROD_SALE = 170000 or PROD_SALE = 330000;

--IN 사용 (or사용한 것과 같음)
--WHERE 컬럼 IN (조건) <-> 조건에 부합하지 않는 커럼 NOT IN
SELECT *
FROM PROD
WHERE PROD_SALE IN(170000 , 150000, 330000);

--회원테이블에서
--회원ID가 c001 , f001 , w001인 회원 검색
--Alias : mem_id, mem_name
SELECT MEM_ID 회원ID, MEM_NAME 회원명
FROM MEMBER
WHERE MEM_ID IN('c001' , 'f001', 'w001');

--상품 분류테이블에서 상품테이블에 존재하는 분류만 검색
--분류코드(LPROD_GU) 분류명(LPROD_NM)
SELECT LPROD_GU 분류코드, LPROD_NM 분류명
FROM LPROD
WHERE 1 = 1 AND LPROD_GU < 'P401';
--AND LPROD_GU IN('P101','P102', ... , 'P302');

--서브쿼리
SELECT LPROD_GU 분류코드, LPROD_NM 분류명
FROM LPROD
WHERE 1 = 1 AND LPROD_GU IN(SELECT DISTINCT PROD_LGU FROM PROD);
--WHERE절에 사용된 또다른 QWERY : NESTED 서브쿼리(중첩 서브쿼리)

--문제
--거래처 테이블에서 현재 상품테이블에 존재하는 거래처만 검색
--Alias : 거래처ID(BUYER_ID), 거래처명(BUYER_NAME)
SELECT BUYER_ID 거래처ID, BUYER_NAME 거래처명
FROM BUYER
WHERE BUYER_ID IN(SELECT DISTINCT PROD_BUYER FROM PROD);

--BETWEEN : 범위 내 모든 값을 탐색
--          두 범위의 한계 값을 포함
-- BETWEEN A AND B
--상품 중 판매가 100000 ~ 300000
SELECT *
FROM PROD
WHERE PROD_SALE BETWEEN 100000 AND 300000
ORDER BY PROD_SALE;

--회원 중 생일 1975 01 01 ~ 1976 12 31 사이에 태어난 회원
--alias : 회원ID 회원명 생일
select mem_id 회원ID , mem_name 회원명, mem_bir 생일
from member
where mem_bir between '75/01/01' and '76/12/31';

select *
from member;







