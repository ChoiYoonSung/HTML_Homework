--NESTED 서브쿼리1(2021-02-09 여기서부터..)
--NESTED 서브쿼리 : WHERE절에 사용된 서브쿼리
--상품분류가 컴퓨터제품인 상품의 리스트를 출력하기
--ALIAS : 상품코드, 상품명, 상품분류코드
SELECT PROD_ID AS 상품코드
    ,  PROD_NAME AS 상품명
    ,  PROD_LGU AS 상품분류코드
    ,  LPROD_NM
FROM PROD, LPROD
WHERE PROD_LGU = LPROD_GU
AND LPROD_NM = '컴퓨터제품';

SELECT PROD_ID AS 상품코드
    ,  PROD_NAME AS 상품명
    ,  PROD_LGU AS 상품분류코드
FROM PROD
WHERE PROD_LGU = (SELECT LPROD_GU FROM LPROD WHERE LPROD_NM = '컴퓨터제품');

--상품분류가 컴퓨터제품인 거래처 리스트를 출력하기
--ALIAS : 거래처코드, 거래처명, 상품분류코드
SELECT BUYER_ID
    ,  BUYER_NAME
    ,  BUYER_LGU
FROM BUYER
WHERE BUYER_LGU = (SELECT LPROD_GU FROM LPROD WHERE LPROD_NM = '컴퓨터제품');

--상품분류가 전자제품인 상품매입 현황 리스트를 출력하기
--ALIAS : 입고일자, 상품코드, 매입수량, 매입단가
--힌트 : 상품코드에 상품분류코드가 있음.
SELECT BUY_DATE 입고일자
    ,  SUBSTR(BUY_PROD,1,4) 상품코드
    ,  BUY_QTY 매입수량
    ,  BUY_COST 매입단가
FROM BUYPROD
WHERE SUBSTR(BUY_PROD,1,4) = (
        SELECT LPROD_GU
        FROM LPROD
        WHERE LPROD_NM = '전자제품'
        );

--장바구니테이블에서 정은실 회원의 구매 현황
--주문번호, 상품코드, 회원ID, 수량
SELECT CART_NO
    ,  CART_PROD
    ,  CART_MEMBER
    ,  CART_QTY
FROM CART
WHERE CART_MEMBER = (
        SELECT MEM_ID
        FROM MEMBER
        WHERE MEM_NAME = '정은실'
        );

--피리어스 업체로부터 들어온 상품의 리스트 출력
--상품ID, 상품명, 업체코드, 업체명
SELECT PROD_ID      상품ID
    ,  PROD_NAME    상품명
    ,  PROD_BUYER   업체코드
    ,  (SELECT BUYER_NAME 
        FROM BUYER
        WHERE BUYER_ID = PROD_BUYER) 업체명
FROM PROD
WHERE PROD_BUYER = (
        SELECT BUYER_ID
        FROM BUYER
        WHERE BUYER_NAME = '피리어스');

--김은대 회원 구매내역
SELECT CART_NO 주문번호
    ,  CART_PROD 상품코드
    ,  (SELECT PROD_NAME 
        FROM PROD 
        WHERE PROD_ID = CART_PROD) 상품명
    ,  CART_MEMBER 회원ID
    ,  (SELECT MEM_NAME 
        FROM MEMBER
        WHERE MEM_ID = CART_MEMBER) 회원명
    ,  CART_QTY 수량
FROM CART
WHERE CART_MEMBER = (
        SELECT MEM_ID
        FROM MEMBER
        WHERE MEM_NAME = '김은대'
        );

--INLINE VIEW
--상품테이블 판매가 > 상품평균판매가 상품
--상품명, 판매가, 평균판매가
--SCALAS / NESTED SUBQUERY
SELECT PROD_NAME 상품명
    ,  PROD_SALE 판매가
    ,  (SELECT AVG(PROD_SALE) FROM PROD) 평균판매가
FROM PROD, (SELECT AVG(PROD_SALE) AVG_SALE FROM PROD) A
WHERE PROD_SALE > (SELECT AVG(PROD_SALE) FROM PROD)
GROUP BY PROD_NAME, PROD_SALE;
--INLINE VIEW
SELECT PROD_NAME 상품명
    ,  PROD_SALE 판매가
    ,  A.AVG_SALE 평균판매가
FROM PROD, (SELECT AVG(PROD_SALE) AVG_SALE FROM PROD) A
WHERE PROD_SALE > A.AVG_SALE;

--회원테이블 마일리지 평균마일리지보다 큰 회원 검색
--회원명 마일리지 평균마일리지
SELECT MEM_NAME 회원명 
    ,  MEM_MILEAGE 마일리지
    ,  ROUND(M.AVG_MILEAGE,2) 평균마일리지
FROM MEMBER, (SELECT AVG(NVL(MEM_MILEAGE,0)) AVG_MILEAGE FROM MEMBER) M
WHERE MEM_MILEAGE > M.AVG_MILEAGE
ORDER BY 2 DESC;

--상관관계 서브쿼리
--바깥쪽 쿼리의 컬럼 중의 하나가 안쪽 서브쿼리의 조건에 이용되고
--그 결과는 다시 바깥쪽 쿼리에 영향을 주는 처리방식

--장바구니 테이블 회원별 최고의 구매수량을 가진 자료
--회원 주문번호 상품 수량
SELECT   A.CART_MEMBER    AS "회원"
     ,   A.CART_NO        AS "주문번호"
     ,   A.CART_PROD      AS "상품"
     ,   A.CART_QTY       AS "수량" 
FROM     CART A
WHERE    A.CART_QTY = (
            SELECT MAX(CART_QTY)
            FROM CART B
            WHERE B.CART_MEMBER = A.CART_MEMBER
            )
ORDER BY CART_MEMBER ASC;

--입고테이블 상품별
--최고 매입수량을 가진 자료
--입고일자 상품코드 매입수량 매입단가
SELECT A.BUY_DATE
    ,  A.BUY_PROD
    ,  A.BUY_QTY
    ,  A.BUY_COST
FROM BUYPROD A
WHERE A.BUY_QTY = (
        SELECT MAX(B.BUY_QTY)
        FROM BUYPROD B
        WHERE B.BUY_PROD = A.BUY_PROD
        )
ORDER BY A.BUY_PROD;

--장바구니테이블 일자별 최고의 구매수량
--회원 주문번호 상품 수량
--Alias 회원 일자 상품 수량
SELECT  A.CART_MEMBER    회원ID
    ,   (SELECT MEM_NAME
         FROM MEMBER
         WHERE CART_MEMBER = MEM_ID) 회원이름
    ,   TO_CHAR(TO_DATE(SUBSTR(A.CART_NO,1,8)),'YYYY"년" MM"월" DD"일"') 주문일자
    ,   A.CART_PROD      상품
    ,   A.CART_QTY       수량
FROM    CART A
WHERE   A.CART_QTY = (
        SELECT MAX(B.CART_QTY)
        FROM CART B
        WHERE SUBSTR(B.CART_NO,1,8) = SUBSTR(A.CART_NO,1,8)
        )
ORDER BY A.CART_NO;
