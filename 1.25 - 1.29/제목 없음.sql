--P.198
SELECT ROUND(345.123, -2) 결과 FROM DUAL;
SELECT ROUND(345.123, -1) 결과 FROM DUAL;
SELECT ROUND(345.523, 0) 결과 FROM DUAL;
SELECT ROUND(345.123, 1) 결과 FROM DUAL;
SELECT ROUND(345.123, 2) 결과 FROM DUAL;
SELECT ROUND(345.123, -2) 결과 FROM DUAL;
SELECT ROUND(345.123, -1) 결과 FROM DUAL;

SELECT TRUNC(345.123, 0) 결과 FROM DUAL;
SELECT TRUNC(345.123, 1) 결과 FROM DUAL;
SELECT TRUNC(345.123, 2) 결과 FROM DUAL;
SELECT TRUNC(345.123, -1) 결과1
     , TRUNC(345.123, -2) 결과2 
FROM   DUAL;

--회원 테이블의 마일리지를 12로 나눈 값을 검색
--(소수2째자리 살리기 반올림, 절삭)
-- 1. ROUND('191.666666',2) 결과는?
-- 여기에서 ",2"라는 것은 소수점 2째자리까지 살아남는다는 것임
-- 따라서 191.66이 살아남는데 그 다음 3번째 자리가 6이므로
-- 반올림 되어 191.67로 결과를 도출함
SELECT MEM_MILEAGE
     , ROUND(MEM_MILEAGE / 12, 2) 둘째자리살리기반올림
     , TRUNC(MEM_MILEAGE / 12, 2) 둘째자리살리기버림
FROM   MEMBER;
--상품테이블의 상품명, 원가율( 매입가 / 판매가 )을  비율(%)로
--(반올림 없는 것과 소수 첫째자리 살리기 반올림 비교) 검색하시오 ?
--(Alias는 상품명, 원가율1, 원가율2)
-- 비율(%)는 비율에 100을 곱한값임
--소수점 첫째자리를 살리는 반올림 ->
--ROUND((PROD_COST / PROD_SALE)*100,1) 여기서 ",1"라는 의미는
--소수점 첫째자리를 살린다는 의미이고 두번째자리에서 반올리 처리가 됨
SELECT PROD_NAME
     , (PROD_COST / PROD_SALE)*100 원가율1
     , ROUND((PROD_COST / PROD_SALE)*100,1) 원가율2
FROM   PROD;

--다음 쿼리는 오류가 발생할 것인가?
--왜여? '1992-03-17'은 문자형 데이터인 반면
-- 12000은 숫자형 데이터이므로
-- 숫자와 문자 연산의 경우 숫자가 우선순위가 높으므로
-- 문자가 숫자로 자동형변환함. 그런데 '1992-03-17' 문자열의 경우
-- "-"으로 인해 숫자로 자동형변환될 수 없다.
-- 따라서 '1992-03-17'이라는 문자열을 TO_DATE()함수를 사용하여
-- Date 형식으로 바꾸어주어야 "날짜 + 숫자"가 되어 연산이 가능해진다.
SELECT '1992-03-17' + 12000
FROM   DUAL;

--문제 : 나는 몇 일을 살았는가? TO_DATE('2015-04-10')함수 이용
--단, 밥은 하루에 3번을 먹음.
--      소수점 2째자리까지 반올림하여 처리하시오.
--ALIAS : 내생일, 산일수, 밥먹은수, 
--밥먹은비용(한끼에 3000원으로 처리)








