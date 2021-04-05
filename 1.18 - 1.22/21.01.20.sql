INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
VALUES(1,'F101','��ǻ����ǰ');
INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
VALUES(2, 'F102', '������ǰ');
INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
VALUES(3,'F201','����ĳ���');
INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
VALUES(4, 'F202', '����ĳ���');
INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
VALUES(5,'F301','������ȭ');
INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
VALUES(6, 'F302', 'ȭ��ǰ');
INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
VALUES(7,'F401','����/CD');
INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
VALUES(8,'F402','����');
INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NM)
VALUES(9, 'F403', '������');

SELECT *
FROM LPROD;

COMMIT;
--����

--ROLLBACK; 
--���� Ʈ������� ���ۺκ����� ���ư�(�ʱ�ȭ)

SELECT LPROD_GU, LPROD_NM
FROM LPROD
WHERE LPROD_GU = 'F102';
--��� �۾� �� SELECT�� �˼� �� ����

UPDATE LPROD 
SET LPROD_NM = '���'
WHERE LPROD_GU = 'F102';

COMMIT;

--
SELECT LPROD_GU, LPROD_NM
FROM LPROD
WHERE LPROD_GU = 'F202';

DELETE FROM LPROD
WHERE LPROD_GU = 'F202';

COMMIT;

ROLLBACK;

--��ǰ ���̺�κ��� ��� row�� columnn�� �˻�
SELECT *
FROM PROD;

--ȸ�� ���̺� ��� row, column
SELECT *
FROM MEMBER;

--Ư�� column
-- ȸ�� ���̺��� ȸ��ID, ȸ�� �̸� �˻�
SELECT MEM_ID,MEM_NAME
FROM MEMBER;

--��ǰ ���̺�κ��� ��ǰ�ڵ�, ��ǰ�� �˻�
SELECT PROD_ID, PROD_NAME
FROM PROD;

--��ǰ ���̺�κ��� ��ǰ�ڵ�� ��ǰ���� �˻�
--��, ��ǰ�ڵ尡 F10200000�� ��ǰ


--ȸ�� ���̺� ���ϸ�����12�� ���� ���� �˻�
SELECT MEM_MILEAGE ���ϸ���, MEM_MILEAGE/12
FROM MEMBER;

--��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ��� �˻�
--�Ǹűݾ� = �ǸŴܰ�(PROD_SALE)*55 �� ���
SELECT PROD_ID, PROD_NAME, PROD_SALE*55
FROM PROD;

--alias : ����� �̸��� �ٲٴ� ���
SELECT MEM_MILEAGE ���ϸ��� --���� ���� ���
     , MEM_MILEAGE/12 as ����� --�� ���� ���� ���
FROM MEMBER;

--��ǰ���̺��� PROD_ID, PROD_NAME, PROD_



