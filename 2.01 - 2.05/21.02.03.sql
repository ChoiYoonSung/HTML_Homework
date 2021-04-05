--�����Լ� ����
--SUM : �׷��Ͽ� �հ�
--AVG : �׷��Ͽ� ���
--MAX : �׷��Ͽ� �ִ밪
--MIN : �׷��Ͽ� �ּҰ�
--COUNT : �׷��Ͽ� ����
--�����Լ��� ����� ������ ��ȣ () �� ������ ����ؾ� �Ѵ�.

/*
����(Oracle)
īƼ�� ���δ�Ʈ : ��� ��� ���� ����
�������� : �⺻Ű �ܷ�Ű�� ������� �Ͽ� ����
�ܺ����� : ���� ���̺��� ��� ���� ���
�������� : �ϳ��� ���̺��� ���� ���̺�ó�� ó��

����(ANSI)
CROSS JOIN : ��� ��� ���� ����(īƼ�� ���δ�Ʈ)
INNER JOIN : �⺻Ű �ܷ�Ű�� ������� �Ͽ� ����(��������)
OUTER JOIN : ���� ���̺��� �ȵ� ���� ���(�ܺ�����)
NATIRAL JOIN : ������� �˾Ƽ� �����Ͽ� ���� (�÷����� ���� �÷����� �˾Ƽ� ã��. ��, �ϳ��� �÷��� ���ƾ� �Ѵ�)
SELF JOIN : �ϳ��� ���̺��� ���� ���̺�ó�� ó��(��������)
*/

--PROD CART MEMBER ���̺� ����
--Oracle
SELECT *
FROM PROD P, CART C, MEMBER M
WHERE P.PROD_ID = C.CART_PROD
AND   C.CART_MEMBER = M.MEM_ID;
--ANSI
SELECT *
FROM CART C INNER JOIN PROD P ON (C.CART_PROD = P.PROD_ID)
          INNER JOIN MEMBER M ON (C.CART_MEMBER = M.MEM_ID);

--ȸ�����̺��� ����������� count���� �Ͻÿ�
--Alias ���������
SELECT COUNT(DISTINCT MEM_LIKE) ���������
FROM MEMBER;

--ȸ�����̺� ��̺� COUNT
--Alias ���, �ڷ��, �ڷ��*
SELECT MEM_LIKE ���
    ,  COUNT(MEM_LIKE) �ڷ��
    ,  COUNT(*) "�ڷ��(*)"
FROM MEMBER
GROUP BY MEM_LIKE;

--��ٱ������̺� ȸ�� �� count ����
--Alias ȸ��ID, ���ż�(DISTINCT), ���ż�, ���ż�(*)
SELECT CART_MEMBER ȸ��ID
    ,  COUNT(DISTINCT CART_MEMBER) "���ż�(DISTINCT)"
    ,  COUNT(CART_MEMBER) ���ż�
    ,  COUNT(*) ��ü���Ǽ�
FROM CART
GROUP BY CART_MEMBER
ORDER BY 1;

--�����Լ� �̿��� �÷����� GROUP BY ���� ����ؾ� �� 

--MAX / MIN
--��ٱ������̺��� ȸ���� �ִ� ���ż��� �˻�
--Alias ȸ��ID, �ִ����, �ּҼ���
SELECT CART_MEMBER ȸ��ID
    ,  MAX  (CART_QTY) �ִ����
    ,  MIN (CART_QTY) �ּҼ���
FROM CART
GROUP BY CART_MEMBER;

--2005�� 7�� 11���̶� ����, ��ٱ��� ���̺� �߻��� �߰��ֹ���ȣ �˻�
--Alias �ְ�ġ�ֹ���ȣ �߰��ֹ���ȣ
SELECT MAX (CART_NO) �ְ�ġ�ֹ���ȣ
    ,  MAX (CART_NO)+1 �߰��ֹ���ȣ
FROM   CART
WHERE  CART_NO LIKE '20050711%';

--��ǰ���̺�
--�ŷ�ó,��ǰ�з���
--�ְ��ǸŰ�, �ּ��ǸŰ�
SELECT PROD_LGU ��ǰ�з�
    ,  PROD_BUYER �ŷ�ó
    ,  MAX(PROD_SALE) �ִ��ǸŰ�
    ,  MIN(PROD_SALE) �ּ��ǸŰ�
    ,  COUNT(PROD_ID) �ڷ��
