--CASE WHEN ~ THEN ~ ELSE ~ END (�߿�)
--�������� ���ǹ�
--1. Simple-Case-Expression
SELECT
CASE '��' WHEN 'öȣ' THEN 'NO'
          WHEN '��' THEN 'YES'
          WHEN '��' THEN 'NO'
          ELSE '?'
          END RESULT
FROM DUAL;
--2. Searched-Case-Expression
SELECT
CASE  WHEN 'öȣ' = '��' THEN 'NO'
      WHEN '��' = '��' THEN 'YES'
      WHEN '��' = '��' THEN 'NO'
      ELSE '?'
      END RESULT
FROM DUAL;
--Simple ���� Searched�� ���� ���δ�.
--Searched : Ȯ�强�� ����

SELECT PROD_NAME
    ,  PROD_LGU
    , CASE
        WHEN PROD_LGU = 'P101' THEN '��ǻ��'
        WHEN PROD_LGU = 'P102' THEN '������ǰ'
        WHEN PROD_LGU = 'P201' THEN '����ĳ���'
        WHEN PROD_LGU = 'P202' THEN '����ĳ���'
        WHEN PROD_LGU = 'P301' THEN '������ȭ'
        WHEN PROD_LGU = 'P302' THEN 'ȭ��ǰ'
        WHEN PROD_LGU = 'P401' THEN '����/CD'
        WHEN PROD_LGU = 'P402' THEN '����'
        WHEN PROD_LGU = 'P403' THEN '������'
    ELSE ' '
    END RESULT
FROM PROD;

--ȸ�����̺� �ֹε�Ϲ�ȣ ù��° �ڸ� ���� ����
--Alias ȸ��ID ȸ���� �ֹι�ȣ2 ����
--Case When�� ���
SELECT MEM_ID ȸ��ID
    ,  MEM_NAME ȸ����
    ,  MEM_REGNO2 �ֹι�ȣ2
    ,  CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) = 1 OR SUBSTR(MEM_REGNO2, 1, 1) = 3 THEN '��'
            WHEN SUBSTR(MEM_REGNO2, 1, 1) = 2 OR SUBSTR(MEM_REGNO2, 1, 1) = 4 THEN '��'
            WHEN MEM_REGNO2 LIKE '1%' THEN '��'
            WHEN MEM_REGNO2 LIKE '2%' THEN '��'
            ELSE '��ºҰ�' 
        END ���� 
FROM MEMBER;

--10���� �ʰ� ��ǰ �ǸŰ� ���ݴ�
SELECT PROD_NAME ��ǰ��
    ,  PROD_SALE �ǸŰ�
    ,  CASE WHEN (100000 - PROD_PRICE) >=0 THEN '10���� �̸�'
            WHEN (200000 - PROD_PRICE) >=0 THEN '10������'
            WHEN (300000 - PROD_PRICE) >=0 THEN '20������'
            WHEN (400000 - PROD_PRICE) >=0 THEN '30������'
            WHEN (500000 - PROD_PRICE) >=0 THEN '40������'
            WHEN (600000 - PROD_PRICE) >=0 THEN '50������'
            WHEN (700000 - PROD_PRICE) >=0 THEN '60������'
            WHEN (800000 - PROD_PRICE) >=0 THEN '70������'
            WHEN (900000 - PROD_PRICE) >=0 THEN '80������'
            WHEN (1000000 - PROD_PRICE) >=0 THEN '90������'
            ELSE '100���� �̻�'
        END ���ݴ�
FROM PROD;

--Table Join
--RBB�� �ٽ�
--������ DB�� ���� ū ������ ���� TABLE�� JOIN�� ���ϴ� ����� �����ϴµ� �ִ�
--Cartesian Product : ��� ������ ����� ����
--Oracle ����
SELECT *
FROM PROD, LPROD;
--Ansi ǥ�� ����
SELECT *
FROM PROD CROSS JOIN LPROD;

SELECT *
FROM LPROD
WHERE LPROD_ID > 9;

SELECT PROD.PROD_ID ��ǰ�ڵ�
    ,  PROD.PROD_NAME ��ǰ��
    ,  LPROD.LPROD_NM �з���
    ,  LPROD.LPROD_GU �⺻Ű
    ,  PROD.PROD_LGU �ܷ�Ű
