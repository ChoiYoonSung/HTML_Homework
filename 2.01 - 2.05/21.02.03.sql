--집계함수 정리
--SUM : 그룹하여 합계
--AVG : 그룹하여 평균
--MAX : 그룹하여 최대값
--MIN : 그룹하여 최소값
--COUNT : 그룹하여 개수
--집계함수를 사용할 때에는 괄호 () 를 무조건 사용해야 한다.

/*
조인(Oracle)
카티션 프로덕트 : 모든 행과 열을 조합
내부조인 : 기본키 외래키를 연결고리로 하여 조인
외부조인 : 한쪽 테이블의 모든 행을 출력
셀프조인 : 하나의 테이블이 여러 테이블처럼 처리

조인(ANSI)
CROSS JOIN : 모든 행과 열을 조합(카티션 프로덕트)
INNER JOIN : 기본키 외래키를 연결고리로 하여 조인(내부조인)
OUTER JOIN : 한쪽 테이블의 옴든 행을 출력(외부조인)
NATIRAL JOIN : 연결고리를 알아서 매핑하여 조인 (컬럼명이 같은 컬럼으로 알아서 찾음. 단, 하나의 컬럼이 같아야 한다)
SELF JOIN : 하나의 테이블이 여러 테이블처럼 처리(셀프조인)
*/

--PROD CART MEMBER 테이블 조인
--Oracle
SELECT *
FROM PROD P, CART C, MEMBER M
WHERE P.PROD_ID = C.CART_PROD
AND   C.CART_MEMBER = M.MEM_ID;
--ANSI
SELECT *
FROM CART C INNER JOIN PROD P ON (C.CART_PROD = P.PROD_ID)
          INNER JOIN MEMBER M ON (C.CART_MEMBER = M.MEM_ID);

--회원테이블의 취미종류수를 count집계 하시오
--Alias 취미종류수
SELECT COUNT(DISTINCT MEM_LIKE) 취미종류수
FROM MEMBER;

--회원테이블 취미별 COUNT
--Alias 취미, 자료수, 자료수*
SELECT MEM_LIKE 취미
    ,  COUNT(MEM_LIKE) 자료수
    ,  COUNT(*) "자료수(*)"
FROM MEMBER
GROUP BY MEM_LIKE;

--장바구니테이블 회원 별 count 집계
--Alias 회원ID, 구매수(DISTINCT), 구매수, 구매수(*)
SELECT CART_MEMBER 회원ID
    ,  COUNT(DISTINCT CART_MEMBER) "구매수(DISTINCT)"
    ,  COUNT(CART_MEMBER) 구매수
    ,  COUNT(*) 전체행의수
FROM CART
GROUP BY CART_MEMBER
ORDER BY 1;

--집계함수 이외의 컬럼들은 GROUP BY 절에 기술해야 함 

--MAX / MIN
--장바구니테이블의 회원별 최대 구매수량 검색
--Alias 회원ID, 최대수량, 최소수량
SELECT CART_MEMBER 회원ID
    ,  MAX  (CART_QTY) 최대수량
    ,  MIN (CART_QTY) 최소수량
FROM CART
GROUP BY CART_MEMBER;

--2005년 7월 11일이라 가정, 장바구니 테이블에 발생될 추가주문번호 검색
--Alias 최고치주문번호 추가주문번호
SELECT MAX (CART_NO) 최고치주문번호
    ,  MAX (CART_NO)+1 추가주문번호
FROM   CART
WHERE  CART_NO LIKE '20050711%';

--상품테이블
--거래처,상품분류별
--최고판매가, 최소판매가
SELECT PROD_LGU 상품분류
    ,  PROD_BUYER 거래처
    ,  MAX(PROD_SALE) 최대판매가
    ,  MIN(PROD_SALE) 최소판매가
    ,  COUNT(PROD_ID) 자료수
FROM PROD
GROUP BY PROD_LGU , PROD_BUYER
ORDER BY 1 ASC, 2 ASC;

