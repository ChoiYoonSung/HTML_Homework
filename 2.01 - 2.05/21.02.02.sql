CREATE TABLE S(
    C VARCHAR2(10),
    D VARCHAR2(10),
    E VARCHAR2 (10),
    CONSTRAINT PK_S PRIMARY KEY(C)
);

CREATE TABLE R(
    A VARCHAR2 (10),
    B VARCHAR2 (10),
    C VARCHAR2 (10),
    CONSTRAINT PK_R PRIMARY KEY(A),
    CONSTRAINT FK_R FOREIGN KEY(C)
        REFERENCES S(C)
);

INSERT INTO S (C,D,E)
VALUES ('c1','d1','e1');

INSERT INTO S(C,D,E)
VALUES ('c3','d2','e2');

INSERT INTO R(A,B,C)
VALUES ('a1', 'b1', 'c1');

INSERT INTO R(A,B,C)
VALUES ('a2', 'b2', 'c2');

--�������Ἲ : �ܷ�Ű�� �⺻Ű�� ������ �� �θ����̺� �����ϴ� �⺻Ű�� �ִ� �����͸� �ڽ����̺� �� �� �ִ�.
SELECT * FROM S;
SELECT * FROM R;

SELECT *
FROM R,S;

SELECT *
FROM S CROSS JOIN R;

SELECT A,B,C,C,D,E
FROM S,R;

SELECT R.A,R.B,R.C
      ,S.C,S.D,S.E
FROM S,R;


SELECT R.A,R.B,R.C
      ,S.C,S.D,S.E
FROM S,R
WHERE R.C = S.C;

--ANSI
SELECT R.A,R.B,R.C
      ,S.C,S.D,S.E
FROM S INNER JOIN R
ON (R.C = S.C);

--��ǰ���̺��� �ŷ�ó�� �Ｚ������ �ڷ���
--��ǰ�ڵ�, ��ǰ��, �ŷ�ó �� ��ȸ
SELECT PROD_ID ��ǰ�ڵ�
    ,  PROD_NAME ��ǰ��
    ,  BUYER_NAME �ŷ�ó��
FROM PROD, BUYER
WHERE BUYER_NAME LIKE '�Ｚ����'
AND BUYER_ID = PROD_BUYER;

--ANSI
SELECT PROD_ID ��ǰ�ڵ�
    ,  PROD_NAME ��ǰ��
    ,  BUYER_NAME �ŷ�ó��
FROM PROD INNER JOIN BUYER
ON (BUYER_NAME LIKE '�Ｚ����' AND BUYER_ID = PROD_BUYER);

--��ٱ��Ϲ�ȣ, ��ǰ�ڵ�, ���԰���, ȸ��ID, ȸ����
-- CART, MEMBER
--2005�⵵ 4�� �����ͷ� ����, ��ǰ�ڵ带 ��ǰ�з��ڵ�� �ٲٱ�
--��ٱ��Ϲ�ȣ ����� �ٲٱ�
--����, ��ǰ�з���, ȸ����, ���԰����հ踦 ���ϱ�

SELECT *
FROM CART;

SELECT TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,6), 'YYYY-MM'),'YYYY"��"MM"��"') ��ٱ��Ϲ�ȣ
    ,  SUBSTR(CART_PROD,1,4) ��ǰ�з��ڵ�
    ,  CART_MEMBER ȸ��ID
    ,  SUM(CART_QTY) ���԰���
    ,  MEM_NAME ȸ����
FROM CART, MEMBER
WHERE CART_NO LIKE '200504%'
AND CART_MEMBER = MEM_ID
GROUP BY TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,6), 'YYYY-MM'),'YYYY"��"MM"��"'), SUBSTR(CART_PROD,1,4),CART_MEMBER,MEM_NAME
ORDER BY 1,2,4;
--��, ��ǰ�з�, ȸ�� �� ���� ������ ��(�ߺ�����)


----------------
SELECT PROD_ID
    ,  PROD_LGU
    ,  LPROD_NM
FROM PROD, LPROD
WHERE PROD_LGU = LPROD_GU;

SELECT PROD_ID
    ,  PROD_NAME
    ,  PROD_BUYER
    ,  BUYER_NAME
FROM PROD, BUYER
WHERE PROD_BUYER = BUYER_ID;

SELECT CART_NO ��ٱ��Ϲ�ȣ
    ,  CART_PROD ��ٱ��ϻ�ǰ
    ,  CART_QTY ���Ű���
    ,  CART_MEMBER ȸ��ID
    ,  MEM_NAME ȸ����
FROM CART,MEMBER
WHERE CART_MEMBER = MEM_ID;

--AVG() : ��ȸ ���� �� �ش� �÷� ���� ��� ��
--DISTINCT : �ߺ��� ���� ���� | ALL : Default�ν� ��� ���� ����
--Collumn�� : NULL���� ���� | * : NULL���� ����(COUNT�Լ��� ���)
SELECT AVG(DISTINCT PROD_COST) �ߺ��������
    ,  AVG(PROD_COST) �ߺ��������
    ,  AVG(ALL PROD_COST) default�������
FROM PROD;

--��ǰ���̺��� ��ǰ�з��� ���԰��� ��� ��
SELECT PROD_LGU ��ǰ�з�
    ,  AVG(PROD_COST) ���԰���
FROM PROD
GROUP BY PROD_LGU
ORDER BY PROD_LGU;

