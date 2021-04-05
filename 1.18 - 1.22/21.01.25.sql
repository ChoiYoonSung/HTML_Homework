--LPAD RPAD
--LPAD : Left Padding / RPAD : Right Padding
--왼쪽 혹은 오른쪽에 여백을 채운 후 문자 혹은 숫자를 채움
SELECT LPAD ('Java', 10) "LPAD"
FROM DUAL;

--SELECT LPAD/RPAD ('문자', 길이, '여백에 채울 문자')"LPAD/RPAD"
SELECT RPAD('Java', 10, '*') "RPAD"
FROM DUAL;

SELECT LPAD ('*', 1, '*') FROM DUAL;
SELECT LPAD ('*', 2, '*') FROM DUAL;
SELECT LPAD ('*', 3, '*') FROM DUAL;
SELECT LPAD ('*', 4, '*') FROM DUAL;
SELECT LPAD ('*', 5, '*') FROM DUAL;

SELECT LPAD ('Java', 10, '*') "LPAD",
       RPAD ('JAVA', 12, '*') "RPAD"
FROM SYS.DUAL;

--상품테이블 소비자가(PROD_PRICE)와 소비자가격을 치환하여 다음과 같이 출력
--Alias : PROD_PRICE, PROD_RESULT
SELECT PROD_PRICE PROD_PRICE,
       LPAD (PROD_PRICE, 10, '*') PROD_RESULT
FROM PROD
ORDER BY PROD_PRICE;

--LTRIM/RTRIM
--공백 제거
SELECT '<' || LTRIM ('     AAA     ') || '>' "LTRIM1" FROM DUAL;
SELECT '<' || RTRIM ('     AAA     ') || '>' "RTRIM1" FROM DUAL;

--LEADING BOTH TRAILING
SELECT '<' || TRIM (LEADING 'a' FROM TRIM ('   aaaAAaaAbbAbaa  ')) || '>' LEADING_TRIM FROM DUAL;
SELECT '<' || TRIM (TRAILING 'a' FROM TRIM ('   aaaAAaaAbbAbaa  ')) || '>' TRAILING_TRIM FROM DUAL;
SELECT '<' || TRIM (BOTH 'a' FROM TRIM ('   aaaAAaaAbbAbaa  ')) || '>' BOTH_TRIM FROM DUAL;

--DUAL / SYS.DUAL 차이?
--DUAL : 가상의 테이블, SYS: SYS계정에서 소유

--SUBSTR 중요★
--SUBSTR('c', m, n)
--문자열의 일부분을 선택, c문자열의 m 숫자 위치부터 n 만큼의 문자 리턴
--m이 0 또는 1이면 첫 글자
--m이 음수이면 뒤쪽부터 처리
SELECT SUBSTR('SQL PROJECT', 1, 3) RESULT1 --앞에서 1자부터 시작
    ,  SUBSTR('SQL PROJECT', 5) RESULT2 --앞에서 5자부터 시작
    ,  SUBSTR('SQL PROJECT', -7, 4) RESULT3 --뒤에서 7자부터 시작
FROM DUAL;
--출력 결과
--SQL / PROJECT // PROJ

--성씨 조회
SELECT MEM_ID
    ,  SUBSTR(MEM_NAME, 1, 1) MEM_RESULT
FROM MEMBER;

--상품테이블 상품명(PROD_NAME)의 4째 자리부터 2글자가 '칼라'인 상품의 상품코드(PROD_ID), 상품명(PROD_NAME) 검색
--Alias PROD_ID, PROD_NAME
SELECT PROD_ID 상품코드, PROD_NAME 상품명
FROM PROD
WHERE SUBSTR(PROD_NAME, 4, 2) = '칼라';
--    SUBSTR(컬럼 명 ,시작지점,문자수) = '찾으려는 문자';

--SUBSTR보다 LIKE의 검색속도가 빠름
SELECT PROD_ID 상품코드, PROD_NAME 상품명
FROM PROD
WHERE PROD_NAME LIKE '___칼라%';

