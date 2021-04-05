--LPAD RPAD
--LPAD : Left Padding / RPAD : Right Padding
--���� Ȥ�� �����ʿ� ������ ä�� �� ���� Ȥ�� ���ڸ� ä��
SELECT LPAD ('Java', 10) "LPAD"
FROM DUAL;

--SELECT LPAD/RPAD ('����', ����, '���鿡 ä�� ����')"LPAD/RPAD"
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

--��ǰ���̺� �Һ��ڰ�(PROD_PRICE)�� �Һ��ڰ����� ġȯ�Ͽ� ������ ���� ���
--Alias : PROD_PRICE, PROD_RESULT
SELECT PROD_PRICE PROD_PRICE,
       LPAD (PROD_PRICE, 10, '*') PROD_RESULT
FROM PROD
ORDER BY PROD_PRICE;

--LTRIM/RTRIM
--���� ����
SELECT '<' || LTRIM ('     AAA     ') || '>' "LTRIM1" FROM DUAL;
SELECT '<' || RTRIM ('     AAA     ') || '>' "RTRIM1" FROM DUAL;

--LEADING BOTH TRAILING
SELECT '<' || TRIM (LEADING 'a' FROM TRIM ('   aaaAAaaAbbAbaa  ')) || '>' LEADING_TRIM FROM DUAL;
SELECT '<' || TRIM (TRAILING 'a' FROM TRIM ('   aaaAAaaAbbAbaa  ')) || '>' TRAILING_TRIM FROM DUAL;
SELECT '<' || TRIM (BOTH 'a' FROM TRIM ('   aaaAAaaAbbAbaa  ')) || '>' BOTH_TRIM FROM DUAL;

--DUAL / SYS.DUAL ����?
--DUAL : ������ ���̺�, SYS: SYS�������� ����

--SUBSTR �߿��
--SUBSTR('c', m, n)
--���ڿ��� �Ϻκ��� ����, c���ڿ��� m ���� ��ġ���� n ��ŭ�� ���� ����
--m�� 0 �Ǵ� 1�̸� ù ����
--m�� �����̸� ���ʺ��� ó��
SELECT SUBSTR('SQL PROJECT', 1, 3) RESULT1 --�տ��� 1�ں��� ����
    ,  SUBSTR('SQL PROJECT', 5) RESULT2 --�տ��� 5�ں��� ����
    ,  SUBSTR('SQL PROJECT', -7, 4) RESULT3 --�ڿ��� 7�ں��� ����
FROM DUAL;
--��� ���
--SQL / PROJECT // PROJ

--���� ��ȸ
SELECT MEM_ID
    ,  SUBSTR(MEM_NAME, 1, 1) MEM_RESULT
FROM MEMBER;

--��ǰ���̺� ��ǰ��(PROD_NAME)�� 4° �ڸ����� 2���ڰ� 'Į��'�� ��ǰ�� ��ǰ�ڵ�(PROD_ID), ��ǰ��(PROD_NAME) �˻�
--Alias PROD_ID, PROD_NAME
SELECT PROD_ID ��ǰ�ڵ�, PROD_NAME ��ǰ��
FROM PROD
WHERE SUBSTR(PROD_NAME, 4, 2) = 'Į��';
--    SUBSTR(�÷� �� ,��������,���ڼ�) = 'ã������ ����';

--SUBSTR���� LIKE�� �˻��ӵ��� ����
SELECT PROD_ID ��ǰ�ڵ�, PROD_NAME ��ǰ��
FROM PROD
WHERE PROD_NAME LIKE '___Į��%';

--��ٱ��� ���̺�(CART)���� ��ٱ��� ��ȣ(CART_NO)�� 04���� �ش��ϴ� ������ ���
--Alias : CART_NO, CART_PROD
SELECT CART_NO ��ٱ��Ϲ�ȣ, CART_PROD ��ǰ�ڵ�
    ,  SUBSTR(CART_NO, 5, 2) ��
FROM CART
WHERE SUBSTR(CART_NO, 5, 2) = 04;

SELECT CART_NO ��ٱ��Ϲ�ȣ, CART_PROD ��ǰ�ڵ�
FROM CART
WHERE  CART_NO LIKE '____04%';

SELECT *
FROM CART;

--��ǰ���̺� ��ǰ�ڵ�(PROD_ID) ���� 4�ڸ�, ������ 6�ڸ� �˻�
SELECT PROD_ID ��ǰ�ڵ�
    ,  SUBSTR(PROD_ID, 1, 4) ��з�
    ,  SUBSTR(PROD_ID, -6) ����
FROM PROD;

--ȸ�� id ���
--alias ȸ��id, ��1��, ������

SELECT MEM_ID ȸ��ID
    ,  SUBSTR(MEM_ID, 1, 1) ��1��
    ,  SUBSTR(MEM_ID, 2) ������
FROM MEMBER;

--REPLACE

--ȸ�����̺� ȸ������ �� '��' -> '��'�� ġȯ �˻�
SELECT MEM_NAME ȸ������
    ,  REPLACE (MEM_NAME, '��', '��') ġȯ
FROM MEMBER;

SELECT MEM_NAME ȸ������
    , REPLACE (MEM_NAME, '��', '��') ȸ����ġȯ
FROM MEMBER
WHERE MEM_NAME LIKE '��%';

--INSTR(c1, c2 , m, n)
--c1���ڿ����� c2���ڰ� ó�� ��Ÿ���� ��ġ ����
--m: ������ġ, n��°
SELECT INSTR('hello heidi', 'di') RESULT1
    ,  INSTR('hello heidi', 'he', 1, 2) RESULT2 --'hello heidi'��� ���ڿ��� 'he'��� ���ڿ��� 1������ 2��° ��Ÿ���� ��ġ
    ,  INSTR('hello Hello HELLO', 'HE') RESULT3