FROM PROD, LPROD;


--Equi Join : ������ ��ġ�ϴ� �÷��� ��Ī
SELECT PROD.PROD_ID ��ǰ�ڵ�
    ,  PROD.PROD_NAME ��ǰ��
    ,  LPROD.LPROD_NM �з���
    ,  LPROD.LPROD_GU �⺻Ű
    ,  PROD.PROD_LGU �ܷ�Ű
FROM PROD, LPROD
WHERE LPROD.LPROD_GU = PROD.PROD_LGU;

--��ǰID, ��ǰ��, �ŷ�ó��
SELECT *
FROM BUYER, PROD;

SELECT PROD.PROD_ID
    ,  PROD.PROD_NAME
    ,  BUYER.BUYER_NAME
    ,  BUYER.BUYER_ID
    ,  PROD.PROD_BUYER
FROM BUYER, PROD
WHERE BUYER.BUYER_ID = PROD.PROD_BUYER;

SELECT B.PROD_ID
    ,  B.PROD_NAME
    ,  A.BUYER_NAME
    ,  A.BUYER_ID
FROM PROD B , BUYER A
WHERE BUYER_ID = PROD_BUYER;

--��ǰID, ��ǰ��, �԰���, �԰����, �԰���
--��ǰ���̺�, �԰����̺�
SELECT A.PROD_ID
    ,  A.PROD_NAME
    ,  B.BUY_DATE
    ,  B.BUY_QTY
    ,  B.BUY_COST
FROM PROD A, BUYPROD B
WHERE B.BUY_PROD = A.PROD_ID;

--EQUI JOIN (ANSI ǥ��)
SELECT A.PROD_ID
    ,  A.PROD_NAME
    ,  B.BUY_DATE
    ,  B.BUY_QTY
    ,  B.BUY_COST
FROM PROD A INNER JOIN BUYPROD B
ON (B.BUY_PROD = A.PROD_ID);

--��ٱ��Ϲ�ȣ, ��ǰ�ڵ�, ���Ű���, ȸ��ID, ȸ����
--CART, MEMBER
--EQUI JOIN (Oracle)
SELECT C.CART_NO AS ��ٱ��Ϲ�ȣ
    ,  C.CART_PROD AS ��ǰ�ڵ�
    ,  C.CART_QTY AS ���Ű���
    ,  C.CART_MEMBER
    ,  M.MEM_ID AS ȸ��ID
    ,  M.MEM_NAME AS ȸ����
FROM CART C, MEMBER M
WHERE C.CART_MEMBER = M.MEM_ID;
--FROM CART C INNER JOIN MEMBER M
--ON (C.CART_MEMBER = M.MEM_ID);

SELECT * FROM MEMBER;
SELECT * FROM CART;

--��ٱ��Ϲ�ȣ, ��ǰ�ڵ�, ���Ű���, ȸ��ID, ȸ����, ��ǰ��
--CART, MEMBER, PROD
SELECT CART_NO ��ٱ��Ϲ�ȣ
    ,  CART_PROD ��ǰ�ڵ�
    ,  CART_QTY ���Ű���
    ,  MEM_ID ȸ��ID
    ,  MEM_NAME ȸ����
    ,  PROD_NAME ��ǰ��
FROM CART, MEMBER, PROD
WHERE CART_MEMBER = MEM_ID
AND CART_PROD = PROD_ID;

--ANSI ǥ��
SELECT C.CART_NO ��ٱ��Ϲ�ȣ
    ,  C.CART_PROD ��ǰ�ڵ�
    ,  C.CART_QTY ���Ű���
    ,  M.MEM_ID ȸ��ID
    ,  M.MEM_NAME ȸ����
    ,  P.PROD_NAME ��ǰ��
FROM CART C INNER JOIN MEMBER M ON CART_MEMBER = MEM_ID
            INNER JOIN PROD P ON  CART_PROD = PROD_ID ;

--Non-Equi Join : ���������� JOIN ������ '='�� �ƴ� �ٸ� �����ȣ�� �־����� ���
--Outer Join : ������ ��ġ���� �ʴ��� ��� ����� �˻��ϰ��� �� �� ���, (+)�� ǥ��
--Self Join : �� ���̺� ������ Join�ϴ� ���




