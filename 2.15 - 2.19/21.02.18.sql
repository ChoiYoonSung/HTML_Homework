-- '가파치' 업체의 지역을 검색하여 다음과 같이 출력
--대구 : 경북
--부산 : 경남
--대전 : 충청
--서울,인천 : 수도권
--기타 : 기타
--CASE문 활용
SET SERVEROUTPUT ON
/
DECLARE
  V_BUYER BUYER.BUYER_NAME%TYPE;
  V_ADD BUYER.BUYER_ADD1%TYPE;
  V_ADD2 VARCHAR2(10);
BEGIN
  SELECT BUYER_NAME, SUBSTR(BUYER_ADD1,1,2) INTO V_BUYER, V_ADD FROM BUYER WHERE BUYER_NAME = '가파치';
  CASE WHEN V_ADD = '대구' THEN V_ADD2 := '경북';
       WHEN V_ADD = '부산' THEN V_ADD2 := '경남';
       WHEN V_ADD = '대전' THEN V_ADD2 := '충남';
       WHEN V_ADD IN ('서울', '인천') THEN V_ADD2 := '수도권';
       ELSE V_ADD2 := '기타';
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE(V_BUYER || '의 주소는 '|| V_ADD2 ||'입니다.');
END;
/

--WHILE
--WHILE LOOP ---- END LOOP
--1 ~ 10 더하기
DECLARE
  V_SUM NUMBER := 0;
  V_VAR NUMBER := 1;
BEGIN
  WHILE V_VAR <= 10 LOOP
    V_SUM := V_SUM + V_VAR;
    V_VAR := V_VAR + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_SUM);
END;
/
DECLARE
  V_DAN NUMBER := 2;
  V_EX NUMBER;
BEGIN
  WHILE V_DAN < 10 LOOP
    DBMS_OUTPUT.PUT_LINE(V_DAN || '단');
    V_EX := 1;
    WHILE V_EX < 10 LOOP
      DBMS_OUTPUT.PUT_LINE(V_DAN || ' x ' || V_EX || ' = ' || V_DAN*V_EX);
      V_EX := V_EX + 1;
      END LOOP;
    V_DAN := V_DAN + 1;
    END LOOP;
END;
/

DECLARE
  V_ADD NUMBER(5) := 1000;
  V_CODE CHAR(4) := '';
  V_ID NUMBER(5) := 0;
BEGIN
  SELECT MAX(LPROD_ID) INTO V_ID
  FROM LPROD;
  WHILE V_ADD <= 1005 LOOP
      V_ADD := V_ADD + 1;
      V_ID  := V_ID + 1;
        V_CODE := 'TT' || SUBSTR(TO_CHAR(V_ADD), -2);
        INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) VALUES(V_ID, V_CODE, 'LOOP TEST');
        
    END LOOP;
END;

/
ROLLBACK;

SELECT * FROM LPROD;

/
DECLARE
  i NUMBER;
BEGIN
  --i : 자동선언 정수형 변수
  FOR i IN 1..10 LOOP
      DBMS_OUTPUT.PUT_LINE('i = ' || i);
      END LOOP;
END;
/

--FOR문 사용 구구단 출력

BEGIN
  FOR A IN 2..9 LOOP
  DBMS_OUTPUT.PUT_LINE(A || '단');
    FOR B IN 1..9 LOOP
      DBMS_OUTPUT.PUT_LINE(A || ' x ' || B || ' = ' || A*B);
      END LOOP;
    END LOOP;
END;
/

--변수 및 for문 활용 LPROD 테이블
--LPROD_ID, LPROD_GU, LPROD_NM 출력
--최소값 최대값 변수로 처리
DECLARE
  V_ID LPROD.LPROD_ID%TYPE;
  V_GU LPROD.LPROD_GU%TYPE;
  V_NM LPROD.LPROD_NM%TYPE;
  V_MIN LPROD.LPROD_ID%TYPE;
  V_MAX LPROD.LPROD_ID%TYPE;
BEGIN
  SELECT MIN(LPROD_ID), MAX(LPROD_ID) INTO V_MIN, V_MAX FROM LPROD;
  FOR I IN V_MIN..V_MAX LOOP
  SELECT LPROD_ID, LPROD_GU, LPROD_NM INTO V_ID, V_GU, V_NM FROM LPROD WHERE LPROD_ID = I;
    DBMS_OUTPUT.PUT_LINE(V_ID || ' ' || V_GU || ' ' || V_NM);
    END LOOP;
END;
/

--EXCEPTION (예외처리)
--1. 정의된 Oracle Server Error
--2. 정의 되지 않은 Oracle Server Error
--3. 사용자 정의 Error
--대부분의 예외에서는 구문 그대로 읽으면 알 수 있다

DECLARE
  V_NM VARCHAR2(30);
BEGIN
  SELECT LPROD_NM INTO V_NM
  FROM LPROD
  WHERE LPROD_GU = 'Z101';
  
  DBMS_OUTPUT.PUT_LINE(V_NM);
  
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('정보 없음' || SQLCODE || SQLERRM);
      WHEN TOO_MANY_ROWS THEN
       DBMS_OUTPUT.PUT_LINE('다중행 오류' || SQLCODE|| SQLERRM);
      WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('기타 오류');
      
END;
/
