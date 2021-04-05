--ȸ���̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ�
--�̸� ���� 0��0�� ����ϰ� �¾ ������ -���� �Դϴ�.
SELECT MEM_NAME || '���� '
    || TO_CHAR(MEM_BIR, 'YYYY"��" MON"��" DD"��"') || '����ϰ� �¾ ������ '
    || TO_CHAR(MEM_BIR, 'DAY"���� �Դϴ�."') �������
FROM MEMBER;
--YYYY �⵵ | MM/MON �� | DD �� | DAY ���� | HH(12/24) �� | MI �� | SS ��
--'YYYY-MM-DD HH:MI:SS'

--���û��� - optional
--�ʼ����� - mandatory

--���տ�����(||) 
--��ǰ�ڵ�(PROD_ID) ��ǰ��(PROD_NAME)

SELECT '��з��ڵ�� ' || SUBSTR(PROD_ID, 1, 4) ||'�̰�, ������ '|| SUBSTR(PROD_ID, 5) ||'�̴�.'
FROM PROD;

--�԰����̺�(BUYPROD)
--��ǰ�ڵ� ��ǰ�� �԰����� �� ���Լ��� ���� �԰��
SELECT TO_CHAR(BUY_PROD) || ' ��ǰ�� ' || TO_CHAR(BUY_DATE, 'YYYY"�� "MM"�� "DD"�Ͽ� ')
    || TO_CHAR(BUY_QTY) || '���� �԰��' �԰���Ȳ
FROM BUYPROD;

--���� �Լ�
--9 : ��������� �ڸ�, ��ȿ�� ������ ��� ���. ������ ���� ������ �����Ѵ�.
--0 : ��������� �ڸ�, ��ȿ�� ������ ��� 0���
--$,L : �޷� �� ����ȭ���ȣ
--MI : ������ ��� ������ ���̳ʽ� ǥ��, ������ ǥ��
--PR : ������ ��� "<>"��ȣ�� ���´�, ������ ǥ��
--, . : �ش� ��ġ�� "," ǥ��, �Ҽ��� ����
--X : �ش� ���ڸ� 16������ ���, �ܵ� ���

--��ǰ���̺�
--��ǰ�ڵ�, ��ǰ��, ���԰���, �Һ��ڰ���, �ǸŰ���
SELECT PROD_ID ��ǰ�ڵ�
    ,  PROD_NAME ��ǰ��
    ,  TO_CHAR(PROD_COST, 'L99,999,999') ���԰���
    ,  TO_CHAR(PROD_PRICE, 'L99,999,999') �Һ��ڰ���
    ,  TO_CHAR(PROD_SALE, 'L99,999,999') �ǸŰ���
FROM PROD;

--��ǰ���̺� ��ǰ�ڵ�, ��ǰ��, ���԰���, �Һ��ڰ���, �Ǹ�

--������ ��ȯ
--TO_NUMBER(char, fmt) : �������� ���ڿ� ���ڷ� ��ȯ
--�������� ������ ����, �������� �������ķ� Ȯ���� �� ����
SELECT TO_NUMBER('3.14159265358979'), TO_CHAR('3.14159265358979')
FROM DUAL;

SELECT TO_NUMBER('��1,200','L9,999')+1
    ,  TO_CHAR(TO_NUMBER('��1,200','L9,999')+TO_NUMBER('��1,200','L9,999') , 'L999,999')
FROM DUAL;

--ȸ�����̺�
--�̻���ȸ���� ȸ��id 2-4���ڿ� ������ ġȯ, 10�� ���Ͽ� ���ο� ȸ��id�� ����
--ȸ��id, ����ȸ��id
SELECT MEM_ID, MEM_NAME
FROM MEMBER;

SELECT MEM_ID ȸ��ID
    , SUBSTR(MEM_ID,1,1) || TRIM(TO_CHAR(SUBSTR(MEM_ID, 2, 3)+10, '099')) ����ȸ��ID
FROM MEMBER;

SELECT SUBSTR(MEM_ID,1,1) || LPAD(SUBSTR(MEM_ID, 2)+10, 3, '0') ����ȸ��
FROM MEMBER;

--TO_DATE(char, fmt) : ��¥������ ���ڿ��� DATE������ ��ȯ
--Ư������ ���� �̻� ���� ���� ���� TO_DATE(char)

SELECT TO_DATE('2021-01-28', 'YYYY-MM-DD')+65
FROM DUAL;

SELECT TO_DATE('2021-01-28')+65
FROM DUAL;

SELECT TO_DATE(SYSDATE,'YYYY-MM-DD HH:MI:SS')
FROM DUAL;

SELECT TO_DATE('20080301')
FROM DUAL;

--ȸ�����̺� �ֹε�Ϲ�ȣ(MEM_REGNO1)�� ��¥�� ġȯ, �˻�
--Alias ȸ����, �ֹε�Ϲ�ȣ, ġȯ��¥
SELECT MEM_NAME ȸ����
    ,  MEM_REGNO1 �ֹε�Ϲ�ȣ
    ,  TO_DATE(MEM_REGNO1, 'YY-MM-DD') ġȯ��¥
FROM MEMBER;

--��ٱ��� ���̺�
--��ٱ��� ��ȣ�� ��¥�� ġȯ, ���
--0000�� 0�� 00��
--Alias ��ٱ��Ϲ�ȣ, ��ǰ�ڵ�, �Ǹ���, �Ǹż�
SELECT CART_NO ��ٱ��Ϲ�ȣ
    ,  CART_PROD ��ǰ�ڵ�
    ,  TO_CHAR(TO_DATE(SUBSTR(CART_NO, 1, 8), 'YYYY-MM-DD'), 'YYYY"��" MM"��" DD"��"') �Ǹ���
    ,  CART_QTY �Ǹż�
FROM CART;

--��ü ���� 2/3 �Ϸ�


