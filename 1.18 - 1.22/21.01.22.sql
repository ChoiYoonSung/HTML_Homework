--2021.01.22
--��ǰ �� �ǸŰ� 150,000 or 170000 or 330000 ��ǰ ��ȸ
SELECT *
FROM PROD
WHERE PROD_SALE = 150000 or PROD_SALE = 170000 or PROD_SALE = 330000;

--IN ��� (or����� �Ͱ� ����)
--WHERE �÷� IN (����) <-> ���ǿ� �������� �ʴ� Ŀ�� NOT IN
SELECT *
FROM PROD
WHERE PROD_SALE IN(170000 , 150000, 330000);

--ȸ�����̺���
--ȸ��ID�� c001 , f001 , w001�� ȸ�� �˻�
--Alias : mem_id, mem_name
SELECT MEM_ID ȸ��ID, MEM_NAME ȸ����
FROM MEMBER
WHERE MEM_ID IN('c001' , 'f001', 'w001');

--��ǰ �з����̺��� ��ǰ���̺� �����ϴ� �з��� �˻�
--�з��ڵ�(LPROD_GU) �з���(LPROD_NM)
SELECT LPROD_GU �з��ڵ�, LPROD_NM �з���
FROM LPROD
WHERE 1 = 1 AND LPROD_GU < 'P401';
--AND LPROD_GU IN('P101','P102', ... , 'P302');

--��������
SELECT LPROD_GU �з��ڵ�, LPROD_NM �з���
FROM LPROD
WHERE 1 = 1 AND LPROD_GU IN(SELECT DISTINCT PROD_LGU FROM PROD);
--WHERE���� ���� �Ǵٸ� QWERY : NESTED ��������(��ø ��������)

--����
--�ŷ�ó ���̺��� ���� ��ǰ���̺� �����ϴ� �ŷ�ó�� �˻�
--Alias : �ŷ�óID(BUYER_ID), �ŷ�ó��(BUYER_NAME)
SELECT BUYER_ID �ŷ�óID, BUYER_NAME �ŷ�ó��
FROM BUYER
WHERE BUYER_ID IN(SELECT DISTINCT PROD_BUYER FROM PROD);

--BETWEEN : ���� �� ��� ���� Ž��
--          �� ������ �Ѱ� ���� ����
-- BETWEEN A AND B
--��ǰ �� �ǸŰ� 100000 ~ 300000
SELECT *
FROM PROD
WHERE PROD_SALE BETWEEN 100000 AND 300000
ORDER BY PROD_SALE;

--ȸ�� �� ���� 1975 01 01 ~ 1976 12 31 ���̿� �¾ ȸ��
--alias : ȸ��ID ȸ���� ����
select mem_id ȸ��ID , mem_name ȸ����, mem_bir ����
from member
where mem_bir between '75/01/01' and '76/12/31';

select *
from member;