--장바구니 테이블(CART)에서 장바구니 번호(CART_NO)중 04월에 해당하는 데이터 출력
--Alias : CART_NO, CART_PROD
SELECT CART_NO 장바구니번호, CART_PROD 상품코드
    ,  SUBSTR(CART_NO, 5, 2) 월
FROM CART
WHERE SUBSTR(CART_NO, 5, 2) = 04;

SELECT CART_NO 장바구니번호, CART_PROD 상품코드
FROM CART
WHERE  CART_NO LIKE '____04%';

SELECT *
FROM CART;

--상품테이블 상품코드(PROD_ID) 왼쪽 4자리, 오른쪽 6자리 검색
SELECT PROD_ID 상품코드
    ,  SUBSTR(PROD_ID, 1, 4) 대분류
    ,  SUBSTR(PROD_ID, -6) 순번
FROM PROD;

--회원 id 출력
--alias 회원id, 앞1자, 나머지

SELECT MEM_ID 회원ID
    ,  SUBSTR(MEM_ID, 1, 1) 앞1자
    ,  SUBSTR(MEM_ID, 2) 나머지
FROM MEMBER;

--REPLACE

--회원테이블 회원성명 중 '이' -> '리'로 치환 검색
SELECT MEM_NAME 회원성명
    ,  REPLACE (MEM_NAME, '이', '리') 치환
FROM MEMBER;

SELECT MEM_NAME 회원성명
    , REPLACE (MEM_NAME, '이', '리') 회원명치환
FROM MEMBER
WHERE MEM_NAME LIKE '이%';

--INSTR(c1, c2 , m, n)
--c1문자열에서 c2문자가 처음 나타나는 위치 리턴
--m: 시작위치, n번째
SELECT INSTR('hello heidi', 'di') RESULT1
    ,  INSTR('hello heidi', 'he', 1, 2) RESULT2 --'hello heidi'라는 문자에서 'he'라는 문자열을 1번부터 2번째 나타나는 위치
    ,  INSTR('hello Hello HELLO', 'HE') RESULT3
FROM DUAL;

--i have a hat
--첫 번째 ha 위치
--두 번째 ha 위치
SELECT 'i have a hat' i_have_a_hat
    ,  INSTR('i have a hat', 'ha', 1, 1)
    ,  INSTR('i have a hat', 'ha', 1, 2)
    ,  INSTR('i have a hat', 'ha', -1)
FROM SYS.DUAL;

--I have a hat that i had have been found that hat before 2 years ago
--5번째 ha위치 출력
SELECT 'I have a hat that i had have been found that hat before 2 years ago'
    ,  INSTR('I have a hat that i had have been found that hat before 2 years ago', 'ha', 1, 5) fifth_ha
FROM SYS.DUAL;

--mepoh@test.com
--아이디|도메인 출력
SELECT 'mepoh@test.com'
    ,  SUBSTR('mepoh@test.com', 1, INSTR('mepoh@test.com', '@')-1) 아이디
    ,  SUBSTR('mepoh@test.com', INSTR('mepoh@test.com', '@')+1) 도메인
FROM DUAL;

--LENGTH : 공백포함 글자 수
--LENGTHB : 공백포함 byte 수(영문,숫자 : 1byte, 한글 : 3byte)
--거래처 코드, 명의 길이/byte 수
SELECT BUYER_ID 거래처코드
    ,  LENGTH(BUYER_ID) 거래처코드길이
    ,  BUYER_NAME 거래처명
    ,  LENGTH(BUYER_NAME) 거래처명길이
    ,  LENGTHB(BUYER_NAME) 거래처명byte
FROM BUYER;

--ABS : 절대값 / SIGN : 음,양,0 구분
--POWER : 승수 값 / SQRT : 제곱근
SELECT ABS(-365) FROM DUAL;
SELECT SIGN(12), SIGN(0), SIGN(-55) FROM DUAL;
SELECT POWER(3,2), POWER(2, 10) FROM DUAL;
SELECT SQRT(2), SQRT(9) FROM DUAL;

