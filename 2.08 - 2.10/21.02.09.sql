--NESTED ��������1(2021-02-09 ���⼭����..)
--NESTED �������� : WHERE���� ���� ��������
--��ǰ�з��� ��ǻ����ǰ�� ��ǰ�� ����Ʈ�� ����ϱ�
--ALIAS : ��ǰ�ڵ�, ��ǰ��, ��ǰ�з��ڵ�
SELECT PROD_ID AS ��ǰ�ڵ�
    ,  PROD_NAME AS ��ǰ��
    ,  PROD_LGU AS ��ǰ�з��ڵ�
    ,  LPROD_NM
FROM PROD, LPROD
WHERE PROD_LGU = LPROD_GU
AND LPROD_NM = '��ǻ����ǰ';

SELECT PROD_ID AS ��ǰ�ڵ�
    ,  PROD_NAME AS ��ǰ��
    ,  PROD_LGU AS ��ǰ�з��ڵ�
FROM PROD
WHERE PROD_LGU = (SELECT LPROD_GU FROM LPROD WHERE LPROD_NM = '��ǻ����ǰ');

--��ǰ�з��� ��ǻ����ǰ�� �ŷ�ó ����Ʈ�� ����ϱ�
--ALIAS : �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ�з��ڵ�
SELECT BUYER_ID
    ,  BUYER_NAME
    ,  BUYER_LGU
FROM BUYER
WHERE BUYER_LGU = (SELECT LPROD_GU FROM LPROD WHERE LPROD_NM = '��ǻ����ǰ');

--��ǰ�з��� ������ǰ�� ��ǰ���� ��Ȳ ����Ʈ�� ����ϱ�
--ALIAS : �԰�����, ��ǰ�ڵ�, ���Լ���, ���Դܰ�
--��Ʈ : ��ǰ�ڵ忡 ��ǰ�з��ڵ尡 ����.
SELECT BUY_DATE �԰�����
    ,  SUBSTR(BUY_PROD,1,4) ��ǰ�ڵ�
    ,  BUY_QTY ���Լ���
    ,  BUY_COST ���Դܰ�
FROM BUYPROD
WHERE SUBSTR(BUY_PROD,1,4) = (
        SELECT LPROD_GU
        FROM LPROD
        WHERE LPROD_NM = '������ǰ'
        );

--��ٱ������̺��� ������ ȸ���� ���� ��Ȳ
--�ֹ���ȣ, ��ǰ�ڵ�, ȸ��ID, ����
SELECT CART_NO
    ,  CART_PROD
    ,  CART_MEMBER
    ,  CART_QTY
FROM CART
WHERE CART_MEMBER = (
        SELECT MEM_ID
        FROM MEMBER
        WHERE MEM_NAME = '������'
        );

--�Ǹ�� ��ü�κ��� ���� ��ǰ�� ����Ʈ ���
--��ǰID, ��ǰ��, ��ü�ڵ�, ��ü��
SELECT PROD_ID      ��ǰID
    ,  PROD_NAME    ��ǰ��
    ,  PROD_BUYER   ��ü�ڵ�
    ,  (SELECT BUYER_NAME 
        FROM BUYER
        WHERE BUYER_ID = PROD_BUYER) ��ü��
FROM PROD
WHERE PROD_BUYER = (
        SELECT BUYER_ID
        FROM BUYER
        WHERE BUYER_NAME = '�Ǹ��');

--������ ȸ�� ���ų���
SELECT CART_NO �ֹ���ȣ
    ,  CART_PROD ��ǰ�ڵ�
    ,  (SELECT PROD_NAME 
        FROM PROD 
        WHERE PROD_ID = CART_PROD) ��ǰ��
    ,  CART_MEMBER ȸ��ID
    ,  (SELECT MEM_NAME 
        FROM MEMBER
        WHERE MEM_ID = CART_MEMBER) ȸ����
    ,  CART_QTY ����
FROM CART
WHERE CART_MEMBER = (
        SELECT MEM_ID
        FROM MEMBER
        WHERE MEM_NAME = '������'
        );

