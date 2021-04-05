--NULL
--IS NULL / IS NOT NULL : NULL������ �ƴ��� ��
--NVL(c, r) : c�� NULL�� �ƴϸ� c, NULL�̸� r
--NVL2(c, r1, r2) : c�� NULL�� �ƴϸ� r1, NULL�̸� r2
--NULLIF(c, d) : c�� d�� ���ؼ� ������ NULL, �ٸ��� c
--COALESCE(p, p, ...) : �Ķ������ NULL�� �ƴ� ù ��° �Ķ���� ��ȯ

--�ŷ�ó���̺��� �ŷ�ó��, ����� ��ȸ
SELECT BUYER_NAME �ŷ�ó��
    ,  BUYER_CHARGER �����
FROM BUYER;

--����� ���� �达�� �ŷ�ó
SELECT BUYER_NAME �ŷ�ó��
    ,  BUYER_CHARGER �����
FROM BUYER
WHERE 1=1 
--AND BUYER_CHARGER LIKE '��%'
AND SUBSTR(BUYER_CHARGER, 1, 1) = '��';

UPDATE BUYER
SET BUYER_CHARGER = NULL
WHERE BUYER_CHARGER LIKE '��%';

COMMIT;

SELECT * FROM BUYER;

--�ŷ�ó ����� ������ '��' �̸� White Space�� ����
SELECT BUYER_NAME
    ,  BUYER_CHARGER
FROM BUYER
WHERE BUYER_CHARGER LIKE '��%';

UPDATE BUYER
SET BUYER_CHARGER = ''
WHERE BUYER_CHARGER LIKE '��%';
--����Ŭ���� ''�� NULL�� �ǹ̿� ����

COMMIT;

SELECT BUYER_CHARGER FROM BUYER;

SELECT BUYER_NAME �ŷ�ó��
    ,  BUYER_CHARGER �����
FROM BUYER
WHERE 1=1
AND BUYER_CHARGER IS NULL;
--AND BUYER_CHARGER IS NOT NULL;
--AND NOT(BUYER_CHARGER IS NULL);

--NVL
SELECT BUYER_NAME �ŷ�ó��
    ,  BUYER_CHARGER 
    ,  NVL(BUYER_CHARGER, '����') �����
FROM BUYER
WHERE BUYER_CHARGER IS NULL;

--NVL2
SELECT BUYER_NAME �ŷ�ó��
    ,  BUYER_CHARGER �����
    ,  NVL2(BUYER_CHARGER,'O', 'X') ���������
FROM BUYER;

--���￡ �������� ȸ���� ���ϸ��� �����͸� NULL�� ó��
SELECT MEM_NAME �̸�
    ,  MEM_ADD1 ������
    ,  MEM_MILEAGE ���ϸ���
FROM MEMBER
WHERE MEM_ADD1 LIKE '����%';

--ȸ�� ���� '��'�� ����, ���ϸ����� NULL�� ����
UPDATE MEMBER
SET MEM_MILEAGE = ''
WHERE MEM_NAME >= '��' AND MEM_NAME <= '��';

SELECT MEM_NAME, MEM_MILEAGE
FROM MEMBER
WHERE MEM_NAME >= '��' AND MEM_NAME <= '��';

COMMIT;

--��üȸ�� ���ϸ����� 100�� ���� ��ġ
--Alias ���� ���ϸ��� ���渶�ϸ���
SELECT MEM_NAME ����
    ,  MEM_MILEAGE ���ϸ���
    ,  NVL(MEM_MILEAGE, 0) + 100 ���渶�ϸ���
FROM MEMBER;

--���ϸ��� ������ '����ȸ��', NULL�̸� ������ȸ��
SELECT MEM_NAME �̸�
    ,  MEM_MILEAGE ���ϸ���
    ,  NVL2(MEM_MILEAGE, '����ȸ��', '������ȸ��') ȸ������
FROM MEMBER;

UPDATE MEMBER
SET MEM_MILEAGE = 100
WHERE MEM_MILEAGE IS NULL;

SELECT MEM_NAME, MEM_MILEAGE
FROM MEMBER;

--NULLIF : ������ NULL, �ٸ��� �� ���
SELECT NULLIF(123, 123)
    ,  NULLIF('Hello', 'Hi')
FROM DUAL;

--������ ����
/*
Sequence�� ���� ���� ����
Sequence��ü�� �ڵ������� ��ȣ�� �����ϱ� ���� ��ü
Sequence��ü�� ���̺�� ������, ���������� ��� ����
Sequence�� �̿��ϴ� �ܿ�
- Primary Key�� ������ �ĺ�Ű�� ���ų� PK�� Ư���� ������ �ʾƵ� �Ǵ� ���
*/