FROM PROD
GROUP BY PROD_LGU , PROD_BUYER
ORDER BY 1 ASC, 2 ASC;

--��ٱ��� ���̺�
-- ȸ��,��ǰ�з���
--���ż������, ���ż����հ�, �ڷ��
--Alias ȸ��ID, ��ǰ�з�, ���ż������, ���ż����հ�, �ڷ��
--ȸ��ID, ��ǰ�з���
SELECT CART_MEMBER              ȸ��ID
    ,  SUBSTR(CART_PROD,1,4)    ��ǰ�з�
    ,  ROUND(AVG(CART_QTY),2)   ���ż������
    ,  SUM(CART_QTY)            ���ż����հ�
    ,  COUNT(CART_NO)           �ڷ��
FROM CART
GROUP BY CART_MEMBER, SUBSTR(CART_PROD,1,4)
ORDER BY 1, 2;

--ȸ�����̺�
--����(�ּ�1�� 2�ڸ�), ���ϳ⵵��
--���ϸ������, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ڷ�� �˻�
--Alias ����, ���Ͽ���, ���ϸ������, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ڷ��
SELECT SUBSTR(MEM_ADD1,1,2) ����
    ,  SUBSTR(MEM_BIR,1,2) ���ϳ⵵
    ,  ROUND(AVG(MEM_MILEAGE)) ���ϸ������
    ,  SUM(MEM_MILEAGE) ���ϸ����հ�
    ,  MAX(MEM_MILEAGE) �ְ��ϸ���
    ,  MIN(MEM_MILEAGE) �ּҸ��ϸ���
    ,  COUNT(MEM_ID) �ڷ��
FROM MEMBER
GROUP BY SUBSTR(MEM_ADD1,1,2), SUBSTR(MEM_BIR,1,2)
ORDER BY 1, 2;

--��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó�ּҸ� ��ȸ
--�ǸŰ��� 10���� ����
--�ŷ�ó�ּ� �λ��� ���
SELECT P.PROD_ID ��ǰ�ڵ�
    ,  P.PROD_NAME ��ǰ��
    ,  L.LPROD_NM �з���
    ,  B.BUYER_ADD1 �ŷ�ó�ּ�
FROM PROD P, BUYER B, LPROD L
WHERE B.BUYER_ADD1 LIKE '%�λ�%'
AND P.PROD_SALE <= 100000
AND P.PROD_BUYER = B.BUYER_ID
AND P.PROD_LGU = L.LPROD_GU;

--ANSI
SELECT P.PROD_ID ��ǰ�ڵ�
    ,  P.PROD_NAME ��ǰ��
    ,  L.LPROD_NM �з���
    ,  B.BUYER_ADD1 �ŷ�ó�ּ�
FROM PROD P INNER JOIN BUYER B ON P.PROD_BUYER = B.BUYER_ID
            INNER JOIN LPROD L ON P.PROD_LGU = L.LPROD_GU
WHERE B.BUYER_ADD1 LIKE '%�λ�%'
AND P.PROD_SALE <= 100000;

--��ǰ�԰����̺�
--2005�⵵ 1�� �ŷ�ó��(�ŷ�ó�ڵ�, �ŷ�ó��) ���Աݾ� �˻� (���Աݾ� = ���Լ��� * ���Դܰ�)
--Alias �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ�
SELECT BUYER_ID �ŷ�ó�ڵ�
    ,  BUYER_NAME �ŷ�ó��
    ,  SUM(BUY_COST*BUY_QTY) ���Աݾ�
FROM BUYPROD A,BUYER B,PROD C
WHERE A.BUY_PROD = C.PROD_ID
AND C.PROD_BUYER = B.BUYER_ID
AND BUY_DATE LIKE '05/01%'
GROUP BY BUYER_ID, BUYER_NAME;

--ANSI
SELECT BUYER_ID �ŷ�ó�ڵ�
    ,  BUYER_NAME �ŷ�ó��
    ,  SUM(BUY_COST*BUY_QTY) ���Աݾ�
FROM PROD P INNER JOIN BUYER B ON P.PROD_BUYER = B.BUYER_ID
            INNER JOIN BUYPROD B ON B.BUY_PROD = P.PROD_ID
WHERE BUY_DATE LIKE '05/01%'
GROUP BY BUYER_ID, BUYER_NAME
ORDER BY SUM(BUY_COST*BUY_QTY) DESC;




