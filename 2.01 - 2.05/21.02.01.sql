--CASE WHEN ~ THEN ~ ELSE ~ END (중요)
--연속적인 조건문
--1. Simple-Case-Expression
SELECT
CASE '나' WHEN '철호' THEN 'NO'
          WHEN '나' THEN 'YES'
          WHEN '너' THEN 'NO'
          ELSE '?'
          END RESULT
FROM DUAL;
--2. Searched-Case-Expression
SELECT
CASE  WHEN '철호' = '나' THEN 'NO'
      WHEN '나' = '나' THEN 'YES'
      WHEN '너' = '나' THEN 'NO'
      ELSE '?'
      END RESULT
FROM DUAL;
--Simple 보다 Searched가 많이 쓰인다.
--Searched : 확장성이 높다

SELECT PROD_NAME
    ,  PROD_LGU
    , CASE
        WHEN PROD_LGU = 'P101' THEN '컴퓨터'
        WHEN PROD_LGU = 'P102' THEN '전자제품'
        WHEN PROD_LGU = 'P201' THEN '여성캐쥬얼'
        WHEN PROD_LGU = 'P202' THEN '남성캐쥬얼'
        WHEN PROD_LGU = 'P301' THEN '피혁잡화'
        WHEN PROD_LGU = 'P302' THEN '화장품'
        WHEN PROD_LGU = 'P401' THEN '음반/CD'
        WHEN PROD_LGU = 'P402' THEN '도서'
        WHEN PROD_LGU = 'P403' THEN '문구류'
    ELSE ' '
    END RESULT
FROM PROD;

--회원테이블 주민등록번호 첫번째 자리 성별 구분
--Alias 회원ID 회원명 주민번호2 성별
--Case When문 사용
SELECT MEM_ID 회원ID
    ,  MEM_NAME 회원명
    ,  MEM_REGNO2 주민번호2
    ,  CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = 1 OR SUBSTR(MEM_REGNO2, 1, 1) = 3 THEN '남'
            WHEN SUBSTR(MEM_REGNO2, 1, 1) = 2 OR SUBSTR(MEM_REGNO2, 1, 1) = 4 THEN '여'
            WHEN MEM_REGNO2 LIKE '1%' THEN '남'
            WHEN MEM_REGNO2 LIKE '2%' THEN '여'
            ELSE '출력불가' 
        END 성별 
FROM MEMBER;

--10만원 초과 상품 판매가 가격대
SELECT PROD_NAME 상품명
    ,  PROD_SALE 판매가
    ,  CASE WHEN (100000 - PROD_PRICE) >=0 THEN '10만원 미만'
            WHEN (200000 - PROD_PRICE) >=0 THEN '10만원대'
            WHEN (300000 - PROD_PRICE) >=0 THEN '20만원대'
            WHEN (400000 - PROD_PRICE) >=0 THEN '30만원대'
            WHEN (500000 - PROD_PRICE) >=0 THEN '40만원대'
            WHEN (600000 - PROD_PRICE) >=0 THEN '50만원대'
            WHEN (700000 - PROD_PRICE) >=0 THEN '60만원대'
            WHEN (800000 - PROD_PRICE) >=0 THEN '70만원대'
            WHEN (900000 - PROD_PRICE) >=0 THEN '80만원대'
            WHEN (1000000 - PROD_PRICE) >=0 THEN '90만원대'
            ELSE '100만원 이상'
        END 가격대
FROM PROD;

--Table Join
--RBB의 핵심
--관계형 DB의 가장 큰 장점은 많은 TABLE을 JOIN함 원하는 결과를 도출하는데 있다
--Cartesian Product : 모든 가능한 행들의 조합
--Oracle 구문
SELECT *
FROM PROD, LPROD;
--Ansi 표준 구문
SELECT *
FROM PROD CROSS JOIN LPROD;

SELECT *
FROM LPROD
WHERE LPROD_ID > 9;

SELECT PROD.PROD_ID 상품코드
    ,  PROD.PROD_NAME 상품명
    ,  LPROD.LPROD_NM 분류명
    ,  LPROD.LPROD_GU 기본키
    ,  PROD.PROD_LGU 외래키
FROM PROD, LPROD;


--Equi Join : 조건이 일치하는 컬럼을 매칭
SELECT PROD.PROD_ID 상품코드
    ,  PROD.PROD_NAME 상품명
    ,  LPROD.LPROD_NM 분류명
    ,  LPROD.LPROD_GU 기본키
    ,  PROD.PROD_LGU 외래키
FROM PROD, LPROD
WHERE LPROD.LPROD_GU = PROD.PROD_LGU;

--상품ID, 상품명, 거래처명
SELECT *
FROM BUYER, PROD;

SELECT PROD.PROD_ID
    ,  PROD.PROD_NAME
    ,  BUYER.BUYER_NAME
    ,  BUYER.BUYER_ID
    ,  PROD.PROD_BUYER
FROM BUYER, PROD
WHERE BUYER.BUYER_ID = PROD.PROD_BUYER;

SELECT B.PROD_ID
    ,  B.PROD_NAME
    ,  A.BUYER_NAME
    ,  A.BUYER_ID
FROM PROD B , BUYER A
WHERE BUYER_ID = PROD_BUYER;

--상품ID, 상품명, 입고일, 입고수량, 입고가격
--사품테이블, 입고테이블
SELECT A.PROD_ID
    ,  A.PROD_NAME
    ,  B.BUY_DATE
    ,  B.BUY_QTY
    ,  B.BUY_COST
FROM PROD A, BUYPROD B
WHERE B.BUY_PROD = A.PROD_ID;

--EQUI JOIN (ANSI 표준)
SELECT A.PROD_ID
    ,  A.PROD_NAME
    ,  B.BUY_DATE
    ,  B.BUY_QTY
    ,  B.BUY_COST
FROM PROD A INNER JOIN BUYPROD B
ON (B.BUY_PROD = A.PROD_ID);

--장바구니번호, 상품코드, 구매개수, 회원ID, 회원명
--CART, MEMBER
--EQUI JOIN (Oracle)
SELECT C.CART_NO AS 장바구니번호
    ,  C.CART_PROD AS 상품코드
    ,  C.CART_QTY AS 구매개수
    ,  C.CART_MEMBER
    ,  M.MEM_ID AS 회원ID
    ,  M.MEM_NAME AS 회원명
FROM CART C, MEMBER M
WHERE C.CART_MEMBER = M.MEM_ID;
--FROM CART C INNER JOIN MEMBER M
--ON (C.CART_MEMBER = M.MEM_ID);

SELECT * FROM MEMBER;
SELECT * FROM CART;

--장바구니번호, 상품코드, 구매개수, 회원ID, 회원명, 상품명
--CART, MEMBER, PROD
SELECT CART_NO 장바구니번호
    ,  CART_PROD 상품코드
    ,  CART_QTY 구매개수
    ,  MEM_ID 회원ID
    ,  MEM_NAME 회원명
    ,  PROD_NAME 상품명
FROM CART, MEMBER, PROD
WHERE CART_MEMBER = MEM_ID
AND CART_PROD = PROD_ID;

--ANSI 표준
SELECT C.CART_NO 장바구니번호
    ,  C.CART_PROD 상품코드
    ,  C.CART_QTY 구매개수
    ,  M.MEM_ID 회원ID
    ,  M.MEM_NAME 회원명
    ,  P.PROD_NAME 상품명
FROM CART C INNER JOIN MEMBER M ON CART_MEMBER = MEM_ID
            INNER JOIN PROD P ON  CART_PROD = PROD_ID ;

--Non-Equi Join : 조건절에서 JOIN 조건이 '='이 아닌 다른 연산기호로 주어지는 경우
--Outer Join : 조건이 일치하지 않더라도 모든 행들을 검색하고자 할 때 사용, (+)로 표시
--Self Join : 한 테이블 내에서 Join하는 경우




