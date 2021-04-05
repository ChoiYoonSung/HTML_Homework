--기존코드를 사용하되 최소한의 수정만 할 수 있도록

--
SELECT TO_DATE('1996-10-22') + 12000
FROM DUAL;

--나는 몇 일을 살았고 몇 끼를 먹었으며 식비로 얼마를 지출했는가?
SELECT TO_DATE('1996-10-22') 생일
,      TO_DATE('2021-01-27') - TO_DATE('1996-10-22') 산날짜
,      (TO_DATE('2021-01-27') - TO_DATE('1996-10-22'))*3 끼니횟수
,      (TO_DATE('2021-01-27')- TO_DATE('1996-10-22'))*3*10000 끼니비용
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') 현재날짜
FROM DUAL;

SELECT ROUND(SYSDATE - TO_DATE('2021-01-27'),5) 일_차
FROM DUAL;

--ADD_MONTHS(date, n) : date에 월을 더한 날짜
SELECT ADD_MONTHS(SYSDATE,5)
FROM DUAL;

--NEXT_DAY(date, char) : 해당 날짜 이후 가장 빠른 요일의 날짜
--LAST_DAY(date) : 월의 마지막 날짜
SELECT NEXT_DAY(SYSDATE, '화')
FROM DUAL;

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--이번달이 며칠이 남았는지 검색
--Alias 오늘날짜, 이달마지막날짜, 이달남은날짜
SELECT SYSDATE 오늘날짜
,      LAST_DAY(SYSDATE) 이달마지막날짜
,      LAST_DAY(SYSDATE)-SYSDATE 이달남은날짜
FROM DUAL;

--자주 사용되는 날짜 포멧
--년도 : YYYY / 월 : MM / 일 : DD / 시간 : HH, HH12, HH24 / 분 : MI / 초 : SS

--EXTRACT(fmt FROM date)
--날짜에서 필요한 부분 추출
SELECT EXTRACT(YEAR FROM SYSDATE)연
    ,  EXTRACT(MONTH FROM SYSDATE) 월
    ,  EXTRACT(HOUR FROM SYSTIMESTAMP)+9 시 --UTC + 9(한국기준)
    ,  EXTRACT(MINUTE FROM SYSTIMESTAMP) 분
FROM DUAL;

CREATE TABLE TEMP(
    TEMP_ID VARCHAR2(10),
    REGISTER_ID VARCHAR2(50),
    REGIST_TS TIMESTAMP,
    UPDATER_ID VARCHAR2(50),
    UPDATE_TS TIMESTAMP,
    CONSTRAINT PK_TEMP PRIMARY KEY(TEMP_ID)
);

INSERT INTO TEMP(TEMP_ID, REGISTER_ID, REGIST_TS, UPDATER_ID, UPDATE_TS)
VALUES('F101','admin',SYSTIMESTAMP,'admin',SYSTIMESTAMP);

COMMIT;
SELECT * FROM TEMP;

--생일 3월 회원
--Alias 회원ID 회원명, 생일
SELECT MEM_ID 회원ID, MEM_NAME 회원명, MEM_BIR 생일
FROM MEMBER
WHERE EXTRACT(MONTH FROM MEM_BIR) = 3;
--WHERE MEM_BIR LIKE '__/03/__';
--WHERE MEM_BIR LIKE '%/03/%';
--WHERE SUBSTR(MEM_BIR,4,2) = '03';

--EXTRACT 날짜를 찾을 때 숫자형으로 나옴

--SCHEMA 스키마 -> 구조
--테이블 스키마 : 컬럼, 자료형, 크기, 제약사항, 키...

--입고상품(BUYPROD) 중 3월에 입고된 내역
--Alias 상품코드(prod), 입고일자(date), 매입수량(qty), 매입단가(cost)
SELECT BUY_PROD 상품코드,
       BUY_DATE 입고일자,
       BUY_QTY 매입수량,
       BUY_COST 매입단가
FROM BUYPROD
WHERE EXTRACT(MONTH FROM BUY_DATE) = 3
ORDER BY BUY_DATE;
--WHERE BUY_DATE LIKE '%/03/%';
--WHERE BUY_DATE LIKE '__/03/__';
--WHERE SUBSTR(BUY_DATE, 4, 2) = '03';

/*
date 형식의 데이터를 보면 "YY/MM/DD" 형식으로 되어있는데
EXTRACT를 사용함으로써 년,월,일 을 추출할 수 있다
결과가 숫자형이기 때문에 숫자로 비교연산 해야 함
*/

--형변환
--CAST(EXPR AS type) 명시적으로 형 변환
--TO_CHAR 숫자,문자,날짜를 지정한 형식의 문자열 변환
--TO_NUMBER 숫자 형식의 문자열을 숫자로 변환
--TO_DATE 날짜 형식0의 문자열을 숫자로 변환

SELECT '[' || 'Hello' || ']' "문자"
    ,  '[' || CAST('Hello' AS CHAR(30)) || ']' "CHAR형변환"
    ,  '[' || CAST('Hello' AS VARCHAR2(30)) || ']' "VARCHAR2형변환"
FROM DUAL;

SELECT CAST('2021-01-27' AS DATE)
FROM DUAL;

SELECT CAST(SYSDATE AS DATE)
FROM DUAL;

--TO_CHAR (중요)★★★
--(char) char,clob 타입을 varchar2로 변환
--(date, fmt) 날짜를 특정 형식의 문자열로 변환
--(number, fmt) 숫자를 특정 형식의 문자열로 변환

SELECT TO_CHAR(SYSDATE, 'AD YYYY"년", CC"세기"')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('2015-05-08', 'YYYY-MM-DD'), 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

--상품테이블에서 상품입고일을 'YYYY-MM-DD HH24:MI:SS' 형식으로 나오게 검색
--Alias 상품명 상품판매가 입고일(INSDATE)
SELECT PROD_NAME prodName --상품명
    ,  PROD_SALE prodSale --상품판매가
    ,  TO_CHAR(PROD_INSDATE, 'YYYY-MM-DD HH24:MI:SS') prodInsdate --입고일
FROM PROD
ORDER BY 3, 1;


