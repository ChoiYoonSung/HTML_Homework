--�������� (Query ���� SELECT��)
--������ ��������
--������� �Ѱ��� ���� ��������
--= < <= > >=

--������ ��������
--������� �������� ���� ��������
--IN EXISTS

--UPDATE�� �ϱ� ���� SELECT������ ������ Ȯ���� �� UPDATE ����
--'��'�� '��'�� ���� ���� ȸ���� �޴��� �÷��� '011-11-1111'�� ����
UPDATE MEMBER
SET MEM_HP = '011-111-1111'
WHERE MEM_NAME LIKE '��%' OR MEM_NAME LIKE '��%';

UPDATE MEMBER
SET MEM_HP = '011-111-1111'
WHERE SUBSTR(MEM_NAME,1,1) IN ('��','��');

--�����Ͱ� 100,000�� �̻��� ��
SELECT MEM_ID
    ,  MEM_NAME
    ,  MEM_HP
FROM MEMBER
WHERE MEM_NAME LIKE '��%' OR MEM_NAME LIKE '��%';

--�����Ͱ� 100,000�� ������ ��
SELECT MEM_ID
    ,  MEM_NAME
    ,  MEM_HP
FROM MEMBER
WHERE SUBSTR(MEM_NAME,1,1) IN ('��','��');

--Ʈ����� : �����ͺ��̽����� ����(Insert,Update,Delete)�ϱ� ���� ���� ����� �����ϱ� ����
--�Ϸ��� �����������μ� �۾��� �����̴�.
--Ʈ������� �ٲ�� �κ��� Ŀ���� �Ǵ� �κ��� �����̴�. (�ڵ� Ŀ�� : Create, Alter, Drop)

--'a001'�� ȸ���� �����͸� ����
--��� : ����, ���� : ����
SELECT MEM_LIKE
    ,  MEM_JOB
FROM MEMBER
WHERE MEM_ID = 'a001';

UPDATE MEMBER
SET MEM_LIKE = '����'
,   MEM_JOB = '����'
WHERE MEM_ID = 'a001';

--'��'�� '��'�� ���� ���� ȸ��
--ȸ��ID�� 'a001' 'j001'�� ȸ�� ���� -'099-999-9999'�� ����
--�������� NOT AND OR ������ ����
SELECT MEM_ID
    ,  MEM_NAME
FROM MEMBER
WHERE (MEM_NAME LIKE '��%' OR MEM_NAME LIKE '��%')
AND (MEM_ID NOT IN ('a001', 'j001'));

UPDATE MEMBER
SET MEM_HP = '099-999-9999'
WHERE (MEM_NAME LIKE '��%' OR MEM_NAME LIKE '��%')
AND (MEM_ID NOT IN ('a001', 'j001'));

--ȸ�����̺�
--��� ȸ���� ���ϸ��� �÷��� 10% �λ�ǰ� ����
SELECT MEM_MILEAGE
FROM MEMBER;

UPDATE MEMBER
SET MEM_MILEAGE = MEM_MILEAGE*1.1;

--MEMBER���̺�
--���ϸ��� 3000�� �̻�, �޴�����ȣ 011�� ���۵Ǵ� ȸ�� ���ϸ��� 10% �λ�
SELECT NVL(MEM_MILEAGE,0)*1.1
FROM MEMBER
WHERE MEM_MILEAGE >= 3000
AND SUBSTR(MEM_HP,1,3) = '011';

UPDATE MEMBER
SET MEM_MILEAGE = MEM_MILEAGE * 1.1
WHERE MEM_MILEAGE >= 3000
AND SUBSTR(MEM_HP,1,3) = '011';

--���̺� ����
--SCHEMA : �÷�, �ڷ���, ũ��, NOT NULL �������... + ������ ����
CREATE TABLE REMAIN2
AS
SELECT * FROM REMAIN;

INSERT INTO REMAIN(
    REMAIN_YEAR
,   REMAIN_PROD
,   REMAIN_J_00
,   REMAIN_I
,   REMAIN_O
,   REMAIN_J_99
,   REMAIN_DATE
)
SELECT '2005'
    ,  REMAIN_PROD
    ,  REMAIN_J_00
    ,  REMAIN_I
    ,  REMAIN_O
    ,  REMAIN_J_99
    ,  REMAIN_DATE
FROM REMAIN
WHERE REMAIN_YEAR = '2003';

CREATE TABLE LPROD_DELETE
AS
SELECT * FROM LPROD;

CREATE TABLE LPROD_TRUNCATE
AS
SELECT * FROM LPROD;

