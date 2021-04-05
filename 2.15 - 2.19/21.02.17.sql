--뷰테이블 연습
--상품입고테이블 2005년도 1월 거래처별 매입금액 검색 (매입금액 = 매입수량 * 매입단가)
--vw_inamt
--거래처코드 거래처명 매입금액

CREATE OR REPLACE VIEW VW_INAMT
AS
SELECT B.PROD_BUYER buyerid
    ,  A.BUYER_NAME buyername
    ,  SUM(C.BUY_QTY * C.BUY_COST) inamt
FROM BUYER A INNER JOIN PROD B ON A.BUYER_ID = B.PROD_BUYER
           INNER JOIN BUYPROD C ON B.PROD_ID = C.BUY_PROD
WHERE C.BUY_DATE LIKE '05/01/%'
GROUP BY B.PROD_BUYER, A.BUYER_NAME, C.BUY_DATE
ORDER BY C.BUY_DATE;

SELECT * FROM VW_INAMT;

SELECT BUYERID 거래처코드
    ,  BUYERNAME 거래처명
    ,  TO_CHAR(INAMT,'L999,999,999') 매입금액
FROM  VW_INAMT
ORDER BY 3 DESC;

--PL/SQL

--선택 : DECLARE
--필수 : BEGIN, END
/
--PL/SQL 문을 최초로 사용하기 전 SERVEROUTPUT을 켜야 한다.
SET SERVEROUTPUT ON
/
DECLARE
  v_i       NUMBER(9,2) := 123456.78;
  v_str     VARCHAR2(20) := '홍길동';
  c_pi      CONSTANT NUMBER(8,6) := 3.141592;
  v_flag    BOOLEAN NOT NULL := TRUE;
  v_date    VARCHAR2(10) := TO_CHAR(SYSDATE, 'YYYY-MM-DD');
BEGIN
  DBMS_OUTPUT.PUT_LINE( 'v_i : ' || v_i); 
  DBMS_OUTPUT.PUT_LINE( 'v_str : ' || v_str);
  DBMS_OUTPUT.PUT_LINE( 'c_pi : ' || c_pi);
  DBMS_OUTPUT.PUT_LINE( 'v_flag : ' || v_flag);
  DBMS_OUTPUT.PUT_LINE( 'v_date : ' || v_date);
END;
/
--조건이 true이면 이하 문장을 실행
--조건이 false이면 관련된 문장 통과
--elsif절 여러개 가능, else절은 한 개만 가능

DECLARE
  V_NUM NUMBER := 37;
BEGIN
  --DBMS_OUTPUT.ENABLE;
  IF MOD(V_NUM, 2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE(V_NUM || '는 짝수');
  ELSE
    DBMS_OUTPUT.PUT_LINE(V_NUM || '는 홀수');
  END IF;
END;

/
DECLARE
  V_NUM NUMBER := 37;
BEGIN
  IF V_NUM > 90 THEN
    DBMS_OUTPUT.PUT_LINE('수');
  ELSIF V_NUM > 80 THEN
    DBMS_OUTPUT.PUT_LINE('우');
  ELSIF V_NUM > 70 THEN
    DBMS_OUTPUT.PUT_LINE('미');
  ELSE
    DBMS_OUTPUT.PUT_LINE('분발');
  END IF;
END;
/

DECLARE
  V_AVG_SALE PROD.PROD_SALE%TYPE;
  V_SALE NUMBER := 500000;
BEGIN
  SELECT AVG(PROD_SALE) INTO V_AVG_SALE FROM PROD;
  IF V_SALE < V_AVG_SALE THEN
    DBMS_OUTPUT.PUT_LINE('평균 단가가 500000 초과입니다.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('평균 단가가 500000 이하입니다.');
  END IF;
END;
/

--회원테이블 아이디 'e001'인 회원의 마일리지
--5000 넘으면 vip회원, 아니면 일반회원으로 출력
DECLARE
  V_MILEAGE NUMBER := 0;
  V_NAME MEMBER.MEM_NAME%TYPE;
BEGIN
  SELECT MEM_MILEAGE, MEM_NAME INTO V_MILEAGE, V_NAME FROM MEMBER WHERE MEM_ID = 'e001';
  IF V_MILEAGE > 5000 THEN
    DBMS_OUTPUT.PUT_LINE('VIP 회원');
  ELSE
    DBMS_OUTPUT.PUT_LINE('일반회원.');
  END IF;
  DBMS_OUTPUT.PUT_LINE(V_NAME || '님의 마일리지는 ' || V_MILEAGE || '입니다.');
END;
/
--상품분류 화장품 상품의 평균판매가
--3000미만 : 싸다, 3000 ~ 6000 보통
--6000 ~ 9000 비싸다 , 9000 ~ 너무비싸다

DECLARE
  V_SALE NUMBER;
BEGIN
  SELECT AVG(PROD_SALE) INTO V_SALE FROM PROD WHERE PROD_LGU = (SELECT LPROD_GU FROM LPROD WHERE LPROD_NM = '화장품');
  CASE WHEN V_SALE < 3000 THEN
         DBMS_OUTPUT.PUT_LINE('싸다');
       WHEN V_SALE >= 3000 AND V_SALE < 6000 THEN
         DBMS_OUTPUT.PUT_LINE('보통');
       WHEN V_SALE >= 6000 AND V_SALE < 9000 THEN
         DBMS_OUTPUT.PUT_LINE('비싸다');
       ELSE 
         DBMS_OUTPUT.PUT_LINE('너무 비싸다');
  END CASE;
  DBMS_OUTPUT.PUT_LINE('화장품의 평균판매가는 ' || V_SALE || '원 입니다.');
END;
/

-- 가파치 업체의 지역을 검색하여 다음과 같이 출력
--대구 : 경북
--부산 : 경남
--대전 : 충청
--서울,인천 : 수도권
--기타 : 기타
--CASE문 활용

DECLARE
  V_BUYER BUYER.BUYER_NAME%TYPE;
BEGIN
  SELECT SUBSTR(BUYER_ADD1,1,2) INTO V_BUYER FROM BUYER WHERE BUYER_NAME = '가파치';
  CASE WHEN V_BUYER = '대구' THEN
         DBMS_OUTPUT.PUT_LINE(V_BUYER || '의 위치는 경북입니다.');
       WHEN V_BUYER = '부산' THEN
         DBMS_OUTPUT.PUT_LINE(V_BUYER || '의 위치는 경남입니다.');
       WHEN V_BUYER = '대전' THEN
         DBMS_OUTPUT.PUT_LINE(V_BUYER || '의 위치는 충청입니다.');
       WHEN V_BUYER = '서울' AND V_BUYER = '인천' THEN
         DBMS_OUTPUT.PUT_LINE(V_BUYER || '의 위치는 수도권입니다.');
       ELSE
         DBMS_OUTPUT.PUT_LINE(V_BUYER || '의 위치는 기타입니다.');
    END CASE;
END;


