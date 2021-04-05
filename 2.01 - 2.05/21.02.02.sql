CREATE TABLE S(
    C VARCHAR2(10),
    D VARCHAR2(10),
    E VARCHAR2 (10),
    CONSTRAINT PK_S PRIMARY KEY(C)
);

CREATE TABLE R(
    A VARCHAR2 (10),
    B VARCHAR2 (10),
    C VARCHAR2 (10),
    CONSTRAINT PK_R PRIMARY KEY(A),
    CONSTRAINT FK_R FOREIGN KEY(C)
        REFERENCES S(C)
);

INSERT INTO S (C,D,E)
VALUES ('c1','d1','e1');

INSERT INTO S(C,D,E)
VALUES ('c3','d2','e2');

INSERT INTO R(A,B,C)
VALUES ('a1', 'b1', 'c1');

INSERT INTO R(A,B,C)
VALUES ('a2', 'b2', 'c2');

--참조무결성 : 외래키가 기본키를 참조할 때 부모테이블에 존재하는 기본키에 있는 데이터만 자식테이블에 들어갈 수 있다.
SELECT * FROM S;
SELECT * FROM R;

SELECT *
FROM R,S;

SELECT *
FROM S CROSS JOIN R;

SELECT A,B,C,C,D,E
FROM S,R;

SELECT R.A,R.B,R.C
      ,S.C,S.D,S.E
FROM S,R;


SELECT R.A,R.B,R.C
      ,S.C,S.D,S.E
FROM S,R
WHERE R.C = S.C;

--ANSI
SELECT R.A,R.B,R.C
      ,S.C,S.D,S.E
FROM S INNER JOIN R
ON (R.C = S.C);

--상품테이블에서 거래처가 삼성전자인 자료의
--상품코드, 상품명, 거래처 명 조회
SELECT PROD_ID 상품코드
    ,  PROD_NAME 상품명
    ,  BUYER_NAME 거래처명
FROM PROD, BUYER
WHERE BUYER_NAME LIKE '삼성전자'
AND BUYER_ID = PROD_BUYER;

--ANSI
SELECT PROD_ID 상품코드
    ,  PROD_NAME 상품명
    ,  BUYER_NAME 거래처명
FROM PROD INNER JOIN BUYER
ON (BUYER_NAME LIKE '삼성전자' AND BUYER_ID = PROD_BUYER);

--장바구니번호, 상품코드, 구입개수, 회원ID, 회원명
-- CART, MEMBER
--2005년도 4월 데이터로 한정, 상품코드를 상품분류코드로 바꾸기
--장바구니번호 년월로 바꾸기
--월별, 상품분류별, 회원별, 구입개수합계를 구하기

SELECT *
FROM CART;

SELECT TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,6), 'YYYY-MM'),'YYYY"년"MM"월"') 장바구니번호
    ,  SUBSTR(CART_PROD,1,4) 상품분류코드
    ,  CART_MEMBER 회원ID
    ,  SUM(CART_QTY) 구입개수
    ,  MEM_NAME 회원명
FROM CART, MEMBER
WHERE CART_NO LIKE '200504%'
AND CART_MEMBER = MEM_ID
GROUP BY TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,6), 'YYYY-MM'),'YYYY"년"MM"월"'), SUBSTR(CART_PROD,1,4),CART_MEMBER,MEM_NAME
ORDER BY 1,2,4;
--월, 상품분류, 회원 별 구입 개수의 합(중복제거)


----------------
SELECT PROD_ID
    ,  PROD_LGU
    ,  LPROD_NM
FROM PROD, LPROD
WHERE PROD_LGU = LPROD_GU;

SELECT PROD_ID
    ,  PROD_NAME
    ,  PROD_BUYER
    ,  BUYER_NAME
FROM PROD, BUYER
WHERE PROD_BUYER = BUYER_ID;

SELECT CART_NO 장바구니번호
    ,  CART_PROD 장바구니상품
    ,  CART_QTY 구매개수
    ,  CART_MEMBER 회원ID
    ,  MEM_NAME 회원명
FROM CART,MEMBER
WHERE CART_MEMBER = MEM_ID;

--AVG() : 조회 범위 내 해당 컬럼 들의 평균 값
--DISTINCT : 중복된 값은 제외 | ALL : Default로써 모든 값을 포함
--Collumn명 : NULL값은 제외 | * : NULL값도 포함(COUNT함수만 사용)
SELECT AVG(DISTINCT PROD_COST) 중복제거평균
    ,  AVG(PROD_COST) 중복포함평균
    ,  AVG(ALL PROD_COST) default포함평균
FROM PROD;

--상품테이블의 상품분류별 매입가격 평균 값
SELECT PROD_LGU 상품분류
    ,  AVG(PROD_COST) 매입가격
FROM PROD
GROUP BY PROD_LGU
ORDER BY PROD_LGU;