CREATE TABLE LPROD_DROP
AS
SELECT * FROM LPROD;

--DELETE : ������ ����, �ѹ� ����
DELETE FROM
LPROD_DELETE;

SELECT * FROM LPROD_DELETE;

ROLLBACK;

--TRUNCATE : ������ ����, �ѹ� �Ұ���
TRUNCATE TABLE LPROD_TRUNCATE;

SELECT * FROM LPROD_TRUNCATE;

ROLLBACK;

--DROP : ���̺�, ������ ��� ����
DROP TABLE LPROD_DROP;

SELECT * FROM LPROD_DROP;

FLASHBACK TABLE LPROD_DROP TO BEFORE DROP;

--���������̺� 2003�⵵ �ڷ�
--������ 6�� �Ǵ� 11���� �ڷḦ ����
SELECT REMAIN_YEAR
    ,  REMAIN_O
FROM REMAIN
WHERE REMAIN_YEAR = '2003'
AND (REMAIN_O = 6 OR REMAIN_O = 11);

DELETE REMAIN
WHERE REMAIN_YEAR = '2003'
AND (REMAIN_O = 6 OR REMAIN_O = 11);

--���������̺� 2003�⵵ �ڷ� �� �԰����+�������� 20�� �̻��� �ڷ� ����
SELECT *
FROM REMAIN
WHERE (REMAIN_YEAR = '2003')
AND (NVL(REMAIN_O,0) + NVL(REMAIN_I,0) >= 20);

DELETE FROM REMAIN
WHERE (REMAIN_YEAR = '2003')
AND (NVL(REMAIN_O,0) + NVL(REMAIN_I,0) >= 20);

--VIEW
--���̺�� ������ ��ü
--���̺� �� �Ϻ� �÷����� ��Ÿ���� �� �� ����

CREATE OR REPLACE VIEW HUMAN
AS
SELECT MEM_ID ID
    ,  MEM_PASS PASS
    ,  MEM_NAME NAME
FROM MEMBER;

UPDATE HUMAN
SET NAME = '�̿�����'
WHERE ID = 'a001';

SELECT * FROM HUMAN;

--LPROD ���̺��� LPROD_GU, LPROD_NM
--VW_LPROD �� ����

CREATE OR REPLACE VIEW VW_LPROD
AS
SELECT LPROD_GU 
    ,  LPROD_NM 
FROM LPROD;

UPDATE VW_LPROD
SET LPROD_GU = 'P409'
WHERE LPROD_GU = 'P401';

SELECT * FROM VW_LPROD;

--ȸ������ �� ���̵�, �̸�, ���ϸ����� �˻��ϴ� vw)member �����̺�
--�÷��� memid, name, mileage
CREATE OR REPLACE VIEW VW_MEMBER1
AS
SELECT MEM_ID AS MEMID
    ,  MEM_NAME AS NAME
    ,  MEM_MILEAGE AS MILEAGE
FROM MEMBER;

SELECT * FROM VW_MEMBER1;

--��ǰ���̺��� ��ǰ���� '��'���� �����ϴ� �ڷ��� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó�ڵ�, �ŷ�ó�� ��ȸ
--vw_prod1 �����̺� ����
--prodid, prodname, prodbuyer
CREATE OR REPLACE VIEW VW_PROD1
AS
SELECT PROD_ID prodid
    ,  PROD_NAME prodname
    ,  PROD_BUYER prodbuyer
FROM PROD;


SELECT A.PRODID
    ,  A.PRODNAME
    ,  A.PRODBUYER
    ,  B.BUYER_NAME
FROM VW_PROD1 A INNER JOIN BUYER B ON( PRODBUYER = BUYER_ID)
WHERE PRODNAME LIKE '��%';

--��ǰ�԰����̺� 2005�⵵ 1�� �ŷ�ó�� ���Աݾ� �˻� (���Աݾ� = ���Լ��� * ���Դܰ�)
--vw_inamt
--�ŷ�ó�ڵ� �ŷ�ó�� ���Աݾ�

CREATE OR REPLACE VIEW VW_INAMT
AS
SELECT PROD_BUYER buyerid
    ,  BUYER_NAME buyername
    ,  SUM(BUY_QTY * BUY_COST) inamt
FROM BUYER LEFT OUTER JOIN PROD ON BUYER_ID = PROD_BUYER
           LEFT OUTER JOIN BUYPROD ON PROD_ID = BUY_PROD
WHERE BUY_DATE LIKE '05/01/%'
GROUP BY PROD_BUYER, BUYER_NAME, BUY_DATE
ORDER BY BUY_DATE;