--������ ����
--START WITH : ���۹�ȣ
--INCREMENT BY : ����
CREATE SEQUENCE LPROD_SEQ
INCREMENT BY 1
START WITH 1;

DROP SEQUENCE LPROD_SEQ;

--������ 1����
SELECT LPROD_SEQ.NEXTVAL FROM DUAL;

--�����ȣ Ȯ��
SELECT LPROD_SEQ.CURRVAL FROM DUAL;

--�����
CREATE TABLE TESTSEQ(
  TS_ID NUMBER NOT NULL,
  TS_NAME VARCHAR2(10),
  CONSTRAINT PK_TESTSEQ PRIMARY KEY(TS_ID)
);

CREATE SEQUENCE TESTSEQ_SEQ
INCREMENT BY 1
START WITH 1;

DROP SEQUENCE TESTSEQ_SEQ;

--Sequence ���� ���� CurrentValue �Ұ�
SELECT TESTSEQ_SEQ.CURRVAL FROM DUAL;

SELECT TESTSEQ_SEQ.NEXTVAL FROM DUAL;

INSERT INTO TESTSEQ(TS_ID, TS_NAME)
VALUES(TESTSEQ_SEQ.NEXTVAL, '��1');

INSERT INTO TESTSEQ(TS_ID, TS_NAME)
VALUES(TESTSEQ_SEQ.NEXTVAL, '��2');

INSERT INTO TESTSEQ(TS_ID, TS_NAME)
VALUES(TESTSEQ_SEQ.NEXTVAL, '��3');

SELECT * FROM TESTSEQ;

--tlznjstm
--AOA ���̺� ����
--(NO NUMBER NOT NULL
--, NAME VARCHAR2(30)
--, BIR BARCHAR2(20))
--NO�÷� �⺻Ű

CREATE TABLE AOA(
    NO NUMBER NOT NULL,
    NAME VARCHAR2(30),
    BIR VARCHAR2(20),
    CONSTRAINT PK_AOA PRIMARY KEY(NO)
);

CREATE SEQUENCE AOA_SEQ
INCREMENT BY 1
START WITH 1;

DROP TABLE AOA;
DROP SEQUENCE AOA_SEQ;

--�������� ����Ͽ� �����͸� �Է�
SELECT AOA_SEQ.NEXTVAL FROM DUAL;

INSERT INTO AOA(NO, NAME, BIR)
VALUES(AOA_SEQ.NEXTVAL, '����', '1991-01-08');

INSERT INTO AOA(NO, NAME)
VALUES(AOA_SEQ.NEXTVAL, '�ʾ�');

INSERT INTO AOA(NO, NAME)
VALUES(AOA_SEQ.NEXTVAL, '����');

INSERT INTO AOA(NO, NAME)
VALUES(AOA_SEQ.NEXTVAL, '����');

INSERT INTO AOA(NO, NAME)
VALUES(AOA_SEQ.NEXTVAL, '����');

COMMIT;

SELECT * FROM AOA;

--�б�
--DECODE : IF���� ���� ���
--DECODE(1, 1, 'A', 2, 'B', 3, 'C', 'default')
--CASE WHEN : �������� ���ǹ�

SELECT DECODE(1
            , 1, 'A'
            , 2, 'B'
            , 3, 'C'
            ,'default'
            )
FROM DUAL;

--��ǰ�з� �� ���� �� ���ڰ� 
--'P1'�̸� �ǸŰ��� 10% �λ�, 'P2'�� �ǸŰ� 15% �λ�, ������ ���� �Ǹ�
SELECT PROD_NAME ��ǰ��
    ,  PROD_SALE �ǸŰ�
    ,  DECODE(SUBSTR(PROD_LGU, 1,2)
            , 'P1', PROD_SALE*1.1
            , 'P2', PROD_SALE*1.15
            ,PROD_SALE
            ) �λ��ǸŰ�
FROM PROD;

--��������翡���� 3���� ������ ȸ���� ������� ���ϸ��� 10% �λ�
--3���� �ƴ� ȸ���� ¦���� ��� 5% �λ�,
--Alias ȸ��Id, ȸ����, ���ϸ���, ���渶�ϸ���
UPDATE MEMBER
SET MEM_MILEAGE = '0'
WHERE MEM_MILEAGE IS NULL;

SELECT MEM_ID ȸ��ID
    ,  MEM_NAME ȸ����
    ,  MEM_BIR ����
    ,  MEM_MILEAGE ���ϸ���
    ,  DECODE(SUBSTR(MEM_BIR,4,2)
              , '03', MEM_MILEAGE*1.1
              ,  DECODE(MOD(SUBSTR(MEM_BIR,4,2),2)
                        , 1 , MEM_MILEAGE*1.05
                        , MEM_MILEAGE
                 )
              ) ���渶�ϸ���
FROM MEMBER;