FROM DUAL;

--i have a hat
--ù ��° ha ��ġ
--�� ��° ha ��ġ
SELECT 'i have a hat' i_have_a_hat
    ,  INSTR('i have a hat', 'ha', 1, 1)
    ,  INSTR('i have a hat', 'ha', 1, 2)
    ,  INSTR('i have a hat', 'ha', -1)
FROM SYS.DUAL;

--I have a hat that i had have been found that hat before 2 years ago
--5��° ha��ġ ���
SELECT 'I have a hat that i had have been found that hat before 2 years ago'
    ,  INSTR('I have a hat that i had have been found that hat before 2 years ago', 'ha', 1, 5) fifth_ha
FROM SYS.DUAL;

--mepoh@test.com
--���̵�|������ ���
SELECT 'mepoh@test.com'
    ,  SUBSTR('mepoh@test.com', 1, INSTR('mepoh@test.com', '@')-1) ���̵�
    ,  SUBSTR('mepoh@test.com', INSTR('mepoh@test.com', '@')+1) ������
FROM DUAL;

--LENGTH : �������� ���� ��
--LENGTHB : �������� byte ��(����,���� : 1byte, �ѱ� : 3byte)
--�ŷ�ó �ڵ�, ���� ����/byte ��
SELECT BUYER_ID �ŷ�ó�ڵ�
    ,  LENGTH(BUYER_ID) �ŷ�ó�ڵ����
    ,  BUYER_NAME �ŷ�ó��
    ,  LENGTH(BUYER_NAME) �ŷ�ó�����
    ,  LENGTHB(BUYER_NAME) �ŷ�ó��byte
FROM BUYER;

--ABS : ���밪 / SIGN : ��,��,0 ����
--POWER : �¼� �� / SQRT : ������
SELECT ABS(-365) FROM DUAL;
SELECT SIGN(12), SIGN(0), SIGN(-55) FROM DUAL;
SELECT POWER(3,2), POWER(2, 10) FROM DUAL;
SELECT SQRT(2), SQRT(9) FROM DUAL;

--GREATEST / LEAST : ���� ū �� / ���� ���� ��
SELECT GREATEST(10, 20, 30) "ū��"
    ,  LEAST(10, 20, 30) "����_��"
    ,  GREATEST('������', 256, '�۾���') "�ѱ�+����_ū��"
    ,  LEAST('������', 256, 'dog') "�ѱ�+����_������"
    ,  GREATEST('puppy', '������', 909)
    ,  LEAST('puppy', '������', 909)
FROM DUAL;

--ROUND / TRUNC : �ݿø� / ����
--ROUND(���/0 : �ڸ��� �ؿ��� �ݿø�, ���� : �ڸ������� �ݿø�)
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

--ȸ�����̺��� ���ϸ����� 12�� ���� ���� �˻�
--�Ҽ�2°�ڸ� �츮�� �ݿø�, ����
--1. ROUND(191.666666, 2) ���?
SELECT MEM_MILEAGE ���ϸ���
    ,  ROUND(MEM_MILEAGE/12, 2) �Ҽ���2�ڸ��ݿø�
    ,  TRUNC(MEM_MILEAGE/12, 2) �Ҽ���2�ڸ�����
FROM MEMBER;

--��ǰ���̺� ��ǰ��, ������(���԰�/�ǸŰ�)�� ������ �˻�
--�ݿø����� ��, �Ҽ� ù°�ڸ� �츮�� �ݿø�
--Alias ��ǰ��, ������1, ������2
SELECT PROD_NAME ��ǰ��
    ,  (PROD_COST/PROD_SALE)*100 ������1
    ,  ROUND((PROD_COST/PROD_SALE)*100, 1) ������2
FROM PROD;

--��ǰ���̺��� ����ǸŰ��� �Ҽ��� 2°�ڸ����� �ݿø�
SELECT ROUND(AVG(PROD_SALE),2) ����ǸŰ�
    ,  SUM(PROD_SALE) �ǸŰ��հ�
FROM PROD;

--MOD : ������ (Java���� %�� ���� ���)
SELECT MOD(10,3) FROM DUAL;

--FLOOR : n�� ���ų� ���� �� �� ���� ū ����
--CEIL : n�� ���ų� ū �� �� ���� ���� ����
SELECT FLOOR(1445.78), CEIL(1445.78) FROM DUAL;
SELECT FLOOR(-1445.78), CEIL(-1445.78) FROM DUAL;

--3.141592�� ������ �ø�
SELECT -3.141592 ����
    ,  FLOOR(-3.141592) ����
    ,  CEIL(-3.141592) �ø�
FROM DUAL;

--REMAINDER

--SYSDATE
--�ý��ۿ��� �����ϴ� ���� ��¥�� �ð� ��
SELECT SYSDATE FROM DUAL;

--TO_CHAR() : ���ڷ� ����ȯ�ϴ� �Լ�, �̶� ������ �������� �� ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') ����ð�
    ,  SYSDATE - 1 "���� �� �ð�"
    ,  SYSDATE + 1 "���� �� �ð�"
    ,TO_CHAR(SYSDATE + 1/24, 'YYYY-MM-DD HH:MI:SS') �ѽð���
FROM DUAL;

--ȸ�����̺��� ����, 12000��° �Ǵ� �� �˻�
SELECT MEM_NAME "�̸�"
    ,  MEM_BIR "����"
    ,  MEM_BIR + 12000 "12000��°"
    , TO_DATE('1996/10/22') + 12000
FROM MEMBER;

