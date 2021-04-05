/*
�ŷ�ó�� BUYER_NAME�� �˾Ƴ��� ���ؼ���
1. BUYPROD���̺��� BUY_PROD�÷��� PROD���̺��� PROD_ID�÷��� ���� PROD_BUYER�� �˾Ƴ���
2. PROD���̺��� PROD_BUYER�÷��� BUYER���̺��� BUYER_ID�÷��� ���� BUYER���̺��� BUYER_NAME�� �˾Ƴ�
*/

--2005�⵵ ���� �Ǹ� ��Ȳ
--Alias �Ǹſ�(CART_NO), �Ǹż���, �Ǹűݾ�(�Ǹż���*�ǸŰ�)
SELECT SUBSTR(CART_NO,5,2) �Ǹſ�
    ,  SUM(CART_QTY) �Ǹż���
    ,  TO_CHAR(SUM(CART_QTY*PROD_SALE),'L999,999,999,999') �Ǹűݾ�
FROM CART,PROD
WHERE CART_NO LIKE '2005%'
AND CART_PROD = PROD_ID
GROUP BY SUBSTR(CART_NO,5,2)
ORDER BY 1;

--ANSI
SELECT SUBSTR(CART_NO,5,2) AS �Ǹſ�
    ,  TO_CHAR(SUM(CART_QTY),'999,999') AS �Ǹż���
    ,  TO_CHAR(SUM(CART_QTY*PROD_SALE),'L999,999,999,999') AS �Ǹűݾ�
FROM CART INNER JOIN PROD ON CART_PROD = PROD_ID
WHERE CART_NO LIKE '2005%'
GROUP BY SUBSTR(CART_NO,5,2)
ORDER BY 1;

--OUTER JOIN
--�ڽ����̺� ���� �θ����̺��� �ڷ� ���� ����

--��ü �з��� ��ǰ�ڷ���� �˻� ��ȸ
--Alias �з��ڵ�, �з���, ��ǰ�ڷ��
SELECT * FROM LPROD;

--INNER JOIN
SELECT LPROD_GU �з��ڵ�
    ,  LPROD_NM �з���
    ,  COUNT(PROD_LGU) ��ǰ�ڷ��
FROM LPROD, PROD
WHERE LPROD_GU = PROD_LGU
GROUP BY LPROD_GU, LPROD_NM;

--ANSI
SELECT LPROD_GU �з��ڵ�
    ,  LPROD_NM �з���
    ,  COUNT(PROD_LGU) ��ǰ�ڷ��
FROM LPROD INNER JOIN PROD ON LPROD_GU = PROD_LGU
GROUP BY LPROD_GU, LPROD_NM;

--OUTER JOIN
SELECT LPROD_GU �з��ڵ�
    ,  LPROD_NM �з���
    ,  COUNT(PROD_LGU) ��ǰ�ڷ��
FROM LPROD, PROD
WHERE LPROD_GU = PROD_LGU(+)
GROUP BY LPROD_GU, LPROD_NM;

--ANSI
SELECT LPROD_GU �з��ڵ�
    ,  LPROD_NM �з���
    ,  COUNT(PROD_LGU) ��ǰ�ڷ��
FROM LPROD OUTER JOIN PROD ON LPROD_GU = PROD_LGU(+)
GROUP BY LPROD_GU, LPROD_NM;

--��ü��ǰ�� 2005�� 1�� �԰������ �˻� ��ȸ
--Alias ��ǰ�ڵ�, ��ǰ��, �԰����
SELECT PROD_ID
    ,  PROD_NAME
    ,  SUM(BUY_QTY)
FROM PROD, BUYPROD
WHERE PROD_ID = BUY_PROD(+)
AND BUY_DATE LIKE '05/01%'
GROUP BY PROD_ID, PROD_NAME;

--ANSI
SELECT PROD_ID      prodId
    ,  PROD_NAME    prodName
    ,  NVL(SUM(BUY_QTY),0)
FROM PROD LEFT OUTER JOIN BUYPROD ON (PROD_ID = BUY_PROD AND BUY_DATE LIKE '05/01%')
GROUP BY PROD_ID, PROD_NAME;

--LEFT/RIGHT OUTER JOIN
--OUTER JOIN ��� �� ���� / �����ʿ� ���Ը� �ư� ��
--���ϴ� �÷��� ��� �ڷḦ ����ϱ� ����

--��ü ȸ�� 2005�� 4�� ������Ȳ ��ȸ
--Alias ȸ��ID, ����, ���ż����� ��
SELECT MEM_ID               memId       --ȸ��ID
    ,  MEM_NAME             memName     --����
    ,  NVL(SUM(CART_QTY),0) cartQtySum  --���ż���_��
FROM MEMBER LEFT OUTER JOIN CART 
ON (MEM_ID = CART_MEMBER AND SUBSTR(CART_NO,1,6) LIKE '200504%' )
GROUP BY MEM_ID, MEM_NAME
ORDER BY MEM_ID;

--ȸ��ID 'h001'�� ���� ���ϸ��� �������� �̻��� ȸ���� �˻�
--Alias ȸ��ID, ����, ���ϸ���
SELECT B.MEM_ID
    ,  B.MEM_NAME
    ,  B.MEM_MILEAGE
FROM MEMBER A, MEMBER B
WHERE A.MEM_ID = 'h001'
AND A.MEM_MILEAGE <= B.MEM_MILEAGE
ORDER BY B.MEM_MILEAGE DESC;



