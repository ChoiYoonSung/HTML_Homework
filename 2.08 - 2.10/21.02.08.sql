--����ȭ
--���ձ� ���� : ����-�ҿ��� - ��2����ȭ


--���� ����
/*
īƼ�����δ�Ʈ : ��� ���� ���� ����
�������� : īƼ���δ�Ʈ ������� �⺻Ű = �ܷ�Ű �� ������
�ܺ����� : ������ ��� �����͸� ���(�������ο��� �Ļ���)
�������� : �ϳ��� ���̺��� ��ġ �������� ���̺�ó�� ����
*/
--ANSI ǥ��
/*
CROSS JOIN : īƼ�����δ�Ʈ
INNER JOIN : ��������
OUTER JOIN : �ܺ�����
SELF JOIN : ��������
NATURAL JOIN : 
*/
--�����Լ� / �����Լ� �̿� �÷� GROUP BY���� ���
/*
SUM : �հ�
AVG : ���
MIN : �ּ�
MAX : �ִ�
COUNT : Ƚ��
*/
--���谡 �Ϸ�� �Ŀ� �����Լ� ��ü�� ����?
--HAVING

--JOB_ID�� �ִ�,�ּ�,���,�հ� ������ �ڿ����� ����, ��ȸ
SELECT A.JOB_ID       ����ID
    ,  MAX(B.MAX_SALARY)  �ִ뿬��
    ,  MIN(B.MIN_SALARY)  �ּҿ���
    ,  ROUND(AVG(A.SALARY))  ��տ���
    ,  ROUND(SUM(A.SALARY))  �����հ�
FROM EMPLOYEES A, JOBS B
WHERE A.JOB_ID = B.JOB_ID
GROUP BY A.JOB_ID
ORDER BY 1;

--ANSI ǥ��
SELECT A.JOB_ID       ����ID
    ,  MAX(B.MAX_SALARY)  �ִ뿬��
    ,  MIN(B.MIN_SALARY)  �ּҿ���
    ,  NVL((AVG(A.SALARY)),0)  ��տ���
    ,  NVL(ROUND(SUM(A.SALARY)),0)  �����հ�
FROM EMPLOYEES A LEFT OUTER JOIN JOBS B ON (A.JOB_ID = B.JOB_ID)
GROUP BY A.JOB_ID
ORDER BY 1;

--�Ŵ����� ��� �� �Ŵ��� �� ����� �� �ּҿ����� �޴� ����� ���� ��ȸ
--���� 6000 �̻�
SELECT MANAGER_ID �Ŵ������
    ,  MIN(SALARY) �ּҿ���
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING MIN(SALARY) >= 6000
ORDER BY MIN(SALARY) DESC;

SELECT A.MANAGER_ID �Ŵ������
    ,  MIN(A.SALARY) �ּҿ���
    ,  B.FIRST_NAME ��
    ,  B.LAST_NAME �̸�
    ,  COUNT(A.EMPLOYEE_ID) ��
FROM EMPLOYEES A, EMPLOYEES B
WHERE A.MANAGER_ID = B.EMPLOYEE_ID 
AND A.MANAGER_ID IS NOT NULL
GROUP BY A.MANAGER_ID, B.FIRST_NAME, B.LAST_NAME
HAVING MIN(A.SALARY) >= 6000
ORDER BY MIN(A.SALARY) DESC;

--ANSI
SELECT A.MANAGER_ID
    ,  MIN(A.SALARY)
    ,  B.FIRST_NAME
    ,  B.LAST_NAME
FROM EMPLOYEES A INNER JOIN EMPLOYEES B ON A.MANAGER_ID = B.EMPLOYEE_ID 
WHERE A.MANAGER_ID IS NOT NULL
GROUP BY A.MANAGER_ID, B.FIRST_NAME, B.LAST_NAME
HAVING MIN(A.SALARY) >= 6000
ORDER BY MIN(A.SALARY) DESC;

--�μ���, ��ġID, �� �μ� �� ��� �� ��, �� �μ� �� ��� ����
--��� ���� �Ҽ��� 2�ڸ� ǥ��
SELECT A.DEPARTMENT_NAME �μ���
    ,  A.LOCATION_ID ��ġID
    ,  COUNT(B.EMPLOYEE_ID) ����Ѽ�
    ,  ROUND(AVG(B.SALARY),2) �μ�����տ���
FROM DEPARTMENTS A INNER JOIN EMPLOYEES B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY A.DEPARTMENT_NAME, A.LOCATION_ID
ORDER BY 1,2;

--��������(subquery)
--SQL ���� �ȿ� �ٸ� SQL������ �ִ� ��
--�ʹ� ���� JOIN�� ���̱� ����
--��ȣ�� ����
--�����ڿ� ����� ��� �����ʿ� ��ġ
--MAIN QUERY�� SUB QUERY ������ ������ ���ο� ���� ����, �񿬰� ���������� ����
/*
SCALAR SUBQUERY : SELECT ���� ���
INLINE VIEW : FROM���� ���
NESTED SUBQUERY : WHERE  ���� ���
*/

--��ǰ�ڵ�, ��ǰ��, �ŷ�ó�ڵ�, �ŷ�ó��
--�������� �̿�
SELECT PROD_ID ��ǰ�ڵ�
    ,  PROD_NAME ��ǰ��
    ,  PROD_BUYER �ŷ�ó�ڵ�
    ,  (SELECT BUYER_NAME FROM BUYER WHERE BUYER_ID = PROD_BUYER) �ŷ�ó��
FROM PROD;

--ȸ��ID(CART_MEMBEER) ȸ���� �ֹ���ȣ ��ǰ�ڵ� ����
SELECT CART_MEMBER ȸ��ID
    ,  (SELECT MEM_NAME FROM MEMBER WHERE MEM_ID = CART_MEMBER) ȸ����
    ,  CART_NO �ֹ���ȣ
    ,  CART_PROD ��ǰ�ڵ�
    ,  CART_QTY ����
FROM CART
ORDER BY 1;

--�԰�����(BUY_DATE) ��ǰ�ڵ�(BUY_PROD), ��ǰ��, ���Լ���(BUY_QTY), ���Դܰ�(BUY_COST)
SELECT BUY_DATE �԰�����
    ,  BUY_PROD ��ǰ�ڵ�
    ,  (SELECT PROD_NAME FROM PROD WHERE PROD_ID = BUY_PROD) ��ǰ��
    ,  BUY_QTY ���Լ���
    ,  BUY_COST ���Դܰ�
FROM BUYPROD;



--�ŷ�ó�ڵ� �ŷ�ó�� ��ǰ�з��ڵ� ��ǰ�з���
SELECT BUYER_ID �ŷ�ó�ڵ�
    ,  BUYER_NAME �ŷ�ó��
    ,  BUYER_LGU ��ǰ�з��ڵ�
    ,  (
        SELECT LPROD_NM
        FROM LPROD
        WHERE LPROD_GU = BUYER_LGU
        ) ��ǰ�з���
FROM BUYER;





