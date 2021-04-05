--�ŷ�ó�ڵ尡 P30203�� ���������� ���� �ŷ�ó�� �˻�
--Alias �ŷ�ó�ڵ�, �ŷ�ó, �ּ�
SELECt A.BUYER_ID �ŷ�ó�ڵ�
    ,  A.BUYER_NAME �ŷ�ó
    ,  A.BUYER_ADD1 ||' '|| A.BUYER_ADD2 �ּ�
FROM BUYER A, BUYER B
WHERE B.BUYER_ID = 'P30203'
AND SUBSTR(A.BUYER_ADD1,1,2) = SUBSTR(B.BUYER_ADD1,1,2)
ORDER BY A.BUYER_ID;

--����ȣ ȸ���� ������ ������ ������ ���� ȸ���� ����Ʈ
--ȸ��ID, ȸ����, ����
SELECT A.MEM_ID ȸ��ID
    ,  A.MEM_NAME ȸ����
    ,  A.MEM_JOB ����
FROM MEMBER A, MEMBER B
WHERE B.MEM_NAME LIKE '����ȣ'
AND A.MEM_JOB = B.MEM_JOB
ORDER BY A.MEM_ID;

--�ŷ�ó �� 2005�⵵ �ŷ���Ȳ
--����� 0�� �ŷ�ó�� ���ؼ� ���� �⵵ ��� ����
--���ʵ����� ����
--�ŷ���Ȳ : �԰����� �� SUM(PROD_COST)
--Alias �ŷ�óID, �ŷ�ó��, �ŷ���Ȳ
SELECT A.BUYER_ID
    ,  A.BUYER_NAME
    ,  NVL(SUM(B.PROD_COST),0)
FROM BUYER A, PROD B, BUYPROD C
WHERE A.BUYER_ID = B.PROD_BUYER(+)
AND B.PROD_ID = C.BUY_PROD(+)
AND C.BUY_DATE LIKE '05/%'
GROUP BY A.BUYER_ID, A.BUYER_NAME
ORDER BY A.BUYER_ID;

--ANSI (LEFT OUTER JOIN)
SELECT A.BUYER_ID �ŷ�óID
    ,  A.BUYER_NAME �ŷ�ó��
    ,  NVL(SUM(B.PROD_COST),0) �ŷ���Ȳ
FROM BUYER A LEFT OUTER JOIN PROD B ON A.BUYER_ID = B.PROD_BUYER
             LEFT OUTER JOIN BUYPROD C
             ON (B.PROD_ID = C.BUY_PROD AND C.BUY_DATE LIKE '05/%')
GROUP BY A.BUYER_ID, A.BUYER_NAME
ORDER BY A.BUYER_ID;

--2005�⵵ ���� ��� ��ǰ�з���
--���� ��Ȳ
--Alias ��(CART_NO) ��ǰ�з�(LPROD_NM) ����ݾ�(PROD_SALE*CART_QTY)
SELECT SUBSTR(CART_NO,5,2) ��
    ,  LPROD_NM ��ǰ�з�
    ,  SUM(PROD_SALE*CART_QTY) ����ݾ�
FROM LPROD LEFT OUTER JOIN PROD ON LPROD_GU = PROD_LGU
          LEFT OUTER JOIN CART ON  (CART_PROD = PROD_ID AND SUBSTR(CART_NO,1) LIKE '2005%')
GROUP BY SUBSTR(CART_NO,5,2), LPROD_NM
ORDER BY SUBSTR(CART_NO,5,2), SUM(PROD_SALE*CART_QTY) DESC;

--2005�⵵ �Ǹŵ� ��ǰ �� 5ȸ �̻��� �Ǹ�Ƚ�� �ִ� ��ǰ ��ȸ
--��ǰ�ڵ�, ��ǰ��, �Ǹ�Ƚ��
SELECT A.PROD_ID ��ǰ�ڵ�
    ,  A.PROD_NAME ��ǰ��
    ,  COUNT(CART_NO) �Ǹ�Ƚ��
FROM   PROD A, CART B
WHERE  A.PROD_ID = B.CART_PROD
AND    CART_NO LIKE '2005%'
GROUP BY A.PROD_ID, A.PROD_NAME
HAVING COUNT(CART_NO) >= 5
ORDER BY A.PROD_ID;

--��ǰ�з� ��ǻ����ǰ(P101)�� ��ǰ�� 2005�⵵ ������ �Ǹ� ��ȸ
--�Ǹ���, �Ǹűݾ�(5�鸸 �ʰ��� ��츸), �Ǹż���)
SELECT   TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8),'YYYYMMDD'),'YYYY"��" MM"��" DD"��"') �Ǹ���
    ,    TO_CHAR(SUM(CART_QTY*PROD_SALE),'L999,999,999') �Ǹűݾ�
    ,    SUM(CART_QTY) �Ǹż���
FROM     PROD, CART
WHERE    PROD_ID = CART_PROD
AND      CART_NO LIKE '2005%'
AND      PROD_LGU LIKE 'P101'
GROUP BY TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8),'YYYYMMDD'),'YYYY"��" MM"��" DD"��"')
HAVING   SUM(CART_QTY*PROD_SALE) > 5000000
ORDER BY 2 DESC;









