--�����̺� ����
--��ǰ�԰����̺� 2005�⵵ 1�� �ŷ�ó�� ���Աݾ� �˻� (���Աݾ� = ���Լ��� * ���Դܰ�)
--vw_inamt
--�ŷ�ó�ڵ� �ŷ�ó�� ���Աݾ�

CREATE OR REPLACE VIEW VW_INAMT
AS
SELECT B.PROD_BUYER buyerid
    ,  A.BUYER_NAME buyername
    ,  SUM(C.BUY_QTY * C.BUY_COST) inamt
FROM BUYER A INNER JOIN PROD B ON A.BUYER_ID = B.PROD_BUYER
           INNER JOIN BUYPROD C ON B.PROD_ID = C.BUY_PROD
WHERE C.BUY_DATE LIKE '05/01/%'
GROUP BY B.PROD_BUYER, A.BUYER_NAME, C.BUY_DATE
ORDER BY C.BUY_DATE;

SELECT * FROM VW_INAMT;

SELECT BUYERID �ŷ�ó�ڵ�
    ,  BUYERNAME �ŷ�ó��
    ,  TO_CHAR(INAMT,'L999,999,999') ���Աݾ�
FROM  VW_INAMT
ORDER BY 3 DESC;

--PL/SQL

--���� : DECLARE
--�ʼ� : BEGIN, END
/
--PL/SQL ���� ���ʷ� ����ϱ� �� SERVEROUTPUT�� �Ѿ� �Ѵ�.
SET SERVEROUTPUT ON
/
DECLARE
  v_i       NUMBER(9,2) := 123456.78;
  v_str     VARCHAR2(20) := 'ȫ�浿';
  c_pi      CONSTANT NUMBER(8,6) := 3.141592;
  v_flag    BOOLEAN NOT NULL := TRUE;
  v_date    VARCHAR2(10) := TO_CHAR(SYSDATE, 'YYYY-MM-DD');
BEGIN
  DBMS_OUTPUT.PUT_LINE( 'v_i : ' || v_i); 
  DBMS_OUTPUT.PUT_LINE( 'v_str : ' || v_str);
  DBMS_OUTPUT.PUT_LINE( 'c_pi : ' || c_pi);
  DBMS_OUTPUT.PUT_LINE( 'v_flag : ' || v_flag);
  DBMS_OUTPUT.PUT_LINE( 'v_date : ' || v_date);
END;
/
--������ true�̸� ���� ������ ����
--������ false�̸� ���õ� ���� ���
--elsif�� ������ ����, else���� �� ���� ����

DECLARE
  V_NUM NUMBER := 37;
BEGIN
  --DBMS_OUTPUT.ENABLE;
  IF MOD(V_NUM, 2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE(V_NUM || '�� ¦��');
  ELSE
    DBMS_OUTPUT.PUT_LINE(V_NUM || '�� Ȧ��');
  END IF;
END;

/
DECLARE
  V_NUM NUMBER := 37;
BEGIN
  IF V_NUM > 90 THEN
    DBMS_OUTPUT.PUT_LINE('��');
  ELSIF V_NUM > 80 THEN
    DBMS_OUTPUT.PUT_LINE('��');
  ELSIF V_NUM > 70 THEN
    DBMS_OUTPUT.PUT_LINE('��');
  ELSE
    DBMS_OUTPUT.PUT_LINE('�й�');
  END IF;
END;
/

DECLARE
  V_AVG_SALE PROD.PROD_SALE%TYPE;
  V_SALE NUMBER := 500000;
BEGIN
  SELECT AVG(PROD_SALE) INTO V_AVG_SALE FROM PROD;
  IF V_SALE < V_AVG_SALE THEN
    DBMS_OUTPUT.PUT_LINE('��� �ܰ��� 500000 �ʰ��Դϴ�.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('��� �ܰ��� 500000 �����Դϴ�.');
  END IF;
END;
/

--ȸ�����̺� ���̵� 'e001'�� ȸ���� ���ϸ���
--5000 ������ vipȸ��, �ƴϸ� �Ϲ�ȸ������ ���
DECLARE
  V_MILEAGE NUMBER := 0;
  V_NAME MEMBER.MEM_NAME%TYPE;
BEGIN
  SELECT MEM_MILEAGE, MEM_NAME INTO V_MILEAGE, V_NAME FROM MEMBER WHERE MEM_ID = 'e001';
  IF V_MILEAGE > 5000 THEN
    DBMS_OUTPUT.PUT_LINE('VIP ȸ��');
  ELSE
    DBMS_OUTPUT.PUT_LINE('�Ϲ�ȸ��.');
  END IF;
  DBMS_OUTPUT.PUT_LINE(V_NAME || '���� ���ϸ����� ' || V_MILEAGE || '�Դϴ�.');
END;
/
--��ǰ�з� ȭ��ǰ ��ǰ�� ����ǸŰ�
--3000�̸� : �δ�, 3000 ~ 6000 ����
--6000 ~ 9000 ��δ� , 9000 ~ �ʹ���δ�

DECLARE
  V_SALE NUMBER;
BEGIN
  SELECT AVG(PROD_SALE) INTO V_SALE FROM PROD WHERE PROD_LGU = (SELECT LPROD_GU FROM LPROD WHERE LPROD_NM = 'ȭ��ǰ');
  CASE WHEN V_SALE < 3000 THEN
         DBMS_OUTPUT.PUT_LINE('�δ�');
       WHEN V_SALE >= 3000 AND V_SALE < 6000 THEN
         DBMS_OUTPUT.PUT_LINE('����');
       WHEN V_SALE >= 6000 AND V_SALE < 9000 THEN
         DBMS_OUTPUT.PUT_LINE('��δ�');
       ELSE 
         DBMS_OUTPUT.PUT_LINE('�ʹ� ��δ�');
  END CASE;
  DBMS_OUTPUT.PUT_LINE('ȭ��ǰ�� ����ǸŰ��� ' || V_SALE || '�� �Դϴ�.');
END;
/

-- ����ġ ��ü�� ������ �˻��Ͽ� ������ ���� ���
--�뱸 : ���
--�λ� : �泲
--���� : ��û
--����,��õ : ������
--��Ÿ : ��Ÿ
--CASE�� Ȱ��

DECLARE
  V_BUYER BUYER.BUYER_NAME%TYPE;
BEGIN
  SELECT SUBSTR(BUYER_ADD1,1,2) INTO V_BUYER FROM BUYER WHERE BUYER_NAME = '����ġ';
  CASE WHEN V_BUYER = '�뱸' THEN
         DBMS_OUTPUT.PUT_LINE(V_BUYER || '�� ��ġ�� ����Դϴ�.');
       WHEN V_BUYER = '�λ�' THEN
         DBMS_OUTPUT.PUT_LINE(V_BUYER || '�� ��ġ�� �泲�Դϴ�.');
       WHEN V_BUYER = '����' THEN
         DBMS_OUTPUT.PUT_LINE(V_BUYER || '�� ��ġ�� ��û�Դϴ�.');
       WHEN V_BUYER = '����' AND V_BUYER = '��õ' THEN
         DBMS_OUTPUT.PUT_LINE(V_BUYER || '�� ��ġ�� �������Դϴ�.');
       ELSE
         DBMS_OUTPUT.PUT_LINE(V_BUYER || '�� ��ġ�� ��Ÿ�Դϴ�.');
    END CASE;
END;


