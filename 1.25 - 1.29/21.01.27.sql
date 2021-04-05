--�����ڵ带 ����ϵ� �ּ����� ������ �� �� �ֵ���

--
SELECT TO_DATE('1996-10-22') + 12000
FROM DUAL;

--���� �� ���� ��Ұ� �� ���� �Ծ����� �ĺ�� �󸶸� �����ߴ°�?
SELECT TO_DATE('1996-10-22') ����
,      TO_DATE('2021-01-27') - TO_DATE('1996-10-22') �곯¥
,      (TO_DATE('2021-01-27') - TO_DATE('1996-10-22'))*3 ����Ƚ��
,      (TO_DATE('2021-01-27')- TO_DATE('1996-10-22'))*3*10000 ���Ϻ��
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') ���糯¥
FROM DUAL;

SELECT ROUND(SYSDATE - TO_DATE('2021-01-27'),5) ��_��
FROM DUAL;

--ADD_MONTHS(date, n) : date�� ���� ���� ��¥
SELECT ADD_MONTHS(SYSDATE,5)
FROM DUAL;

--NEXT_DAY(date, char) : �ش� ��¥ ���� ���� ���� ������ ��¥
--LAST_DAY(date) : ���� ������ ��¥
SELECT NEXT_DAY(SYSDATE, 'ȭ')
FROM DUAL;

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--�̹����� ��ĥ�� ���Ҵ��� �˻�
--Alias ���ó�¥, �̴޸�������¥, �̴޳�����¥
SELECT SYSDATE ���ó�¥
,      LAST_DAY(SYSDATE) �̴޸�������¥
,      LAST_DAY(SYSDATE)-SYSDATE �̴޳�����¥
FROM DUAL;

--���� ���Ǵ� ��¥ ����
--�⵵ : YYYY / �� : MM / �� : DD / �ð� : HH, HH12, HH24 / �� : MI / �� : SS

--EXTRACT(fmt FROM date)
--��¥���� �ʿ��� �κ� ����
SELECT EXTRACT(YEAR FROM SYSDATE)��
    ,  EXTRACT(MONTH FROM SYSDATE) ��
    ,  EXTRACT(HOUR FROM SYSTIMESTAMP)+9 �� --UTC + 9(�ѱ�����)
    ,  EXTRACT(MINUTE FROM SYSTIMESTAMP) ��
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

--���� 3�� ȸ��
--Alias ȸ��ID ȸ����, ����
SELECT MEM_ID ȸ��ID, MEM_NAME ȸ����, MEM_BIR ����
FROM MEMBER
WHERE EXTRACT(MONTH FROM MEM_BIR) = 3;
--WHERE MEM_BIR LIKE '__/03/__';
--WHERE MEM_BIR LIKE '%/03/%';
--WHERE SUBSTR(MEM_BIR,4,2) = '03';

--EXTRACT ��¥�� ã�� �� ���������� ����

--SCHEMA ��Ű�� -> ����
--���̺� ��Ű�� : �÷�, �ڷ���, ũ��, �������, Ű...

--�԰��ǰ(BUYPROD) �� 3���� �԰�� ����
--Alias ��ǰ�ڵ�(prod), �԰�����(date), ���Լ���(qty), ���Դܰ�(cost)
SELECT BUY_PROD ��ǰ�ڵ�,
       BUY_DATE �԰�����,
       BUY_QTY ���Լ���,
       BUY_COST ���Դܰ�
FROM BUYPROD
WHERE EXTRACT(MONTH FROM BUY_DATE) = 3
ORDER BY BUY_DATE;
--WHERE BUY_DATE LIKE '%/03/%';
--WHERE BUY_DATE LIKE '__/03/__';
--WHERE SUBSTR(BUY_DATE, 4, 2) = '03';

/*
date ������ �����͸� ���� "YY/MM/DD" �������� �Ǿ��ִµ�
EXTRACT�� ��������ν� ��,��,�� �� ������ �� �ִ�
����� �������̱� ������ ���ڷ� �񱳿��� �ؾ� ��
*/

--����ȯ
--CAST(EXPR AS type) ��������� �� ��ȯ
--TO_CHAR ����,����,��¥�� ������ ������ ���ڿ� ��ȯ
--TO_NUMBER ���� ������ ���ڿ��� ���ڷ� ��ȯ
--TO_DATE ��¥ ����0�� ���ڿ��� ���ڷ� ��ȯ

SELECT '[' || 'Hello' || ']' "����"
    ,  '[' || CAST('Hello' AS CHAR(30)) || ']' "CHAR����ȯ"
    ,  '[' || CAST('Hello' AS VARCHAR2(30)) || ']' "VARCHAR2����ȯ"
FROM DUAL;

SELECT CAST('2021-01-27' AS DATE)
FROM DUAL;

SELECT CAST(SYSDATE AS DATE)
FROM DUAL;

--TO_CHAR (�߿�)�ڡڡ�
--(char) char,clob Ÿ���� varchar2�� ��ȯ
--(date, fmt) ��¥�� Ư�� ������ ���ڿ��� ��ȯ
--(number, fmt) ���ڸ� Ư�� ������ ���ڿ��� ��ȯ

SELECT TO_CHAR(SYSDATE, 'AD YYYY"��", CC"����"')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('2015-05-08', 'YYYY-MM-DD'), 'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;

--��ǰ���̺��� ��ǰ�԰����� 'YYYY-MM-DD HH24:MI:SS' �������� ������ �˻�
--Alias ��ǰ�� ��ǰ�ǸŰ� �԰���(INSDATE)
SELECT PROD_NAME prodName --��ǰ��
    ,  PROD_SALE prodSale --��ǰ�ǸŰ�
    ,  TO_CHAR(PROD_INSDATE, 'YYYY-MM-DD HH24:MI:SS') prodInsdate --�԰���
FROM PROD
ORDER BY 3, 1;