--GREATEST / LEAST : 가장 큰 값 / 가장 작은 값
SELECT GREATEST(10, 20, 30) "큰값"
    ,  LEAST(10, 20, 30) "작은_값"
    ,  GREATEST('강아지', 256, '송아지') "한글+숫자_큰값"
    ,  LEAST('강아지', 256, 'dog') "한글+숫자_작은값"
    ,  GREATEST('puppy', '강아지', 909)
    ,  LEAST('puppy', '강아지', 909)
FROM DUAL;

--ROUND / TRUNC : 반올림 / 버림
--ROUND(양수/0 : 자릿수 밑에서 반올림, 음수 : 자릿수에서 반올림)
SELECT ROUND(345.123 , 0) FROM DUAL;
SELECT ROUND(345.123 , 1) FROM DUAL;
SELECT ROUND(345.123 , 2) FROM DUAL;
SELECT ROUND(345.123 , -1) FROM DUAL;
SELECT ROUND(345.123 , -2) FROM DUAL;

SELECT TRUNC(345.123 , 0) FROM DUAL;
SELECT TRUNC(345.123 , 1) FROM DUAL;
SELECT TRUNC(345.123 , 2) FROM DUAL;
SELECT TRUNC(345.123 , -1) FROM DUAL;
SELECT TRUNC(345.123 , -2) FROM DUAL;

--회원테이블의 마일리지를 12로 나눈 값을 검색
--소수2째자리 살리기 반올림, 절삭
--1. ROUND(191.666666, 2) 결과?
SELECT MEM_MILEAGE 마일리지
    ,  ROUND(MEM_MILEAGE/12, 2) 소수점2자리반올림
    ,  TRUNC(MEM_MILEAGE/12, 2) 소수점2자리버림
FROM MEMBER;

--상품테이블 상품명, 원가율(매입가/판매가)을 비율로 검색
--반올림없는 것, 소수 첫째자리 살리기 반올림
--Alias 상품명, 원가율1, 원가율2
SELECT PROD_NAME 상품명
    ,  (PROD_COST/PROD_SALE)*100 원가율1
    ,  ROUND((PROD_COST/PROD_SALE)*100, 1) 원가율2
FROM PROD;

--상품테이블의 평균판매가를 소수점 2째자리까지 반올림
SELECT ROUND(AVG(PROD_SALE),2) 평균판매가
    ,  SUM(PROD_SALE) 판매가합계
FROM PROD;

--MOD : 나머지 (Java에서 %와 같은 기능)
SELECT MOD(10,3) FROM DUAL;

--FLOOR : n과 같거나 작은 수 중 가장 큰 정수
--CEIL : n과 같거나 큰 수 중 가장 작은 정수
SELECT FLOOR(1445.78), CEIL(1445.78) FROM DUAL;
SELECT FLOOR(-1445.78), CEIL(-1445.78) FROM DUAL;

--3.141592의 내림과 올림
SELECT -3.141592 원본
    ,  FLOOR(-3.141592) 내림
    ,  CEIL(-3.141592) 올림
FROM DUAL;

--REMAINDER

--SYSDATE
--시스템에서 제공하는 현재 날짜와 시간 값
SELECT SYSDATE FROM DUAL;

--TO_CHAR() : 문자로 형변환하는 함수, 이때 형식을 지정해줄 수 있음
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') 현재시간
    ,  SYSDATE - 1 "어제 이 시간"
    ,  SYSDATE + 1 "내일 이 시간"
    ,TO_CHAR(SYSDATE + 1/24, 'YYYY-MM-DD HH:MI:SS') 한시간뒤
FROM DUAL;

--회원테이블의 생일, 12000일째 되는 날 검색
SELECT MEM_NAME "이름"
    ,  MEM_BIR "생일"
    ,  MEM_BIR + 12000 "12000일째"
    , TO_DATE('1996/10/22') + 12000
FROM MEMBER;

