--��ǰ ���̺��� ��ǰ�з��� �ߺ����� �ʰ� �˻�
SELECT *
FROM LPROD;

SELECT *
FROM PROD;

SELECT PROD_LGU AS ��ǰ�з�
FROM PROD;

SELECT DISTINCT PROD_LGU ��ǰ�з� --DISTINCT �ߺ�����
FROM PROD;

--��ǰ ���̺��� �ŷ�ó�ڵ带 �ߺ����� �ʰ� �˻��Ͻÿ�
SELECT *
FROM PROD;

SELECT DISTINCT PROD_BUYER �ŷ�ó
FROM PROD;

SELECT DISTINCT PROD_LGU ��ǰ�з���, PROD_BUYER �ŷ�ó
FROM PROD;

--ASCENDING(��������, ASC) <-> DECENDING (��������, DESC)
--ORDER BY �� ���
--alias ���� ���� ����, DEFAULT�� ASC
--����, ��¥, ����, NULL ������ ǥ�� ����

--ȸ�����̺��� ȸ��ID, ȸ����, ����, ���ϸ��� �˻�
SELECT MEM_ID, MEM_NAME, MEM_BIR, MEM_MILEAGE
FROM MEMBER
ORDER BY MEM_ID;

SELECT mem_id ȸ��, mem_name �̸�
FROM MEMBER;

SELECT MEM_ID ȸ��ID, MEM_NAME ����, MEM_BIR ����, MEM_MILEAGE ���ϸ���
FROM MEMBER
ORDER BY ����; --alias�� ���� ����(����, MEM_NAME)

SELECT MEM_ID, MEM_NAME, MEM_BIR, MEM_MILEAGE
FROM MEMBER 
ORDER BY 3; --�˻��Ϸ��� �÷��� ������ ���� ����(3��°, ����)

SELECT MEM_ID, MEM_NAME, MEM_BIR, MEM_MILEAGE
FROM MEMBER 
ORDER BY MEM_MILEAGE, 1;
--1���� ȸ�����ϸ���(MEM_MILEAGE)�� �������� ������ �� ������ �ȵ� ���� 
--2���� ȸ�����̵�(1, MEM_ID)�� �������� ����

--��ǰ���̺��� 1���� ��ǰ�з��� �������� ���� �� 2���� �ŷ�ó�ڵ�� �������� ����
SELECT DISTINCT PROD_LGU ��ǰ�з�, PROD_BUYER �ŷ�ó
FROM PROD
ORDER BY 1, 2 DESC;

--��ǰ �� �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT *
FROM PROD
WHERE PROD_SALE = 170000; --Ư�� ���� ��ȸ�ϱ� ���ؼ� where�� ���

--��ǰ �� �ǸŰ��� 170,000���� �ƴ� ��ǰ ��ȸ
SELECT *
FROM PROD
WHERE PROD_SALE != 170000
ORDER BY PROD_SALE;

--��ǰ �� �ǸŰ��� 170,000���� �ʰ��ϴ� ��ǰ ��ȸ
SELECT *
FROM PROD
WHERE PROD_SALE > 170000
ORDER BY PROD_SALE;

--ȸ�� �� 76�⵵ 1�� 1�� ���Ŀ� �¾ ȸ���� �˻�
--�ֹε�Ϲ�ȣ ���ڸ��� ��
--alias ȸ��id ���� �� �ֹε�Ϲ�ȣ ���ڸ�

--�ǹ����� ī�� ǥ����� �ַ� �����(ex MEM_ID > memId)
SELECT MEM_ID ȸ��ID --memId
    , MEM_NAME ȸ���� --memNae
    , MEM_REGNO1 �ֹε�Ϲ�ȣ_���ڸ� --meRegno1
FROM MEMBER
WHERE MEM_REGNO1 > '760101' --���ڿ��̱⿡ ''���
ORDER BY MEM_REGNO1, MEM_NAME;

--��������
--AND ���� ��� �� / OR ���� �� �ϳ��� �� /
--�켱���� : () NOT AND OR

--��ǰ �� ��ǰ�з��� P201(���� ĳ���)�̰� �ǸŰ��� 170,000���� ��ǰ ��ȸ
select *
from prod;

SELECT *
FROM PROD
WHERE PROD_LGU = 'P201'
AND PROD_SALE = 170000;

--��ǰ �� ��ǰ�з��� P201�̰ų� �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT *
FROM PROD
WHERE PROD_LGU = 'P201'
OR PROD_SALE = 170000;

--��ǰ �� ��ǰ�з��� P201�� �ƴϰ� �ǸŰ��� 170,000���� �ƴ� ��ǰ ��ȸ
SELECT *
FROM PROD
WHERE PROD_LGU != 'P201' AND PROD_SALE != 170000;

SELECT *
FROM PROD
WHERE NOT (PROD_LGU = 'P201' OR PROD_SALE = 170000);
--��𸣰� ����

--��ǰ �� �ǸŰ��� 300,000�� �̻�, 500,000�� ������ ��ǰ �˻�
--Alias ��ǰ�ڵ�, ��ǰ��, �ǸŰ�
SELECT PROD_ID ��ǰ�ڵ�, PROD_NAME ��ǰ��, PROD_SALE �ǸŰ�
FROM PROD
WHERE PROD_SALE >= 300000 OR PROD_SALE <= 500000;

--