--장바구니 테이블
-- 회원,상품분류별
--구매수량평균, 구매수량합계, 자료수
--Alias 회원ID, 상품분류, 구매수량평균, 구매수량합계, 자료수
--회원ID, 상품분류순
SELECT CART_MEMBER              회원ID
    ,  SUBSTR(CART_PROD,1,4)    상품분류
    ,  ROUND(AVG(CART_QTY),2)   구매수량평균
    ,  SUM(CART_QTY)            구매수량합계
    ,  COUNT(CART_NO)           자료수
FROM CART
GROUP BY CART_MEMBER, SUBSTR(CART_PROD,1,4)
ORDER BY 1, 2;

--회원테이블
--지역(주소1의 2자리), 생일년도별
--마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 자료수 검색
--Alias 지역, 생일연도, 마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 자료수
SELECT SUBSTR(MEM_ADD1,1,2) 지역
    ,  SUBSTR(MEM_BIR,1,2) 생일년도
    ,  ROUND(AVG(MEM_MILEAGE)) 마일리지평균
    ,  SUM(MEM_MILEAGE) 마일리지합계
    ,  MAX(MEM_MILEAGE) 최고마일리지
    ,  MIN(MEM_MILEAGE) 최소마일리지
    ,  COUNT(MEM_ID) 자료수
FROM MEMBER
GROUP BY SUBSTR(MEM_ADD1,1,2), SUBSTR(MEM_BIR,1,2)
ORDER BY 1, 2;

--상품테이블에서 상품코드, 상품명, 분류명, 거래처주소를 조회
--판매가격 10만원 이하
--거래처주소 부산인 경우
SELECT P.PROD_ID 상품코드
    ,  P.PROD_NAME 상품명
    ,  L.LPROD_NM 분류명
    ,  B.BUYER_ADD1 거래처주소
FROM PROD P, BUYER B, LPROD L
WHERE B.BUYER_ADD1 LIKE '%부산%'
AND P.PROD_SALE <= 100000
AND P.PROD_BUYER = B.BUYER_ID
AND P.PROD_LGU = L.LPROD_GU;

--ANSI
SELECT P.PROD_ID 상품코드
    ,  P.PROD_NAME 상품명
    ,  L.LPROD_NM 분류명
    ,  B.BUYER_ADD1 거래처주소
FROM PROD P INNER JOIN BUYER B ON P.PROD_BUYER = B.BUYER_ID
            INNER JOIN LPROD L ON P.PROD_LGU = L.LPROD_GU
WHERE B.BUYER_ADD1 LIKE '%부산%'
AND P.PROD_SALE <= 100000;

--상품입고테이블
--2005년도 1월 거래처별(거래처코드, 거래처명) 매입금액 검색 (매입금액 = 매입수량 * 매입단가)
--Alias 거래처코드, 거래처명, 매입금액
SELECT BUYER_ID 거래처코드
    ,  BUYER_NAME 거래처명
    ,  SUM(BUY_COST*BUY_QTY) 매입금액
FROM BUYPROD A,BUYER B,PROD C
WHERE A.BUY_PROD = C.PROD_ID
AND C.PROD_BUYER = B.BUYER_ID
AND BUY_DATE LIKE '05/01%'
GROUP BY BUYER_ID, BUYER_NAME;

--ANSI
SELECT BUYER_ID 거래처코드
    ,  BUYER_NAME 거래처명
    ,  SUM(BUY_COST*BUY_QTY) 매입금액
FROM PROD P INNER JOIN BUYER B ON P.PROD_BUYER = B.BUYER_ID
            INNER JOIN BUYPROD B ON B.BUY_PROD = P.PROD_ID
WHERE BUY_DATE LIKE '05/01%'
GROUP BY BUYER_ID, BUYER_NAME
ORDER BY SUM(BUY_COST*BUY_QTY) DESC;




