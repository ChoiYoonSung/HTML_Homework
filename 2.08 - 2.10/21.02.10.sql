--��ٱ��� ���̺� ���ں� �ְ� ���ż���
--ȸ�� �ֹ���ȣ, ��ǰ, ����
--Alias ȸ�� ���� ��ǰ ����
SELECT A.CART_MEMBER ȸ��ID
    ,  TO_CHAR(TO_DATE(SUBSTR(A.CART_NO,1,8),'YYYYMMDD'),'YYYY"��" MM"��" DD"��"') ����
    ,  A.CART_PROD ��ǰ
    ,  A.CART_QTY ����
FROM CART A
WHERE A.CART_QTY = (
        SELECT MAX(B.CART_QTY)
        FROM CART B
        WHERE SUBSTR(A.CART_NO,1,8) = SUBSTR(B.CART_NO,1,8)
        )
ORDER BY SUBSTR(A.CART_NO,1,8);

--īƼ�� ���δ�Ʈ
SELECT R.A, R.B, R.C
    ,  S.C, S.D, S.E
FROM R, S;
--CROSS JOIN
SELECT R.A, R.B, R.C
    ,  S.C, S.D, S.E
FROM R CROSS JOIN S;

--��������
SELECT R.A, R.B, R.C
    ,  S.C, S.D, S.E
FROM R, S
WHERE R.C = S.C;
--INNER JOIN
SELECT R.A, R.B, R.C
    ,  S.C, S.D, S.E
FROM R INNER JOIN S ON R.C = S.C;

--�ܺ�����
SELECT R.A, R.B, R.C
    ,  S.C, S.D, S.E
FROM R, S
WHERE R.C = S.C(+);
--OUTER JOIN
SELECT R.A, R.B, R.C
    ,  S.C, S.D, S.E
FROM R LEFT OUTER JOIN S ON R.C = S.C;

SELECT R.A, R.B, R.C
    ,  S.C, S.D, S.E
FROM R FULL OUTER JOIN S ON R.C = S.C;

---------
--UNION
--������ ����Ϸ��� ���� ������ �����ؾ� ��
--�����Ǵ� �÷��� �ڷ����� ����
SELECT MEM_ID, MEM_NAME
FROM MEMBER
UNION ALL
SELECT TO_CHAR(EMPLOYEE_ID), LAST_NAME || FIRST_NAME
FROM HR.EMPLOYEES;

--A UNION B : �ߺ������Ͽ� �� ���(�ߺ��� ������ ���� ���), �ڵ����ĵ�
--A UNION ALL B : �ߺ� �����Ͽ� �� ���(�ߺ��� ������ ��� ���), �ڵ����ĵ��� ����
--A INTERSECT B : �ߺ��� �����͸� ���
--A MINUS B : �ߺ��� �����͸� ������ ������ ���

SELECT MEM_NAME
    ,  MEM_JOB
    ,  MEM_MILEAGE
FROM MEMBER
WHERE MEM_MILEAGE > 4000

UNION

SELECT MEM_NAME
    ,  MEM_JOB
    ,  MEM_MILEAGE
FROM MEMBER
WHERE MEM_JOB LIKE '�ڿ���';

--Q. ���� ������ �ٸ� ��?
--A. ������ ���߱� ���� null�� ����Ѵ�
--Q. A UNION B�� ������ �����Ǿ��ֳ�?
--A. O
--Q. �ڵ����� �� �ٸ� �÷����� ���� �� �� �ֳ�?
--A. ������ ������ ũ�� ���� �� ����

SELECT T.MEM_NAME, T.MEM_JOB, T.MEM_MILEAGE
FROM(
SELECT MEM_NAME
    ,  MEM_JOB
    ,  MEM_MILEAGE
FROM MEMBER
WHERE MEM_MILEAGE > 4000

UNION

SELECT MEM_NAME
    ,  MEM_JOB
    ,  MEM_MILEAGE
FROM MEMBER
WHERE MEM_JOB LIKE '�ڿ���'
) T
ORDER BY T.MEM_MILEAGE DESC
;

SELECT MEM_NAME
    ,  MEM_JOB
    ,  MEM_MILEAGE
