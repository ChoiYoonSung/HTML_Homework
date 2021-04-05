--회원이름과 생일로 다음처럼 출력되게 작성
--이름 님은 0월0일 출생하고 태어날 요일은 -요일 입니다.
SELECT MEM_NAME || '님은 '
    || TO_CHAR(MEM_BIR, 'YYYY"년" MON"월" DD"일"') || '출생하고 태어난 요일은 '
    || TO_CHAR(MEM_BIR, 'DAY"요일 입니다."') 출생일자
FROM MEMBER;
--YYYY 년도 | MM/MON 월 | DD 일 | DAY 요일 | HH(12/24) 시 | MI 분 | SS 초
--'YYYY-MM-DD HH:MI:SS'

--선택사항 - optional
--필수사항 - mandatory

--결합연산자(||) 
--상품코드(PROD_ID) 상품명(PROD_NAME)

SELECT '대분류코드는 ' || SUBSTR(PROD_ID, 1, 4) ||'이고, 순번은 '|| SUBSTR(PROD_ID, 5) ||'이다.'
FROM PROD;

--입고테이블(BUYPROD)
--상품코드 상품은 입고일자 에 매입수량 개가 입고됨
SELECT TO_CHAR(BUY_PROD) || ' 상품은 ' || TO_CHAR(BUY_DATE, 'YYYY"년 "MM"월 "DD"일에 ')
    || TO_CHAR(BUY_QTY) || '개가 입고됨' 입고현황
FROM BUYPROD;

--숫자 함수
--9 : 출력형식의 자리, 유효한 숫자인 경우 출력. 매핑이 되지 않으면 무시한다.
--0 : 출력형식의 자리, 무효한 숫자인 경우 0출력
--$,L : 달러 및 지역화폐기호
--MI : 음수인 경우 우측에 마이너스 표시, 우측에 표시
--PR : 음수인 경우 "<>"괄호로 묶는다, 우측에 표시
--, . : 해당 위치에 "," 표시, 소수점 기준
--X : 해당 숫자를 16진수로 출력, 단독 사용

--상품테이블
--상품코드, 상품명, 매입가격, 소비자가격, 판매가격
SELECT PROD_ID 상품코드
    ,  PROD_NAME 상품명
    ,  TO_CHAR(PROD_COST, 'L99,999,999') 매입가격
    ,  TO_CHAR(PROD_PRICE, 'L99,999,999') 소비자가격
    ,  TO_CHAR(PROD_SALE, 'L99,999,999') 판매가격
FROM PROD;

--상품테이블 상품코드, 상품명, 매입가격, 소비자가격, 판매

--숫자형 변환
--TO_NUMBER(char, fmt) : 숫자형식 문자열 숫자로 반환
--숫자형은 오른쪽 정렬, 문자형은 왼쪽정렬로 확인할 수 있음
SELECT TO_NUMBER('3.14159265358979'), TO_CHAR('3.14159265358979')
FROM DUAL;

SELECT TO_NUMBER('￦1,200','L9,999')+1
    ,  TO_CHAR(TO_NUMBER('￦1,200','L9,999')+TO_NUMBER('￦1,200','L9,999') , 'L999,999')
FROM DUAL;

--회원테이블
--이쁜이회원의 회원id 2-4문자열 숫자형 치환, 10을 더하여 새로운 회원id로 조합
--회원id, 조합회원id
SELECT MEM_ID, MEM_NAME
FROM MEMBER;

SELECT MEM_ID 회원ID
    , SUBSTR(MEM_ID,1,1) || TRIM(TO_CHAR(SUBSTR(MEM_ID, 2, 3)+10, '099')) 조합회원ID
FROM MEMBER;

SELECT SUBSTR(MEM_ID,1,1) || LPAD(SUBSTR(MEM_ID, 2)+10, 3, '0') 조합회원
FROM MEMBER;

--TO_DATE(char, fmt) : 날짜형식의 문자열을 DATE형으로 반환
--특별하지 않은 이상 포멧 생략 가능 TO_DATE(char)

SELECT TO_DATE('2021-01-28', 'YYYY-MM-DD')+65
FROM DUAL;

SELECT TO_DATE('2021-01-28')+65
FROM DUAL;

SELECT TO_DATE(SYSDATE,'YYYY-MM-DD HH:MI:SS')
FROM DUAL;

SELECT TO_DATE('20080301')
FROM DUAL;

--회원테이블 주민등록번호(MEM_REGNO1)을 날짜로 치환, 검색
--Alias 회원명, 주민등록번호, 치환날짜
SELECT MEM_NAME 회원명
    ,  MEM_REGNO1 주민등록번호
    ,  TO_DATE(MEM_REGNO1, 'YY-MM-DD') 치환날짜
FROM MEMBER;

--장바구니 테이블
--장바구니 번호를 날짜로 치환, 출력
--0000년 0월 00일
--Alias 장바구니번호, 상품코드, 판매일, 판매수
SELECT CART_NO 장바구니번호
    ,  CART_PROD 상품코드
    ,  TO_CHAR(TO_DATE(SUBSTR(CART_NO, 1, 8), 'YYYY-MM-DD'), 'YYYY"년" MM"월" DD"일"') 판매일
    ,  CART_QTY 판매수
FROM CART;

--전체 진도 2/3 완료


