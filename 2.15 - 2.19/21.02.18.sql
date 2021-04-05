-- '����ġ' ��ü�� ������ �˻��Ͽ� ������ ���� ���
--�뱸 : ���
--�λ� : �泲
--���� : ��û
--����,��õ : ������
--��Ÿ : ��Ÿ
--CASE�� Ȱ��
SET SERVEROUTPUT ON
/
DECLARE
  V_BUYER BUYER.BUYER_NAME%TYPE;
  V_ADD BUYER.BUYER_ADD1%TYPE;
  V_ADD2 VARCHAR2(10);
BEGIN
  SELECT BUYER_NAME, SUBSTR(BUYER_ADD1,1,2) INTO V_BUYER, V_ADD FROM BUYER WHERE BUYER_NAME = '����ġ';
  CASE WHEN V_ADD = '�뱸' THEN V_ADD2 := '���';
       WHEN V_ADD = '�λ�' THEN V_ADD2 := '�泲';
       WHEN V_ADD = '����' THEN V_ADD2 := '�泲';
       WHEN V_ADD IN ('����', '��õ') THEN V_ADD2 := '������';
       ELSE V_ADD2 := '��Ÿ';
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE(V_BUYER || '�� �ּҴ� '|| V_ADD2 ||'�Դϴ�.');
END;
/

--WHILE
--WHILE LOOP ---- END LOOP
--1 ~ 10 ���ϱ�
DECLARE
  V_SUM NUMBER := 0;
  V_VAR NUMBER := 1;
BEGIN
  WHILE V_VAR <= 10 LOOP
    V_SUM := V_SUM + V_VAR;
    V_VAR := V_VAR + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_SUM);
END;
/
DECLARE
  V_DAN NUMBER := 2;
  V_EX NUMBER;
BEGIN
  WHILE V_DAN < 10 LOOP
    DBMS_OUTPUT.PUT_LINE(V_DAN || '��');
    V_EX := 1;
    WHILE V_EX < 10 LOOP
      DBMS_OUTPUT.PUT_LINE(V_DAN || ' x ' || V_EX || ' = ' || V_DAN*V_EX);
      V_EX := V_EX + 1;
      END LOOP;
    V_DAN := V_DAN + 1;
    END LOOP;
END;
/

DECLARE
  V_ADD NUMBER(5) := 1000;
  V_CODE CHAR(4) := '';
  V_ID NUMBER(5) := 0;
BEGIN
  SELECT MAX(LPROD_ID) INTO V_ID
  FROM LPROD;
  WHILE V_ADD <= 1005 LOOP
      V_ADD := V_ADD + 1;
      V_ID  := V_ID + 1;
        V_CODE := 'TT' || SUBSTR(TO_CHAR(V_ADD), -2);
        INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) VALUES(V_ID, V_CODE, 'LOOP TEST');
        
    END LOOP;
END;

/
ROLLBACK;

SELECT * FROM LPROD;

/
DECLARE
  i NUMBER;
BEGIN
  --i : �ڵ����� ������ ����
  FOR i IN 1..10 LOOP
      DBMS_OUTPUT.PUT_LINE('i = ' || i);
      END LOOP;
END;
/

--FOR�� ��� ������ ���

BEGIN
  FOR A IN 2..9 LOOP
  DBMS_OUTPUT.PUT_LINE(A || '��');
    FOR B IN 1..9 LOOP
      DBMS_OUTPUT.PUT_LINE(A || ' x ' || B || ' = ' || A*B);
      END LOOP;
    END LOOP;
END;
/

--���� �� for�� Ȱ�� LPROD ���̺�
--LPROD_ID, LPROD_GU, LPROD_NM ���
--�ּҰ� �ִ밪 ������ ó��
DECLARE
  V_ID LPROD.LPROD_ID%TYPE;
  V_GU LPROD.LPROD_GU%TYPE;
  V_NM LPROD.LPROD_NM%TYPE;
  V_MIN LPROD.LPROD_ID%TYPE;
  V_MAX LPROD.LPROD_ID%TYPE;
BEGIN
  SELECT MIN(LPROD_ID), MAX(LPROD_ID) INTO V_MIN, V_MAX FROM LPROD;
  FOR I IN V_MIN..V_MAX LOOP
  SELECT LPROD_ID, LPROD_GU, LPROD_NM INTO V_ID, V_GU, V_NM FROM LPROD WHERE LPROD_ID = I;
    DBMS_OUTPUT.PUT_LINE(V_ID || ' ' || V_GU || ' ' || V_NM);
    END LOOP;
END;
/

--EXCEPTION (����ó��)
--1. ���ǵ� Oracle Server Error
--2. ���� ���� ���� Oracle Server Error
--3. ����� ���� Error
--��κ��� ���ܿ����� ���� �״�� ������ �� �� �ִ�

DECLARE
  V_NM VARCHAR2(30);
BEGIN
  SELECT LPROD_NM INTO V_NM
  FROM LPROD
  WHERE LPROD_GU = 'Z101';
  
  DBMS_OUTPUT.PUT_LINE(V_NM);
  
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('���� ����' || SQLCODE || SQLERRM);
      WHEN TOO_MANY_ROWS THEN
       DBMS_OUTPUT.PUT_LINE('������ ����' || SQLCODE|| SQLERRM);
      WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('��Ÿ ����');
      
END;
/