FROM MEMBER
WHERE MEM_MILEAGE > 4000

INTERSECT

SELECT MEM_NAME
    ,  MEM_JOB
    ,  MEM_MILEAGE
FROM MEMBER
WHERE MEM_JOB LIKE '�ڿ���';

SELECT MEM_NAME
    ,  MEM_JOB
    ,  MEM_MILEAGE
FROM MEMBER
WHERE MEM_MILEAGE > 4000

MINUS

SELECT MEM_NAME
    ,  MEM_JOB
    ,  MEM_MILEAGE
FROM MEMBER
WHERE MEM_JOB LIKE '�ڿ���';

--��ǰ�з����̺� ��ǰ���̺� ȸ�����̺� �ڷ�� ��ȸ
SELECT 'LPROD' TABLE_ID
    ,  COUNT(*) TABLE_COUNT
FROM LPROD
UNION
SELECT 'PROD' TABLE_ID
    ,  COUNT (*) TABLE_COUNT
FROM PROD
UNION
SELECT 'MEMBER' TABLE_ID 
    ,  COUNT(*) TABLE_COUNT
FROM MEMBER;

--��ٱ��� ���̺�
--2005�⵵ 4���� �Ǹŵ� ��ǰ
--2005�⵵ 5���� �Ǹŵ� ��ǰ
--��� �ش�Ǵ� ��ǰ
--Alias �ǸŻ�ǰ�ڵ�, ��ǰ��
SELECT A.CART_PROD cartProd
    ,  (SELECT PROD_NAME FROM PROD WHERE PROD_ID = A.CART_PROD) prodName
FROM CART A
WHERE SUBSTR(A.CART_NO,1,6) = '200504'
INTERSECT
SELECT CART_PROD B
    ,  (SELECT PROD_NAME FROM PROD WHERE PROD_ID = B.CART_PROD)
FROM CART B
WHERE SUBSTR(B.CART_NO,1,6) = '200506';

--EXIST�� �̿��Ͽ� INTERSEcT
--P302### �߿��� P302000012 ���� ����� ���� ���̺� ����
--A�� B ���� ���̿� AND EXISTS�� �ۼ�
--B ������ ��ȣ�� ���� �� B���տ� ���������� ���´�

SELECT A.CART_PROD cartProd
    ,  (SELECT B.PROD_NAME FROM PROD B WHERE B.PROD_ID = A.CART_PROD) prodName
FROM CART A
WHERE SUBSTR(A.CART_NO,1,6) = '200504'
AND EXISTS --EXISTS : ������ | NOT EXISTS : ������
    (SELECT CART_PROD C
         ,  (SELECT D.PROD_NAME FROM PROD D WHERE D.PROD_ID = C.CART_PROD)
     FROM CART C
     WHERE SUBSTR(C.CART_NO,1,6) = '200506'
     AND C.CART_PROD = A.CART_PROD --��������(�����)
);

--2005�⵵ ���űݾ� 2õ�� �̻� ����� ���� �˻�
--Alias ȸ��ID ȸ����, �����
--SUM(CART.CART_QTY*PROD.PROD_SALE)
SELECT D.MEM_ID ȸ��ID
    ,  D.MEM_NAME ȸ����
    ,  SUM(E.CART_QTY*F.PROD_SALE) �����
FROM MEMBER D, CART E, PROD F
WHERE D.CART_MEMBER = E.MEM_ID
AND D.CART_PROD = F.PROD_ID
AND SUM(E.CART_QTY*F.PROD_SALE) > 20000000
GROUP BY D.MEM_ID, D.MEM_NAME
;

SELECT M.MEM_ID ȸ��ID
     , M.MEM_NAME ȸ����
     , '���ȸ��'
FROM   MEMBER M
WHERE  EXISTS 
(
       SELECT SUM(C.CART_QTY * P.PROD_SALE)
       FROM   CART C, PROD P
       WHERE  C.CART_PROD   = P.PROD_ID 
       AND    C.CART_MEMBER = M.MEM_ID
       AND    C.CART_NO LIKE '2005%'
       HAVING SUM(C.CART_QTY * P.PROD_SALE) > 20000000
);