--INLINE VIEW
--��ǰ���̺� �ǸŰ� > ��ǰ����ǸŰ� ��ǰ
--��ǰ��, �ǸŰ�, ����ǸŰ�
--SCALAS / NESTED SUBQUERY
SELECT PROD_NAME ��ǰ��
    ,  PROD_SALE �ǸŰ�
    ,  (SELECT AVG(PROD_SALE) FROM PROD) ����ǸŰ�
FROM PROD, (SELECT AVG(PROD_SALE) AVG_SALE FROM PROD) A
WHERE PROD_SALE > (SELECT AVG(PROD_SALE) FROM PROD)
GROUP BY PROD_NAME, PROD_SALE;
--INLINE VIEW
SELECT PROD_NAME ��ǰ��
    ,  PROD_SALE �ǸŰ�
    ,  A.AVG_SALE ����ǸŰ�
FROM PROD, (SELECT AVG(PROD_SALE) AVG_SALE FROM PROD) A
WHERE PROD_SALE > A.AVG_SALE;

--ȸ�����̺� ���ϸ��� ��ո��ϸ������� ū ȸ�� �˻�
--ȸ���� ���ϸ��� ��ո��ϸ���
SELECT MEM_NAME ȸ���� 
    ,  MEM_MILEAGE ���ϸ���
    ,  ROUND(M.AVG_MILEAGE,2) ��ո��ϸ���
FROM MEMBER, (SELECT AVG(NVL(MEM_MILEAGE,0)) AVG_MILEAGE FROM MEMBER) M
WHERE MEM_MILEAGE > M.AVG_MILEAGE
ORDER BY 2 DESC;

--������� ��������
--�ٱ��� ������ �÷� ���� �ϳ��� ���� ���������� ���ǿ� �̿�ǰ�
--�� ����� �ٽ� �ٱ��� ������ ������ �ִ� ó�����

--��ٱ��� ���̺� ȸ���� �ְ��� ���ż����� ���� �ڷ�
--ȸ�� �ֹ���ȣ ��ǰ ����
SELECT   A.CART_MEMBER    AS "ȸ��"
     ,   A.CART_NO        AS "�ֹ���ȣ"
     ,   A.CART_PROD      AS "��ǰ"
     ,   A.CART_QTY       AS "����" 
FROM     CART A
WHERE    A.CART_QTY = (
            SELECT MAX(CART_QTY)
            FROM CART B
            WHERE B.CART_MEMBER = A.CART_MEMBER
            )
ORDER BY CART_MEMBER ASC;

--�԰����̺� ��ǰ��
--�ְ� ���Լ����� ���� �ڷ�
--�԰����� ��ǰ�ڵ� ���Լ��� ���Դܰ�
SELECT A.BUY_DATE
    ,  A.BUY_PROD
    ,  A.BUY_QTY
    ,  A.BUY_COST
FROM BUYPROD A
WHERE A.BUY_QTY = (
        SELECT MAX(B.BUY_QTY)
        FROM BUYPROD B
        WHERE B.BUY_PROD = A.BUY_PROD
        )
ORDER BY A.BUY_PROD;

--��ٱ������̺� ���ں� �ְ��� ���ż���
--ȸ�� �ֹ���ȣ ��ǰ ����
--Alias ȸ�� ���� ��ǰ ����
SELECT  A.CART_MEMBER    ȸ��ID
    ,   (SELECT MEM_NAME
         FROM MEMBER
         WHERE CART_MEMBER = MEM_ID) ȸ���̸�
    ,   TO_CHAR(TO_DATE(SUBSTR(A.CART_NO,1,8)),'YYYY"��" MM"��" DD"��"') �ֹ�����
    ,   A.CART_PROD      ��ǰ
    ,   A.CART_QTY       ����
FROM    CART A
WHERE   A.CART_QTY = (
        SELECT MAX(B.CART_QTY)
        FROM CART B
        WHERE SUBSTR(B.CART_NO,1,8) = SUBSTR(A.CART_NO,1,8)
        )
ORDER BY A.CART_NO;
